//
//  SelectMusicViewController.m
//  ProjectDream
//
//  @author Jiayu Zhang
// 
//

#import "SelectMusicViewController.h"
#import "WebViewController.h"
#import "Constants.h"

@interface SelectMusicViewController (){
    NSArray *listArr;
}

@end

@implementation SelectMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    listArr = [[NSArray alloc]initWithObjects:kDJUrl,kDrumUrl,kViolinUrl,kPianoUrl, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender{
    //go to the next screen.webview in our case
    [self performSegueWithIdentifier:kShowWebViewSegue sender:sender];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Pass the selected object to the new view controller.
    UIButton *btn = (UIButton *)sender;
    WebViewController *webViewController = (WebViewController *)segue.destinationViewController;
    webViewController.urlString = [listArr objectAtIndex:btn.tag];
    
}


@end
