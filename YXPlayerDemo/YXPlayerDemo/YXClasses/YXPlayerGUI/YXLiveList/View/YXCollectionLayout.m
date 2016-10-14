//
//  YXCollectionLayout.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCollectionLayout.h"

@implementation YXCollectionLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        self.minimumInteritemSpacing = 8;
        self.minimumLineSpacing = 10;
        CGFloat w = ([UIScreen mainScreen].bounds.size.width - 20 - 8) * 0.5;
        CGFloat h = w * 0.56 + 38;
        self.itemSize = CGSizeMake(w, h);
    }
    return self;
}
@end
