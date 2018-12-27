//
//  AVPlayerView.m
//  StartMovie
//
//  Created by yxibng on 2018/12/27.
//  Copyright © 2018 sinfotek. All rights reserved.
//

#import "AVPlayerView.h"

@implementation AVPlayerView

- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

// Override UIView method
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}
@end
