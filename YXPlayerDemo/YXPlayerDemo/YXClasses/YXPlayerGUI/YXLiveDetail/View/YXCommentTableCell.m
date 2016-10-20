//
//  CommentTableCell.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCommentTableCell.h"
#import "YXCommentModel.h"
#import "YXCopyLabel.h"
#import "UIImageView+WebCache.h"

@interface YXCommentTableCell ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) YXCopyLabel *contentLab;
@end

@implementation YXCommentTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self addSubviews];
    [self addConstarinsForSubviews];
    return self;
}

- (void)addSubviews {
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    iconView.layer.cornerRadius = 16.5;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    //用户名
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithRed:34/255.0 green:164/255.0 blue:229/255.0 alpha:1];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //时间和楼号
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //内容
    YXCopyLabel *contentLab = [[YXCopyLabel alloc] init];
    contentLab.backgroundColor = [UIColor clearColor];
    contentLab.textColor = [UIColor blackColor];
    contentLab.font = [UIFont systemFontOfSize:16];
    contentLab.numberOfLines = 0;
    [self.contentView addSubview:contentLab];
    self.contentLab = contentLab;
}

- (void)addConstarinsForSubviews {
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.height.equalTo(@14);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.equalTo(@160);
    }];
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

- (void)setCommentModel:(YXCommentModel *)commentModel {
    _commentModel = commentModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:commentModel.avatar] placeholderImage:[UIImage imageNamed:@"defaultHead.png"]];
    
    self.nameLabel.text = commentModel.username;
    
    NSMutableParagraphStyle *paragra = [[NSMutableParagraphStyle alloc] init];
    paragra.minimumLineHeight = self.contentLab.font.lineHeight + 10;
    paragra.alignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:commentModel.content attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragra}];
    self.contentLab.attributedText = attr;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@楼",commentModel.time,commentModel.floor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.layer.masksToBounds = YES;
}

@end
