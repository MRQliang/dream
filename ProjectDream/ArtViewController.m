//
//  ArtViewController.m
//  ProjectDream
//
//  @author Jiayu Zhang
//  
//

#import "ArtViewController.h"

@interface ArtViewController () <UIScrollViewDelegate>{
    UIImageView *imageView;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation ArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //to avoid the blank space on the top.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
    
}

- (void)viewWillAppear:(BOOL)animated{
    //setup just before the view appears
    [self showFirstImage];
    
    
}

- (void)showFirstImage{
    //showing the first image on the image view
    [self showNextImage:@"art1"];
    //call the method after a delay of 20 seconds
    [self performSelector:@selector(showSecondImage) withObject:nil afterDelay:20.0];

    
}


-(void)showSecondImage{
    //showing the second image on the image view

    [self showNextImage:@"art2"];
    //call the method after a delay of 20 seconds

    [self performSelector:@selector(showThirdImage) withObject:nil afterDelay:20.0];

    
}


-(void)showThirdImage{
    //showing the third image on the image view

    [self showNextImage:@"art3"];
    //call the method after a delay of 20 seconds

    [self performSelector:@selector(showFirstImage) withObject:nil afterDelay:20.0];

    
}



- (void)showNextImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(image.size.width, image.size.height);
    //if the imageview is not already present initialise it and add it to the scrollview which is already there on the main view
    if (!imageView){
        imageView = [[UIImageView alloc]init];
    }
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageView.image = image;
    [_scrollView addSubview:imageView];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
