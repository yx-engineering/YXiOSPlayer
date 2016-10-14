//
//  YXLiveCollectionCell.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveCollectionCell.h"
#import "YXLiveModel.h"
#import "UIImageView+WebCache.h"
@interface YXLiveCollectionCell ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *stateLab;//即将开始，正在直播，已结束
@property (nonatomic, weak) UILabel *onLineNumLab;
@property (nonatomic, weak) UILabel *liveTitleLab;
@property (nonatomic, weak) UILabel *ownerLab;
@property (nonatomic, weak) UILabel *timeLab;
//@property (nonatomic, weak) UIButton *likeBtn; //收藏按钮

@property (nonatomic, strong) MASConstraint *onLineNumLabWithCons;
//@property (nonatomic, strong) MASConstraint *likeBtnWithCons;
@end

@implementation YXLiveCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
        [self addConstraintsForSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"activity_default_img"]];
    imageView.layer.cornerRadius = 5;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *stateLab = [[UILabel alloc] init];
    stateLab.textColor = [UIColor whiteColor];
    stateLab.font = [UIFont systemFontOfSize:10];
    stateLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:stateLab];
    self.stateLab = stateLab;
    
    UILabel *onLineNumLab = [[UILabel alloc] init];
    onLineNumLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    onLineNumLab.text = @"0 在线";
    onLineNumLab.textColor = [UIColor whiteColor];
    onLineNumLab.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:onLineNumLab];
    self.onLineNumLab = onLineNumLab;
    
    UILabel *liveTitleLab = [[UILabel alloc] init];
    liveTitleLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    liveTitleLab.text = @"逆袭学院Pre-A轮融资";
    liveTitleLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:liveTitleLab];
    self.liveTitleLab = liveTitleLab;
    
    UILabel *ownerLab = [[UILabel alloc] init];
    ownerLab.text = @"云犀直播";
    ownerLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    ownerLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:ownerLab];
    self.ownerLab = ownerLab;
    
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
//    UIButton *likeBtn = [[UIButton alloc] init];
//    [likeBtn setTitle:0 forState:UIControlStateNormal];
//    likeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//    [likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [likeBtn setImage:[UIImage imageNamed:@"favorite_favorite_icon"] forState:UIControlStateNormal];
//    likeBtn.backgroundColor = [UIColor colorWithRed:34/255.0 green:164/255.0 blue:229/255.0 alpha:1];
//    [self.contentView addSubview:likeBtn];
//    self.likeBtn = likeBtn;
    
}

- (void)addConstraintsForSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(0.56);
    }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.imageView);
        make.height.equalTo(@14);
        make.width.equalTo(@50);
    }];
    
    [self.onLineNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.imageView);
        make.height.equalTo(@14);
        self.onLineNumLabWithCons = make.width.equalTo(@34);
    }];
    
    [self.liveTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(7);
        make.left.right.equalTo(self.imageView);
        make.height.equalTo(@12);
    }];
    
    [self.ownerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.liveTitleLab.mas_bottom).offset(7);
        make.left.equalTo(self.liveTitleLab);
        make.height.equalTo(@12);
    }];
    
    [self.timeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.ownerLab);
        make.right.equalTo(self.imageView);
        make.width.mas_equalTo(105);
    }];
    
//    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.height.equalTo(self.ownerLab);
//        make.left.equalTo(self.ownerLab.mas_right).offset(2);
//        make.right.equalTo(self.imageView);
//        self.likeBtnWithCons = make.width.equalTo(@23);
//    }];
    
}

- (void)setLiveModel:(YXLiveModel *)liveModel {
    _liveModel = liveModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:liveModel.coverUrl] placeholderImage:[UIImage imageNamed:@"activity_default_img"]];
    
    self.onLineNumLab.text = [NSString stringWithFormat:@"%@ 在线",liveModel.watchNum];
    self.liveTitleLab.text = liveModel.title;
    self.streamStatus = liveModel.streamStatus;
    CGFloat onLineNumLabW = [self textW:self.onLineNumLab.text fontSize:self.onLineNumLab.font.pointSize] + 2;
    self.onLineNumLabWithCons.offset = onLineNumLabW;
    self.timeLab.text = liveModel.startFormatTime;
//    CGFloat likeBtnW = [self textW:self.likeBtn.titleLabel.text fontSize:10] + 12 + 2 ;
//    self.likeBtnWithCons.offset = likeBtnW;
    [self.contentView layoutIfNeeded];
}

- (void)setStreamStatus:(NSInteger)streamStatus {
    _streamStatus = streamStatus;
    switch (streamStatus) {
        case 0:
            self.stateLab.hidden = NO;
            self.stateLab.text = @"即将开始";
            self.stateLab.backgroundColor = [UIColor colorWithRed:34/255.0 green:164/255.0 blue:229/255.0 alpha:1];
            break;
        case 1:
            self.stateLab.hidden = NO;
            self.stateLab.text = @"正在直播";
            self.stateLab.backgroundColor = [UIColor colorWithRed:82/255.0 green:204/255.0 blue:122/255.0 alpha:1];
            break;
        case 2:
            self.stateLab.hidden = NO;
            self.stateLab.text = @"已结束";
            self.stateLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1];
            break;
            
        default:
            self.stateLab.hidden = YES;
            break;
    }
}


/**设置圆角 */
- (void)setCorner:(UIRectCorner)corners cornerRadii:(CGSize)radii forView:(UIView *)view {
    CGRect rect = view.bounds;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = path.CGPath;
    view.layer.mask = maskLayer;
}

- (CGFloat)textW:(NSString *)text fontSize:(CGFloat)fontSize {
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 17) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return bounds.size.width;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.masksToBounds = YES;
    [self setCorner:UIRectCornerTopRight cornerRadii: CGSizeMake(2, 0) forView:self.onLineNumLab];
    [self setCorner:UIRectCornerTopLeft cornerRadii:CGSizeMake(2, 0) forView:self.stateLab];
}

@end
