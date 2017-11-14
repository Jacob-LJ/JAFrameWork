//
//  SearchHistoryCCell.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SearchHistoryCCell.h"

@interface SearchHistoryCCell ()

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation SearchHistoryCCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

#pragma mark - public
- (void)configCellWithAttriTitle:(NSAttributedString *)attriTitle {
    self.titleLB.attributedText = attriTitle;
}

#pragma mark - getter & setter
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont fontRegular14];
        _titleLB.textColor = [UIColor color3333];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLB];
        
        _titleLB.text = @"优惠券";
    }
    return _titleLB;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorF6F6F6];
        _bgView.layer.cornerRadius = GTSearchHistoryCCellH * 0.5;
        _bgView.clipsToBounds = YES;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

@end
