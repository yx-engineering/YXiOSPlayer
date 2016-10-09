//
//  YXLiveModel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveModel.h"

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
@end
