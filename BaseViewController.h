//
//  BaseViewController.h
//  
//
//  @author Qu Liang Jiayu Zhang
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController


- (void)showAlertWithtitle:(NSString *)title andMessage:(NSString *)meessage;
- (void)showLoadingView;
- (void)hideLoadingView;


@end
