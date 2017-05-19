//
//  BusinessDetailViewController.m
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import "BusinessDetailViewController.h"

@interface BusinessDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation BusinessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//show the details in text view.
    _textView.text = _detailString;
    self.edgesForExtendedLayout = UIRectEdgeNone;

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
