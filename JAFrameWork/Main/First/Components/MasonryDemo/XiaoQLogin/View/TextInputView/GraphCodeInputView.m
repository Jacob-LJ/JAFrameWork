//
//  GraphCodeInputView.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "GraphCodeInputView.h"
//
#import "TextInputConst.h"

@interface GraphCodeInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftPlaceBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *marginLine;
@property (nonatomic, strong) UIButton *graphCodeBtn;

@end

@implementation GraphCodeInputView

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
    
    [self.graphCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-kLeftMargin);
        make.width.mas_equalTo(kGetCodeBtnW);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kTextFieldLeftMargin);
        make.right.equalTo(self.graphCodeBtn.mas_left);
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
- (void)getGraphCodeBtnClick {
    
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
        [_leftPlaceBtn setImage:[UIImage imageNamed:@"login_register_icon_piccode"] forState:UIControlStateNormal];
        [_leftPlaceBtn setTitle:@"图形验证码" forState:UIControlStateNormal];
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
        _textField.placeholder = @"请输入图中内容";
        _textField.font = [UIFont fontRegular14];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)graphCodeBtn {
    if (!_graphCodeBtn) {
        _graphCodeBtn = [[UIButton alloc] init];
        _graphCodeBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_graphCodeBtn addTarget:self action:@selector(getGraphCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_graphCodeBtn];
    }
    return _graphCodeBtn;
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
