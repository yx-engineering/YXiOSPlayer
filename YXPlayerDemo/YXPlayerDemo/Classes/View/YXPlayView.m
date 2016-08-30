//
//  YXPlayView.m
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/22.
//  Copyright © 2016年 YunXi. All rights reserved.
// 1.0.1

#import "YXPlayView.h"
#import "YXPlayerKit.h"
#import <AVFoundation/AVFoundation.h>

@interface YXPlayView ()
@property (nonatomic, strong) YXPlayer *player;
@end

@implementation YXPlayView

- (instancetype)init {
    self = [super init];
    //手机静音时，也有声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    //http://baobab.wdjcdn.com/1464858383234Erlebnispark.mp4
    //rtmp://live.hkstv.hk.lxdns.com/live/hks
    self.player = [YXPlayer playerWithURL:[NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"] option:[YXPlayerOption defaultOption]];
    self.player.yxAppId = @"企业APPID";
    self.player.yxStreamId = @"直播ID";
    [self addSubview:self.player.playerView];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    return self;
}

- (void)setPlay:(BOOL)play {
    _play = play;
    play ? [self.player play] : [self.player pause];
}


@end
