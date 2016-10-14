//
//  YXLiveCollectionCell.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXLiveModel;
@interface YXLiveCollectionCell : UICollectionViewCell
@property (nonatomic, strong) YXLiveModel *liveModel;
@property (nonatomic, assign) NSInteger streamStatus;//0:未开始, 1:正在直播, 2:已结束
@end
