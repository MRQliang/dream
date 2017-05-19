//
//  BaseViewController.m
//  
//
//  @author Qu Liang Jiayu Zhang
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add shadow to navigation bar.
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
     self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 3.0f;
     self.navigationController.navigationBar.layer.shadowOpacity = 1.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//show alertview controller with custom title and message
- (void)showAlertWithtitle:(NSString *)title andMessage:(NSString *)message{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}





#pragma mark - progess view

//show and hide the loading screen when getting data from the backend.

- (void)showLoadingView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideLoadingView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}





@end
