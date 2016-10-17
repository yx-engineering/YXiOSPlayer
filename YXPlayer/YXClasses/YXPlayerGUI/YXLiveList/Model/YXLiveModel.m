//
//  YXLiveModel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveModel.h"
#import "YXLiveStream.h"

@implementation YXLiveModel
+ (instancetype)liveModelWithDic:(NSDictionary *)dic {
    YXLiveModel *model = [[YXLiveModel alloc] init];;
    if (model) {
        [model setValuesForKeysWithDictionary:dic];
    }
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.liveId = value;
    }
}

- (void)setCoverUrl:(NSString *)coverUrl {
    if (coverUrl) {
        _coverUrl = [NSString stringWithFormat:@"%@!480",coverUrl];
    }
}

- (void)setStartTime:(NSString *)startTime {
    _startTime = startTime;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:startTime.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
    _startFormatTime = [dateFormatter stringFromDate:date];
}

- (void)setLiveStream:(YXLiveStream *)liveStream {
    _liveStream = liveStream;
    self.streamStatus = liveStream.status;
    NSTimeInterval now = [[[NSDate alloc] init] timeIntervalSince1970];
    _ended = (((_startTime.doubleValue + 3600 * 15) > now) && (self.streamStatus != 0));
    _autoPlay = ((_startTime.doubleValue < now) && ((_startTime.doubleValue + 3600 * 15) > now) && (liveStream.startedAt == 0) && (liveStream.endedAt == 0));
}

@end
