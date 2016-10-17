//
//  YXCopyLabel.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/19.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidTapLabelBlock)();

@interface YXCopyLabel : UILabel
@property (nonatomic, copy) DidTapLabelBlock didTapLabelBlock;
@end
