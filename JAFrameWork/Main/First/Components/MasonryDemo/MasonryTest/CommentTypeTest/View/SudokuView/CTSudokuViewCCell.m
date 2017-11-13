//
//  CTSudokuViewCCell.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "CTSudokuViewCCell.h"

@interface CTSudokuViewCCell ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation CTSudokuViewCCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraintsOnSubviews];
    }
    return self;
}


- (void)addConstraintsOnSubviews {
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - getter & setter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        //        _imageV.image =
        _imageV.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

@end
