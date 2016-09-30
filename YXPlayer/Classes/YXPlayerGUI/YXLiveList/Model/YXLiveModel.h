//
//  YXLiveModel.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXLiveModel : NSObject

@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *liveId;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *watchNum;
@property (nonatomic, copy) NSString *streamId;
@property (nonatomic, assign) NSInteger streamStatus;

+ (instancetype)liveModelWithDic:(NSDictionary *)dic;


@end
