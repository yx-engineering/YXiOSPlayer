//
//  YXLiveDetailViewController.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DidUpdateStreamStatus)(NSInteger streamStatus);
@class YXLiveModel;
@interface YXLiveDetailViewController : UIViewController
@property (nonatomic, copy) DidUpdateStreamStatus didUpdateStreamStatus;
@property (nonatomic, strong) YXLiveModel *liveModel;
@end
