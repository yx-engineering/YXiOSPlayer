//
//  YXLiveStream.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/9.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveStream.h"

@implementation YXLiveStream

+ (instancetype)liveStreamWithDic:(NSDictionary *)dic {
    YXLiveStream *stream = [[YXLiveStream alloc] init];
    [stream setValuesForKeysWithDictionary:dic];
    return stream;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"hlsPlaybackUrl"]) {
        if (self.replacePlayBackUrl) {
            self.hlsPlaybackUrl = self.replacePlayBackUrl;
        }
    } else if ([key isEqualToString:@"replacePlayBackUrl"]) {
        if (value) {
            self.hlsPlaybackUrl = value;
        }
    }

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
