//
//  YXPlayer.h
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/23.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PLPlayerKit/PLPlayer.h>
@interface YXPlayer : PLPlayer
@property (nonatomic, copy,nullable) NSString *yxAppId;
@property (nonatomic, copy,nullable) NSString *yxStreamId;
@end
