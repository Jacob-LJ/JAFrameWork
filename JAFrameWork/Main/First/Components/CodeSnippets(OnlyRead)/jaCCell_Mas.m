//
//  jaCCell_Mas.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

/*
 Titile   : jaCCell_Mas
 Summary  : Mas布局CCell内ImageV
 ShortCut : jaCCell_Mas
 */

#import "jaCCell_Mas.h"

@interface jaCCell_Mas ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation jaCCell_Mas

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

#pragma mark - public
- (void)configCellWithModel:(id)model {

}

#pragma mark - getter & setter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.image = [UIImage imageNamed:@"login_icon_logo"];
        _imageV.layer.cornerRadius = 4;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

@end
