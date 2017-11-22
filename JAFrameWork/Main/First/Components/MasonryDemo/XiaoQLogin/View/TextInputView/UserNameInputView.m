//
//  UserNameInputView.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "UserNameInputView.h"
//
#import "TextInputConst.h"

@interface UserNameInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftPlaceBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *marginLine;

@end

@implementation UserNameInputView

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
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kTextFieldLeftMargin);
        make.right.equalTo(self).offset(-kLeftMargin);
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
//        [_leftPlaceBtn setImage:[UIImage imageNamed:@"login_icon_phone"] forState:UIControlStateNormal];
        [_leftPlaceBtn setTitle:@"用户名" forState:UIControlStateNormal];
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
        _textField.placeholder = @"8-20位字母或数字，设置后不可改";
        _textField.font = [UIFont fontRegular14];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return _textField;
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
