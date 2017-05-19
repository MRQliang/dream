//
//  MusicViewController.m
//  ProjectDream
//
//  @author Jiayu Zhang
//  
//

#import "MusicViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface MusicViewController (){
    AVQueuePlayer* audioPlayer;
    UIWebView *webViewBG;
}

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *plyBtn;


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //create webview which can show the gif
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"music_page" ofType:@"gif"];
    NSData *gif = [NSData dataWithContentsOfFile:filePath];
    webViewBG = [[UIWebView alloc] initWithFrame:self.imageView.frame];
    webViewBG.backgroundColor = [UIColor blackColor];
    [webViewBG loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@"http://"]];
    webViewBG.userInteractionEnabled = NO;
    webViewBG.scalesPageToFit=YES;
    webViewBG.contentMode = UIViewContentModeScaleToFill;
   // [self.view addSubview:webViewBG];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender{
    
    //add the already created webview to the screen above the imageview
    [self.view addSubview:webViewBG];

    //check if audio player is already created. if not create and add the 4 mp3 songs to it
    if(!audioPlayer){
        NSString* path1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp3"];
        NSURL* file1 = [NSURL fileURLWithPath:path1];
        NSString* path2 = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"mp3"];
        NSURL* file2 = [NSURL fileURLWithPath:path2];
        NSString* path3 = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"mp3"];
        NSURL* file3 = [NSURL fileURLWithPath:path3];
        NSString* path4 = [[NSBundle mainBundle] pathForResource:@"4" ofType:@"mp3"];
        NSURL* file4 = [NSURL fileURLWithPath:path4];
        
        
        AVPlayerItem *firstItem = [AVPlayerItem playerItemWithURL: file1];
        AVPlayerItem *secondItem = [AVPlayerItem playerItemWithURL: file2];
        AVPlayerItem *thirdItem = [AVPlayerItem playerItemWithURL: file3];
        AVPlayerItem *fourthItem = [AVPlayerItem playerItemWithURL: file4];
        
        audioPlayer = [AVQueuePlayer queuePlayerWithItems:[NSArray arrayWithObjects:firstItem, secondItem,thirdItem,fourthItem,nil]];
    }
    
    //play the audio
    [audioPlayer play];
}


- (IBAction)pause:(id)sender{
    //pause the audio
    [audioPlayer pause];
    [webViewBG removeFromSuperview];
}

- (IBAction)next:(id)sender{
    //go to the next audio
    [audioPlayer advanceToNextItem];
}

- (IBAction)previous:(id)sender{
    //go tto the previous audio
    NSUInteger i = [audioPlayer.items indexOfObject:audioPlayer.currentItem];
    NSLog(@"%lu", (unsigned long)audioPlayer.items.count);
    NSLog(@"%lu",(unsigned long)i);
    
}

- (IBAction)stop:(id)sender{
    //stop the audio
    [webViewBG removeFromSuperview];
    [audioPlayer pause];
    audioPlayer = nil;
    

}



@end
