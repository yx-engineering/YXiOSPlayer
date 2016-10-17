//
//  CommentView.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXCommentTableView;
@class YXBottomInputView;
@interface YXCommentView : UIView
@property (nonatomic, copy) NSString *streamId;
@property (nonatomic, weak) YXCommentTableView *commentTableView;
@property (nonatomic, weak) YXBottomInputView *bottomInputView;
- (void)resignTextviewFirstResponder;
@end
