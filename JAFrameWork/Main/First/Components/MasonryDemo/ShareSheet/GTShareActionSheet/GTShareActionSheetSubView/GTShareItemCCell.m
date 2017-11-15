//
//  GTShareItemCCell.m
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import "GTShareItemCCell.h"
#import "GTShareItem.h"

@interface GTShareItemCCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation GTShareItemCCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(18);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLB.mas_top).offset(-4);
    }];
}

#pragma mark - Public
- (void)configWithModel:(GTShareItem *)shareItem {
    self.imageV.image = [UIImage imageNamed:shareItem.imgName];
    self.titleLB.text = shareItem.name;
}

#pragma mark - getter & setter

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.image = [UIImage imageNamed:@"general_qq"];
        _imageV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont fontRegular12];
        _titleLB.textColor = [UIColor color3333];
        _titleLB.text = @"朋友圈";
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLB];
    }
    return _titleLB;
}

@end
