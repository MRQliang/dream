//
//  MapViewController.m
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "INTULocationManager.h"



@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>{

    CLLocationManager *locationManager;
    NSArray *listArray;
    
    
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //show a bar button on top of navigation which when clicked calls the showDoctorsAction
    UIBarButtonItem *show = [[UIBarButtonItem alloc]initWithTitle:@"Show Doctors" style:UIBarButtonItemStyleDone target:self action:@selector(showDoctors)];
    self.navigationItem.rightBarButtonItem = show;
    
//get the current location of the user.
    [self showCurrentLocation];
    _mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDoctors{
    //perform the segue with identifier "showDoctors". the segue is set in the interface builder and the current navigation controller will move from current view to whatever the view the segue is attached to
    [self performSegueWithIdentifier:@"ShowDoctors" sender:self];
}


- (void)showCurrentLocation{
    //get the current location of the user
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity
                                       timeout:10.0
                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
                                             if (status == INTULocationStatusSuccess) {
                                                 NSLog(@"%f",currentLocation.coordinate.latitude);
                                                 NSLog(@"%f",currentLocation.coordinate.longitude);
                                                 //when we get the current location zoom into that location in mkmapview
                                                 [self zoomAndAddPinToLocation:currentLocation];
                                             }
                                             else if (status == INTULocationStatusTimedOut) {
                                                 //show alert when timedout and not able to get the location
                                                      [self showAlertWithtitle:@"Error" andMessage:@"request timed out"];
                                             }
                                             else {
                                                 //show alert when  not able to get the location

                                                   [self showAlertWithtitle:@"Error" andMessage:@"Error Getting Location.Please try again later"];
                                             }
                                         }];
}




- (void)getHospitalsInLatitude:(NSString *)latitude andLongitude:(NSString *)longitude{
    //create an url with latitude,longitude, type of place you want to search.(hospitals in our case),distance to be searched and use your apikey for google places api
    
    [self showLoadingView];
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=500&types=hospital&key=AIzaSyCO03HE9RUC4AR1m-eRmUWLMBwYZSK1S4g",latitude,longitude];
    
    [self getJsonResponse:urlString success:^(NSArray *responseArray) {
        
        listArray = responseArray;
        NSLog(@"%@",listArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingView];
            //show the alert when no hospitals are found
            if (listArray.count == 0){
                [self showAlertWithtitle:@"" andMessage:@"No hospitals found within 500 meteres from this location"];
            }else{
                //if any hospitals are found add pins in those places.
                  [self addPins];
            }
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingView];

        });
    }];
    
    
    
}


-(void)getJsonResponse:(NSString *)urlStr success:(void (^)(NSArray *responseArray))success failure:(void(^)(NSError* error))failure{
    //create a nsurlsession
    NSURLSession *session = [NSURLSession sharedSession];
    //create an url from the string
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error)
                                                    failure(error);
                                                else {
                                                    //convert the recieved data to json format
                                                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                    NSArray *array = dictionary[@"results"];
                                                    //get the results and pass it to the completion block
                                                    success(array);
                                                }
                                            }];
    [dataTask resume];    
}



- (void)zoomAndAddPinToLocation:(CLLocation*)location{
    //zoom in to the current location and get hospitals in that area
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    [self getHospitalsInLatitude:lat andLongitude:lng];
}

- (void)addPins{
    //for all the hospitals recieved add a pin for each and when the pin is tapped show the hospital name and google id for that hospital
        for(int i = 0 ; i < listArray.count; i++){
            NSDictionary *hospital = listArray[i];
            NSDictionary *dictionary = hospital[@"geometry"][@"location"];
            float latitude = [dictionary[@"lat"] floatValue];
            float longitude = [dictionary[@"lng"]floatValue];
            CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = location.coordinate;
            point.title = hospital[@"name"];
            point.subtitle = hospital[@"id"];
            [self.mapView addAnnotation:point];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //adding an annotation on the map view and configure it.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    return annotationView;
}





@end
