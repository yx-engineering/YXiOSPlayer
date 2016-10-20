//
//  NSString+YXExtension.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "NSString+YXExtension.h"

@implementation NSString (YXExtension)
- (NSString *)yx_formatTime {
    NSTimeInterval selfTimeInterval = self.doubleValue;
    NSDate *selfDate = [[NSDate alloc] initWithTimeIntervalSince1970:selfTimeInterval];
    NSDate *nowDate = [[NSDate  alloc] init];
    NSInteger differ = (NSInteger)([nowDate timeIntervalSince1970] - selfTimeInterval);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //self 是未来的时间
    if (differ < 0) {
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dateFormatter stringFromDate:selfDate];
    }
    //Self是过去的时间
    else if (differ < 60) {
        return @"刚刚";
    } else if (differ < 3600) {
        NSInteger minute = (NSInteger)(differ / 60);
        return [NSString stringWithFormat:@"%ld分钟前",minute];
    } else {
        dateFormatter.dateFormat = @"yyyy";
        NSString *selfYear = [dateFormatter stringFromDate:selfDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        //不是今年
        if (![selfYear isEqualToString:nowYear]) {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
            return [dateFormatter stringFromDate:selfDate];
        } else { //今年
            //比较相差几天，日期一定只能精确到天，否则结果都不准确
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            //精确到天的日期
            NSDate *selfDayDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:selfDate]];
            NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:selfDayDate toDate:nowDate options:0];
            if (comp.day == 0 || comp.day == 1 || comp.day == 2) {
                dateFormatter.dateFormat = @"HH:mm";
                NSString *day = comp.day == 0 ? @"今天" : comp.day == 1 ? @"昨天" : @"前天";
                return [NSString stringWithFormat:@"%@ %@",day,[dateFormatter stringFromDate:selfDate]];
            } else {
                dateFormatter.dateFormat = @"MM-dd HH:mm";
                return [dateFormatter stringFromDate:selfDate];
            }
        }
    }
}

@end
