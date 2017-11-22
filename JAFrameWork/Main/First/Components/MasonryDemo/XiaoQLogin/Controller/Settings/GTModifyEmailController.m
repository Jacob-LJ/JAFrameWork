//
//  GTModifyEmailController.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "GTModifyEmailController.h"
//vc

//view
#import "PasswordInputView.h"
#import "UserNameInputView.h"
#import "SecurityCodeIputView.h"

static const CGFloat kConfirmBtnTop = 37;
static const CGFloat kConfirmBtnH = 40;
static const CGFloat kInputViewH = 50;
static const CGFloat kPwInputVTop = 11;

@interface GTModifyEmailController ()

@property (nonatomic, strong) PasswordInputView *pwInputV;
@property (nonatomic, strong) UserNameInputView *emailInputV;
@property (nonatomic, strong) SecurityCodeIputView *securityCodeInputV;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *forgetPwBtn;

@end

@implementation GTModifyEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    [self addConstraintOnSubviews];
    
}

- (void)setUpInit {
//    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpNav {
    self.title = @"修改邮箱";
    UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)addConstraintOnSubviews {
    
    [self.pwInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kPwInputVTop);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.emailInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.securityCodeInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeInputV.mas_bottom).offset(kConfirmBtnTop);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kConfirmBtnH);
    }];
    
    [self.forgetPwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-30);
    }];
}

#pragma mark - private action

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inputViewDidChangeText {
    
    if (self.pwInputV.text.length && self.emailInputV.text.length && self.securityCodeInputV.text.length) {
        [_confirmBtn setTitleColor:[UIColor color3333] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = JARGBA(254, 216, 55, 1);
        _confirmBtn.enabled = YES;
    } else {
        [_confirmBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        _confirmBtn.enabled = NO;
    }
}

- (void)confirmBtnClick {
    
}

- (void)forgetPwBtnClick {
    
}

#pragma mark - getter & setter
- (PasswordInputView *)pwInputV {
    if (!_pwInputV) {
        _pwInputV = [[PasswordInputView alloc] init];
        _pwInputV.leftTile = @"登录密码";
        _pwInputV.leftImageName = nil;
        _pwInputV.placeHolder = @"请输入登录密码";
        JAWeakSelf;
        _pwInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_pwInputV];
    }
    return _pwInputV;
}

- (UserNameInputView *)emailInputV {
    if (!_emailInputV) {
        _emailInputV = [[UserNameInputView alloc] init];
        _emailInputV.leftTile = @"新邮箱";
        _emailInputV.leftImageName = nil;
        _emailInputV.placeHolder = @"请输入新邮箱";
        JAWeakSelf;
        _emailInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_emailInputV];
    }
    return _emailInputV;
}

- (SecurityCodeIputView *)securityCodeInputV {
    if (!_securityCodeInputV) {
        _securityCodeInputV = [[SecurityCodeIputView alloc] init];
        _securityCodeInputV.leftImageName = nil;
        JAWeakSelf;
        _securityCodeInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_securityCodeInputV];
    }
    return _securityCodeInputV;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = kConfirmBtnH * 0.5;
        _confirmBtn.clipsToBounds = YES;
        _confirmBtn.titleLabel.font = [UIFont fontRegular16];
        [_confirmBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.enabled = NO;
        [self.view addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

- (UIButton *)forgetPwBtn {
    if (!_forgetPwBtn) {
        _forgetPwBtn = [[UIButton alloc] init];
        [_forgetPwBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetPwBtn.titleLabel.font = [UIFont fontRegular12];
        [_forgetPwBtn setTitleColor:[UIColor color6666] forState:UIControlStateNormal];
        [_forgetPwBtn sizeToFit];
        [_forgetPwBtn addTarget:self action:@selector(forgetPwBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetPwBtn];
    }
    return _forgetPwBtn;
}

@end

