//
//  BottomInputView.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXBottomInputView;
@protocol YXBottomInputViewDelegate <NSObject>

- (void)bottomInputView:(YXBottomInputView* )bottomInputView sendMessage:(NSString *)message;

@end

@interface YXBottomInputView : UIView
@property (nonatomic, weak) id<YXBottomInputViewDelegate> delegate;
@property (nonatomic, weak) UITextView *textView;
@end
