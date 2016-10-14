//
//  YXCalculateTimeLabel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/10.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCalculateTimeLabel.h"

@interface YXCalculateTimeLabel ()

@end

@implementation YXCalculateTimeLabel

- (instancetype)init {
    self = [super init];
    self.text = @"00:00:00/00:00:00";
    self.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    self.font = [UIFont systemFontOfSize:12];
    return self;
}

- (void)setCurrentTime:(double)currentTime {
    _currentTime = currentTime;
    NSString *formatterStr = [self getFormatterStrWithTimeValue:_currentTime];
    self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(0, 8) withString:formatterStr];
}

- (void)setTotalTime:(double)totalTime {
    _totalTime = totalTime;
    NSString *formatterStr = [self getFormatterStrWithTimeValue:_totalTime];
    self.text = [self.text stringByReplacingCharactersInRange:NSMakeRange(9, 8) withString:formatterStr];
}

//timeValue的单位是：秒
- (NSString *)getFormatterStrWithTimeValue:(double)timeValue {
    //时
    NSInteger hour = timeValue / 3600;
    //分
    NSInteger minute = ((long)timeValue % 3600) / 60;
    //秒
    NSInteger seconde = (long)timeValue % 60;
    NSString *formatterStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,minute,seconde];
    return formatterStr;
}


@end
