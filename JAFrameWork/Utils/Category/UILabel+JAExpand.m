//
//  UILabel+JAExpand.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "UILabel+JAExpand.h"

@implementation UILabel (JAExpand)

- (void)addHorizontalLineWithColor:(UIColor *)color extraLBWidth:(CGFloat)extraW {
    UIView *lineV = [[UIView alloc] init];
    if (!color) {
        color = [UIColor color9999];
    }
    lineV.backgroundColor = color;
    
    if (!extraW) {
        extraW = 3;
    }
    
    [self addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).offset(extraW);
        make.height.mas_equalTo(1);
    }];
    
    [self setNeedsUpdateConstraints];
}

@end
