//
//  YXPlayView.h
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/22.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXPlayerKit.h"
//player status 改变时调用
typedef void(^StatusDidChangBlock)(PLPlayerStatus);

@class YXLiveModel;
@interface YXPlayView : UIView
@property (nonatomic, assign) BOOL play;
@property (nonatomic, strong,nullable) YXLiveModel *liveModel;
@property (nonatomic, copy,nullable) StatusDidChangBlock statusDidChangBlock;
@property (nonatomic, assign, readonly) CMTime  totalDuration;
@property (nonatomic, assign, readonly) CMTime  currentTime;
- (void)seekTo:(CMTime)time;
- (void)addTapTarget:(nullable id)target action:(nullable SEL)action;


@end
