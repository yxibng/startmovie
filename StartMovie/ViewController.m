//
//  ViewController.m
//  StartMovie
//
//  Created by yxibng on 2018/12/27.
//  Copyright © 2018 yxibng. All rights reserved.
//

#import "ViewController.h"
#import "AVPlayerView.h"
#import "RootViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet AVPlayerView *playerView;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (CGImageRef)getFirstFrameOfVideoWithURL:(NSURL *)url
{
    AVURLAsset* asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetImageGenerator* imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    return [imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"startup" ofType:@"mp4"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"qidong" ofType:@"mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    player.volume = 0.0;
    self.playerView.player = player;
    
    //视频播放前会有一闪而过的效果，为了避免这种效果，做以下处理
    CGImageRef image = [self getFirstFrameOfVideoWithURL:url];
    self.playerView.layer.contents = (__bridge id)image;
    self.playerView.layer.contentsGravity = kCAGravityResizeAspectFill;
    
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[player currentItem]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.playerView.player play];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.playerView.player pause];
}

- (IBAction)goNext:(id)sender {
    
    RootViewController *vc = [RootViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.view.window.rootViewController = nav;
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)receivedBecomeActiveNotification:(NSNotification *)notification
{
    [self.playerView.player play];
}


@end
