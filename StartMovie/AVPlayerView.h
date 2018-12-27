//
//  AVPlayerView.h
//  StartMovie
//
//  Created by yxibng on 2018/12/27.
//  Copyright © 2018 sinfotek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerView : UIView

@property(nonatomic, strong) AVPlayer *player;
@property (readonly) AVPlayerLayer *playerLayer;
@end

NS_ASSUME_NONNULL_END
