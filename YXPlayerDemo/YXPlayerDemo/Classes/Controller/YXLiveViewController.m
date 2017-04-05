//
//  YXLiveViewController.m
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/22.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveViewController.h"
#import "YXPlayerKit.h"
#import <AVFoundation/AVFoundation.h>

@interface YXLiveViewController ()<PLPlayerDelegate>
@property (nonatomic, strong) YXPlayer *player;
@property (nonatomic, weak) UIButton *playBtn;
@end

@implementation YXLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //手机静音时，也有声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.title = @"云犀直播";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self addSubViews];
    [self addConstraintsForSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addSubViews {
    
    self.player = [YXPlayer playerWithURL:[NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"] option:[YXPlayerOption defaultOption]];
    self.player.yxAppId = @"企业APPID";
    self.player.yxStreamId = @"直播ID";
    self.player.delegate = self; //设置代理
    [self.view addSubview:self.player.playerView];
    
    UIButton *playBtn = [[UIButton alloc] init];
    [playBtn setImage:[UIImage imageNamed:@"detail_play_icon"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"detail_pause_icon"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(didClickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    self.playBtn = playBtn;
    
    playBtn.selected = true;
    [self.player play];
}

- (void) addConstraintsForSubviews {
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.player.playerView.mas_width).multipliedBy(0.56);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.player.playerView);
        make.height.with.equalTo(@100);
    }];
}
- (void)didClickPlayBtn:(UIButton *)sender {
    self.player.playing ? [self.player pause] : [self.player play];
}


- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            [self.player.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            self.navigationController.navigationBar.hidden = YES;
        } else {
            [self.player.playerView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.height.equalTo(self.player.playerView.mas_width).multipliedBy(0.56);
            }];
            self.navigationController.navigationBar.hidden = false;
        }
        [self.view setNeedsLayout];
    } completion:nil];
}


/**
 告知代理对象播放器状态变更
 */
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    switch (state) {
            case PLPlayerStatusPlaying:
            self.playBtn.selected = YES;
            break;
            case PLPlayerStatusStopped:
            self.playBtn.selected = NO;
            break;
        default:
            self.playBtn.selected = NO;
            break;
    }
}


- (void)dealloc {
    NSLog(@"YXLiveViewController 销毁");
}


@end
