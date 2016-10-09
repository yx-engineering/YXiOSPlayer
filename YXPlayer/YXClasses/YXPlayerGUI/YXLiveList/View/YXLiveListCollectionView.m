//
//  YXLiveListCollectionView.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveListCollectionView.h"
#import "YXLiveCollectionCell.h"

@interface YXLiveListCollectionView ()<UICollectionViewDataSource>

@end

@implementation YXLiveListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        self.dataSource = self;
        [self registerClass:[YXLiveCollectionCell class] forCellWithReuseIdentifier:@"YXLiveCollectionCell"];
        self.dataArr = [NSMutableArray array];
    }
    return self;
}

#pragma mark collection data

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YXLiveCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXLiveCollectionCell" forIndexPath:indexPath];
    cell.liveModel = self.dataArr[indexPath.item];
    return cell;
}


@end
