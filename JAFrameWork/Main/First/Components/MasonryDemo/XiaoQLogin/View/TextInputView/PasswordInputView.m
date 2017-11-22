//
//  PasswordInputView.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "PasswordInputView.h"
//
#import "TextInputConst.h"

static const CGFloat kShowDismissBtnW = 58;

@interface PasswordInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftPlaceBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *marginLine;
@property (nonatomic, strong) UIButton *showDismissBtn;

@end

@implementation PasswordInputView

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
    
    [self.showDismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(kShowDismissBtnW);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kTextFieldLeftMargin);
        make.right.equalTo(self.showDismissBtn.mas_left).offset(0);
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

#pragma mark - private action
- (void)showDismiss:(UIButton *)showDismissBtn {
    
    self.showDismissBtn.selected = !showDismissBtn.selected;
    self.textField.secureTextEntry = !self.showDismissBtn.selected;
    
    if (self.showPWBlock) {
        self.showPWBlock(showDismissBtn.selected);
    }
}

#pragma mark - Public
- (NSString *)text {
    return self.textField.text;
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

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.textField.placeholder = placeHolder;
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
        [_leftPlaceBtn setImage:[UIImage imageNamed:@"login_icon_pw"] forState:UIControlStateNormal];
        [_leftPlaceBtn setTitle:@"密码" forState:UIControlStateNormal];
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
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.placeholder = @"请输入登录密码";
        _textField.font = [UIFont fontRegular14];
        self.textField.secureTextEntry = YES;
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)showDismissBtn {
    if (!_showDismissBtn) {
        _showDismissBtn = [[UIButton alloc] init];
        [_showDismissBtn setImage:[UIImage imageNamed:@"login_icon_pw_eyesclosed"] forState:UIControlStateNormal];
        [_showDismissBtn setImage:[UIImage imageNamed:@"login_icon_pw_eyes"] forState:UIControlStateSelected];
        [_showDismissBtn addTarget:self action:@selector(showDismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showDismissBtn];
    }
    return _showDismissBtn;
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
