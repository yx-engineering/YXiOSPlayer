//
//  YXCommentModel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/18.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCommentModel.h"
#import "NSString+YXExtension.h"
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
        NSString *createdAt = [NSString stringWithFormat:@"%@",value];
        self.time = [createdAt formatTime];
    }
}
@end
