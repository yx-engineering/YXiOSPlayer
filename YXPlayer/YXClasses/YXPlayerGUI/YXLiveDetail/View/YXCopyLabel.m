//
//  YXCopyLabel.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/19.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCopyLabel.h"

@implementation YXCopyLabel

- (instancetype)init {
    self = [super init];
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapLabel)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabel)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:touch];
    [self addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerDidHidden) name:UIMenuControllerDidHideMenuNotification object:nil];
    return self;
}

-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (void)longTapLabel {
    [self becomeFirstResponder];
    self.backgroundColor = [UIColor colorWithWhite:0.89 alpha:0.95];
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                      action:@selector(copyLabelText:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[copyLink]];
    
    
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: NO];
}

- (void)didTapLabel {
    [self becomeFirstResponder];
    [UIMenuController sharedMenuController].menuVisible = NO;
    if (self.didTapLabelBlock) {
        self.didTapLabelBlock();
    }
}

-(void)copyLabelText:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

- (void)menuControllerDidHidden {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
