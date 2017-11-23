//
//  GTPullDownSortCell.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "GTPullDownSortCell.h"

static const CGFloat kImageVWH = 24;
static const CGFloat kLeftMargin = 15;

@interface GTPullDownSortCell ()

@property (nonatomic, strong) UIImageView *checkImageV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *btmLineV;

@end

@implementation GTPullDownSortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.checkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-9);
        make.width.mas_equalTo(kImageVWH);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kLeftMargin);
        make.right.equalTo(self.checkImageV).offset(-9);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.btmLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - public
- (void)configWithTitle:(NSString *)title {
    self.titleLB.text = title;
}

#pragma mark - private action
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.checkImageV.hidden = !selected;
    if (selected) {
        self.btmLineV.backgroundColor = kColor_333333;
        self.titleLB.textColor = kColor_333333;
    } else {
        self.btmLineV.backgroundColor = kColor_eeeeee;
        self.titleLB.textColor = kColor_999999;
    }
}

#pragma mark - getter & setter
- (UIImageView *)checkImageV {
    if (!_checkImageV) {
        _checkImageV = [[UIImageView alloc] init];
        _checkImageV.contentMode = UIViewContentModeCenter;
        _checkImageV.image = [UIImage imageNamed:@"discover_sort_check"];
        [self.contentView addSubview:_checkImageV];
    }
    return _checkImageV;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.numberOfLines = 1;
        _titleLB.font = kFont_Regular_14;
        _titleLB.textColor = kColor_999999;
        [self.contentView addSubview:_titleLB];
        
        _titleLB.text = @"智能排序";
    }
    return _titleLB;
}

- (UIView *)btmLineV {
    if (!_btmLineV) {
        _btmLineV = [[UIView alloc] init];
        _btmLineV.backgroundColor = kColor_eeeeee;
        [self.contentView addSubview:_btmLineV];
    }
    return _btmLineV;
}

@end
