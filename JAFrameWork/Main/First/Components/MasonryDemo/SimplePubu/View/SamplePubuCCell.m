//
//  SamplePubuCCell.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SamplePubuCCell.h"

static const CGFloat kTitleDescHeight = 65;

@interface SamplePubuCCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *descLB;

@end

@implementation SamplePubuCCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-kTitleDescHeight);
    }];
    
    //如要换行，打开下面注释代码，且关闭LB的right约束
    //    CGFloat itemW = (kScreenWidth - (kMaxColumnNum + 1) * SamplePubuCCell_LeftMargin) / (kMaxColumnNum * 1.0);
    
    //    self.nameLB.preferredMaxLayoutWidth = (itemW - SamplePubuCCell_LeftMargin * 2);
    //    [self.nameLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV.mas_bottom).offset(SamplePubuCCell_LeftMargin);
        make.left.equalTo(self.contentView).offset(SamplePubuCCell_LeftMargin);
        make.right.equalTo(self.contentView).offset(-SamplePubuCCell_LeftMargin);
    }];
    
    //    self.descLB.preferredMaxLayoutWidth = (itemW - SamplePubuCCell_LeftMargin * 2);
    //    [self.descLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.descLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLB.mas_bottom).offset(4);
        make.left.equalTo(self.contentView).offset(SamplePubuCCell_LeftMargin);
        make.right.equalTo(self.contentView).offset(-SamplePubuCCell_LeftMargin);
    }];
}


#pragma mark - getter & setter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        
        [self.contentView addSubview:_imageV];
        _imageV.contentMode = UIViewContentModeCenter;
    }
    return _imageV;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        //        _nameLB.numberOfLines = 0;
        _nameLB.font = [UIFont fontRegular14];
        _nameLB.textColor = [UIColor color3333];
        [self.contentView addSubview:_nameLB];
        
        _nameLB.text = @"新鲜水果(奥体店)新鲜水果(奥体店)";
    }
    return _nameLB;
}

- (UILabel *)descLB {
    if (!_descLB) {
        _descLB = [[UILabel alloc] init];
        //        _descLB.numberOfLines = 0;
        _descLB.font = [UIFont fontRegular12];
        _descLB.textColor = [UIColor color6666];
        [self.contentView addSubview:_descLB];
        
        _descLB.text = @"箱包箱包箱包箱包箱包箱包箱包箱包箱包箱包";
    }
    return _descLB;
}

@end
