//
//  YXCommentModel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/18.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCommentModel.h"

@implementation YXCommentModel
+ (instancetype)commentModelWithDic:(NSDictionary *)dic {
    YXCommentModel *commentModel = [[YXCommentModel alloc] init];
    [commentModel setValuesForKeysWithDictionary:dic];
    return commentModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    } else if ([key isEqualToString:@"createdAt"]) {
        NSDate  *nowDate = [[NSDate  alloc] init];
        NSTimeInterval createTime = (NSTimeInterval)[value doubleValue];
        NSInteger differ = (NSInteger)([nowDate timeIntervalSince1970] - createTime);
        if (differ < 60) {
            self.time = @"刚刚";
        } else if (differ < 3600) {
            NSInteger second = (NSInteger)(differ / 60);
            self.time = [NSString stringWithFormat:@"%ld分钟前",second];
        } else {
            NSDate  *createDate = [NSDate  dateWithTimeIntervalSince1970:createTime];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            NSDate  *nowDayDate = [formatter dateFromString:[formatter stringFromDate:nowDate]];
            NSDate *createDayDate = [formatter dateFromString:[formatter stringFromDate:createDate]];
            
            NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:createDayDate toDate:nowDayDate options:0];
            NSString *createYear = [[formatter stringFromDate:createDate] substringToIndex:4];
            NSString *nowYear = [[formatter stringFromDate:nowDate] substringToIndex:4];
            if (![createYear isEqualToString:nowYear]) {
                //不是今年
                formatter.dateFormat = @"yyyy-MM-dd HH:mm";
                self.time = [formatter stringFromDate:createDate];
                return ;
            }
            if (comp.day == 0) {
                formatter.dateFormat = @"HH:mm";
                self.time = [NSString stringWithFormat:@"今天 %@", [formatter stringFromDate:createDate]];
            } else if (comp.day == 1) {
                formatter.dateFormat = @"HH:mm";
               self.time = [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:createDate]];
            } else {
                formatter.dateFormat = @"MM-dd HH:mm";
                self.time = [formatter stringFromDate:createDate];
            }
        }
    }
}
@end
