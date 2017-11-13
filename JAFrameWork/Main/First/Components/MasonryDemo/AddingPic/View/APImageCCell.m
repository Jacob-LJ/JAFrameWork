//
//  APImageCCell.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "APImageCCell.h"

@interface APImageCCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *addIamgeV;
@property (nonatomic, strong) UIButton *deleBtn;

@end

@implementation APImageCCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addConstraintsOnSubviews];
    }
    return self;
}


- (void)addConstraintsOnSubviews {
    
    [self.addIamgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(8);
        make.right.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(8);
        make.right.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
}

#pragma mark - private action
- (void)deleteBtnClick {
    if (self.deleteImageBlock) {
        self.deleteImageBlock(self.index);
    }
}

#pragma mark - getter & setter
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageV.image = image;
}

- (void)setType:(APImageCCellType)type {
    _type = type;
    
    switch (type) {
        case APImageCCellType_add: {
            self.imageV.hidden = YES;
            self.deleBtn.hidden = YES;
            break;
        }
        case APImageCCellType_image: {
            self.imageV.hidden = NO;
            self.deleBtn.hidden = NO;
            break;
        }
            
    }
}

- (UIImageView *)addIamgeV {
    if (!_addIamgeV) {
        _addIamgeV = [[UIImageView alloc] init];
        _addIamgeV.image = [UIImage imageNamed:@"mine_increase"];
        _addIamgeV.contentMode = UIViewContentModeCenter;
        _addIamgeV.layer.borderWidth = 1;
        _addIamgeV.layer.borderColor = [UIColor colorEEEE].CGColor;
        _addIamgeV.layer.cornerRadius = 4;
        [self.contentView addSubview:_addIamgeV];
    }
    return _addIamgeV;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.layer.cornerRadius = 4;
        _imageV.clipsToBounds = YES;
        self.imageV.hidden = YES;
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] init];
        [_deleBtn setImage:[UIImage imageNamed:@"mine_close_black"] forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _deleBtn.hidden = YES;
        [self.contentView addSubview:_deleBtn];
    }
    return _deleBtn;
}

@end
