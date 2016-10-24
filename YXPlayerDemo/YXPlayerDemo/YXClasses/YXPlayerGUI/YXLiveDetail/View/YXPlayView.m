//
//  YXPlayView.m
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/22.
//  Copyright © 2016年 YunXi. All rights reserved.
// 1.0.1

#import "YXPlayView.h"

#import <AVFoundation/AVFoundation.h>
#import "YXLiveModel.h"
#import "YXLiveStream.h"
#import "YXGlobalDefine.h"
@interface YXPlayView ()<PLPlayerDelegate>
@property (nonatomic, strong) YXPlayer *player;
@end

@implementation YXPlayView

- (instancetype)init {
    self = [super init];
    //手机静音时，也有声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    return self;
}

- (void)setPlay:(BOOL)play {
    _play = play;
    play ? [self.player play] : [self.player pause];
}

- (void)setLiveModel:(YXLiveModel *)liveModel {
    NSString *playUrlStr = @"";
    if (liveModel.streamStatus <= 1) {
        playUrlStr = liveModel.liveStream.rtmpLiveUrl;
        self.player = [YXPlayer playerLiveWithURL:[NSURL URLWithString:playUrlStr] option:[YXPlayerOption defaultOption]];
    } else if (liveModel.streamStatus == 2) {
        playUrlStr = liveModel.liveStream.hlsPlaybackUrl;
        self.player = [YXPlayer playerWithURL:[NSURL URLWithString:playUrlStr] option:[YXPlayerOption defaultOption]];
    }
    self.player.delegate = self;
    self.player.yxAppId = YXBusinessAppId;//@"企业APPID";
    self.player.yxStreamId = liveModel.liveStream.ID; //推流ID
    [self addSubview:self.player.playerView];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.player play];
}

- (void)addTapTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)seekTo:(CMTime)time {
    [self.player seekTo:time];
}

- (CMTime)totalDuration {
    return self.player.totalDuration;
}

- (CMTime)currentTime {
    return self.player.currentTime;
}

/**
 告知代理对象播放器状态变更
 */
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    if (self.statusDidChangBlock != nil) {
        self.statusDidChangBlock(state);
    }
}

@end
