//
//  SecurityCodeIputView.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "SecurityCodeIputView.h"
//
#import "TextInputConst.h"

@interface SecurityCodeIputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftPlaceBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *marginLine;
@property (nonatomic, strong) UIButton *getCodeBtn;

@end

@implementation SecurityCodeIputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)setUpInit {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)addConstraintOnSubviews {
    
    [self.leftPlaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(kleftPlaceBtnW);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kLeftMargin);
        make.width.mas_equalTo(kGetCodeBtnW);
        make.height.mas_equalTo(kGetCodeBtnH);
        make.centerY.equalTo(self);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kTextFieldLeftMargin);
        make.right.equalTo(self.getCodeBtn.mas_left);
    }];
    
    [self.marginLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.mas_equalTo(kLeftMargin);
        make.right.mas_equalTo(-kLeftMargin);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldEditingChanged:(UITextField *)textField {
    if (self.textChangedBlock) {
        self.textChangedBlock(textField.text);
    }
}

#pragma mark - Public
- (NSString *)text {
    return self.textField.text;
}

#pragma mark - private action
- (void)getCodeBtnClick {
    
}

#pragma mark - getter & setter

- (void)setLeftTile:(NSString *)leftTile {
    [self.leftPlaceBtn setTitle:leftTile forState:UIControlStateNormal];
}

- (void)setLeftImageName:(NSString *)leftImageName {
    if (!leftImageName.length) {
        _leftPlaceBtn.titleEdgeInsets = UIEdgeInsetsZero;
    }
    [self.leftPlaceBtn setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
}

- (void)setEnableGetBtn:(BOOL)enableGetBtn {
    _enableGetBtn = enableGetBtn;
    if (enableGetBtn) {
        _getCodeBtn.backgroundColor = JARGBA(254, 216, 55, 1);
        [_getCodeBtn setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
        _getCodeBtn.enabled = YES;
    } else {
        _getCodeBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_getCodeBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _getCodeBtn.enabled = NO;
    }
}

- (void)setTextFieldLeftMargin:(CGFloat)textFieldLeftMargin {
    _textFieldLeftMargin = textFieldLeftMargin;
    
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(textFieldLeftMargin);
    }];
    [self setNeedsUpdateConstraints];
}

- (UIButton *)leftPlaceBtn {
    if (!_leftPlaceBtn) {
        _leftPlaceBtn = [[UIButton alloc] init];
        [_leftPlaceBtn setImage:[UIImage imageNamed:@"login_icon_phone"] forState:UIControlStateNormal];
        [_leftPlaceBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [_leftPlaceBtn setTitleColor:[UIColor color3333] forState:UIControlStateNormal];
        _leftPlaceBtn.titleLabel.font = [UIFont fontRegular14];
        _leftPlaceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0);
        _leftPlaceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftPlaceBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self addSubview:_leftPlaceBtn];
    }
    return _leftPlaceBtn;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.placeholder = @"请输入6位数验证码";
        _textField.font = [UIFont fontRegular14];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [[UIButton alloc] init];
        _getCodeBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_getCodeBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont fontRegular12];
        _getCodeBtn.layer.cornerRadius = kGetCodeBtnH * 0.5;
        _getCodeBtn.clipsToBounds = YES;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _getCodeBtn.enabled = NO;
        [self addSubview:_getCodeBtn];
    }
    return _getCodeBtn;
}

- (UIView *)marginLine {
    if (!_marginLine) {
        _marginLine = [[UIView alloc] init];
        _marginLine.backgroundColor = [UIColor colorEEEE];
        [self addSubview:_marginLine];
    }
    return _marginLine;
}

@end
