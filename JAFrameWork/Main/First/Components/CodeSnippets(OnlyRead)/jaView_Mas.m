//
//  jaView_Mas.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

/*
 Titile   : jaView_Mas
 Summary  : Mas布局View内带titleLB+topMarginView+btmLine
 ShortCut : jaView_Mas
 */

#import "jaView_Mas.h"

static const CGFloat kLeftMargin = 12;

@interface jaView_Mas ()

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *marginView;
@property (nonatomic, strong) UIView *marginLine;

@end

@implementation jaView_Mas

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(kLeftMargin);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.marginView.mas_bottom);
        make.left.equalTo(self).offset(kLeftMargin);
        make.right.equalTo(self).offset(-kLeftMargin);
        make.bottom.equalTo(self);
    }];
    
    [self.marginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.mas_equalTo(kLeftMargin);
        make.right.mas_equalTo(-kLeftMargin);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - Public
- (void)configtitle:(NSString *)title {
    self.titleLB.text = title;
}

#pragma mark - getter & setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = kFont_Regular_16;
        _titleLB.textColor = kColor_333333;
        [self addSubview:_titleLB];
        
        _titleLB.text = @"商家信息";
    }
    return _titleLB;
}

- (UIView *)marginView {
    if (!_marginView) {
        _marginView = [[UIView alloc] init];
        _marginView.backgroundColor = kRGBAColor(246, 246, 246, 1);
        [self addSubview:_marginView];
    }
    return _marginView;
}

- (UIView *)marginLine {
    if (!_marginLine) {
        _marginLine = [[UIView alloc] init];
        _marginLine.backgroundColor = kColor_eeeeee;
        [self addSubview:_marginLine];
    }
    return _marginLine;
}

@end
