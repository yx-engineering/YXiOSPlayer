//
//  YXLiveModel.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YXLiveStream;
@interface YXLiveModel : NSObject

@property (nonatomic, copy) NSString *coverUrl; //封面
@property (nonatomic, copy) NSString *liveId;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *shareUrl; //分享地址
@property (nonatomic, copy) NSString *startTime; //指定的活动时间
@property (nonatomic, copy) NSString *startFormatTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *watchNum;
@property (nonatomic, assign) NSInteger streamStatus;//0:未开始, 1:直播中, 2:结束
@property (nonatomic, strong) YXLiveStream *liveStream;
@property (nonatomic, assign, getter=isEnded) bool ended;
@property (nonatomic, assign, getter=isAutoPlay) bool autoPlay;

+ (instancetype)liveModelWithDic:(NSDictionary *)dic;


@end
