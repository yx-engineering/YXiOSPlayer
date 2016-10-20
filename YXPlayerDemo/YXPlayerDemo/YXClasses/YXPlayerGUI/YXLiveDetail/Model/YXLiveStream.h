//
//  YXLiveStream.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/9.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXLiveStream : NSObject
@property (nonatomic, copy) NSString *streamId; //流Id
@property (nonatomic, copy) NSString *ID; //ID
@property (nonatomic, copy) NSString *businessId;//商户Id
@property (nonatomic, assign) NSInteger status;//0:未开始, 1:直播中, 2:结束
@property (nonatomic, assign) NSInteger paid;
@property (nonatomic, copy) NSString *commentAudit;
@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, assign) long startedAt;
@property (nonatomic, assign) long *endedAt;
@property (nonatomic, copy) NSString *publishUrl; //推流地址
@property (nonatomic, copy) NSString *rtmpLiveUrl; //RTMP 协议视频地址
@property (nonatomic, copy) NSString *hlsLiveUrl; //HLS 协议视频地址
@property (nonatomic, copy) NSString *replacePlayBackUrl; //视频回放地址 当该地址为NULL时用hlsPlayBackUrl 反之用replacePlayBackUrl回放地址
@property (nonatomic, copy) NSString *hlsPlaybackUrl;


+ (instancetype)liveStreamWithDic:(NSDictionary *)dic;


@end
