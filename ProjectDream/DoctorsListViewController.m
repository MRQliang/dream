//
//  DoctorsListViewController.m
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import "DoctorsListViewController.h"
#import "Doctor+CoreDataClass.h"
#import "AppDelegate.h"
#import "AddDoctorViewController.h"

@interface DoctorsListViewController ()<UITableViewDelegate, UITableViewDataSource, DoctorProtocol>{
    NSArray *listArr;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@implementation DoctorsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //Do any setup when the view is about to appear
    [super viewWillAppear:animated];
    [self getTheList];
}


-(void)newDoctorAdded{
    //protocol method.this will be called when a new doctor is added in te next screen
    [self getTheList];
}



- (void)getTheList{
    //get the contect from appdelegate on which we perform the core data operations
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
   //create a fetch request to fetch the objects from core data
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Doctor"];
    //execute the fetch request
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (!results) {
        //show alert if there is an error
        [self showAlertWithtitle:@"Error" andMessage:error.localizedDescription];
    }else{
        //reload the table if there is new data
        listArr = results;
        [self.tableView reloadData];

    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //number of sections in table view
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //number of rows in each section
    return listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //create and configure the cell.
    static NSString *reuseCellIdentifier = @"cell";
    //reuses the same cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseCellIdentifier];
    }
    Doctor *doctor = listArr[indexPath.row];
    cell.textLabel.text = doctor.name;
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //set the delegate of the next view controller to the current view controller
    AddDoctorViewController *addDoctorViewController = (AddDoctorViewController *)segue.destinationViewController;
    addDoctorViewController.delegate = self;
    
    
}





@end
