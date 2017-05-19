//
//  RobotViewController.m
//  ProjectDream
//
//  @author Jiayu Zhang
//  
//

#import "RobotViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WebViewController.h"
#import "Constants.h"

@interface RobotViewController (){
    AVPlayer *player;

}

@property (nonatomic, weak) IBOutlet UIView *subView;

@end

@implementation RobotViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //this block of code is called after the view appears on the screen.
    //create a video player with video resource in our bundle , add it to the view and start playing it automatically
    NSString *path = [[NSBundle mainBundle]pathForResource:@"robotVideo" ofType:@"mp4"];
    NSURL *videoURL = [NSURL fileURLWithPath:path];
    player = [AVPlayer playerWithURL:videoURL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = CGRectMake(0, 0, _subView.frame.size.width , _subView.frame.size.height);
    [self.subView.layer addSublayer:playerLayer];
    [player play];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated{
    //when the view disappears stop the player
    [super viewWillDisappear:animated];
    [player pause];
    player = nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    WebViewController *webViewController = (WebViewController *)segue.destinationViewController;
    webViewController.urlString = kRobotUrl;
}


@end
