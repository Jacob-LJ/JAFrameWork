//
//  LoginController.m
//  XQCity
//
//  Created by Jacob on 2017/11/20.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "LoginController.h"
//vc
#import "FindPwController.h"
#import "RegisterController.h"
//view
#import "PhoneInputView.h"
#import "PasswordInputView.h"
#import "JAButton.h"

static const CGFloat kLogoTopMargin = 47;
static const CGFloat kLogoImageVWH = 70;
static const CGFloat kPhoneInputViewTopMargin = 30;
static const CGFloat kPhoneInputViewH = 50;
static const CGFloat kLoginBtnH = 40;
static const CGFloat kPwInputVTopMargin = 36;
static const CGFloat kOtherLoginBtnW = 40;
static const CGFloat kOtherLoginBtnH = 62;


@interface LoginController ()

@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) PhoneInputView *phoneInputV;
@property (nonatomic, strong) PasswordInputView *pwInputV;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetPwBtn;
@property (nonatomic, strong) UIButton *fastRegisterBtn;

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *leftLineV;
@property (nonatomic, strong) UIView *rightLineV;
@property (nonatomic, strong) JAButton *weChatBtn;
@property (nonatomic, strong) JAButton *QQBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    [self addConstraintOnSubviews];
    
}

- (void)setUpInit {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpNav {
    self.title = @"登录";
    UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(dimiss)];
}

- (void)addConstraintOnSubviews {
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kLogoTopMargin);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(kLogoImageVWH);
    }];
    
    [self.phoneInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageV.mas_bottom).offset(kPhoneInputViewTopMargin);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.pwInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwInputV.mas_bottom).offset(kPwInputVTopMargin);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kLoginBtnH);
    }];
    
    [self.forgetPwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(24);
    }];
    
    [self.fastRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-24);
    }];
    
    [self.weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-(kOtherLoginBtnW * 0.5 + 25));
        make.bottom.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kOtherLoginBtnW, kOtherLoginBtnH));
    }];
    
    [self.QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset((kOtherLoginBtnW * 0.5 + 25));
        make.bottom.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kOtherLoginBtnW, kOtherLoginBtnH));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.weChatBtn.mas_top).offset(-14);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(102);
    }];
    
    [self.leftLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(24);
        make.right.equalTo(self.titleLB.mas_left).offset(-6);
        make.centerY.equalTo(self.titleLB.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    [self.rightLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-24);
        make.left.equalTo(self.titleLB.mas_right).offset(6);
        make.centerY.equalTo(self.titleLB.mas_centerY);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - private action

- (void)dimiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)loginBtnClick {
    
}

- (void)forgetPwBtnClick {
    FindPwController *findPwVC = [[FindPwController alloc] init];
    [self.navigationController pushViewController:findPwVC animated:YES];
}

- (void)fastRegisterBtnClick {
    RegisterController *registerVC = [[RegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)weChatLogin {
    
}

- (void)QQLogin {
    
}

- (void)inputViewDidChangeText {
    if (self.phoneInputV.text.length && self.pwInputV.text.length) {
        [_loginBtn setTitleColor:[UIColor color3333] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = JARGBA(254, 216, 55, 1);
        _loginBtn.enabled = YES;
    } else {
        [_loginBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        _loginBtn.enabled = NO;
    }
}

#pragma mark - getter & setter
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc] init];
        _logoImageV.image = [UIImage imageNamed:@"login_icon_logo"];
        [self.view addSubview:_logoImageV];
    }
    return _logoImageV;
}

- (PhoneInputView *)phoneInputV {
    if (!_phoneInputV) {
        _phoneInputV = [[PhoneInputView alloc] init];
        JAWeakSelf;
        _phoneInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_phoneInputV];
    }
    return _phoneInputV;
}

- (PasswordInputView *)pwInputV {
    if (!_pwInputV) {
        _pwInputV = [[PasswordInputView alloc] init];
        JAWeakSelf;
        _pwInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_pwInputV];
    }
    return _pwInputV;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = kLoginBtnH * 0.5;
        _loginBtn.clipsToBounds = YES;
        _loginBtn.titleLabel.font = [UIFont fontRegular16];
        [_loginBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = NO;
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
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

- (UIButton *)fastRegisterBtn {
    if (!_fastRegisterBtn) {
        _fastRegisterBtn = [[UIButton alloc] init];
        [_fastRegisterBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        _fastRegisterBtn.titleLabel.font = [UIFont fontRegular12];
        [_fastRegisterBtn setTitleColor:[UIColor color6666] forState:UIControlStateNormal];
        [_fastRegisterBtn sizeToFit];
        [_fastRegisterBtn addTarget:self action:@selector(fastRegisterBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_fastRegisterBtn];
    }
    return _fastRegisterBtn;
}

- (JAButton *)weChatBtn {
    if (!_weChatBtn) {
        _weChatBtn = [JAButton JAButtonWithType:JAButtonTypeVerticalCenterImageLabel spacing:8];
        _weChatBtn.backgroundColor = [UIColor whiteColor];
        _weChatBtn.ja_normalImage = [UIImage imageNamed:@"login_icon_wechat"];
        _weChatBtn.ja_normalTitle = @"微信";
        _weChatBtn.titleLabel.font = [UIFont fontRegular12];
        [_weChatBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        [_weChatBtn addTarget:self action:@selector(weChatLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_weChatBtn];
    }
    return _weChatBtn;
}

- (JAButton *)QQBtn {
    if (!_QQBtn) {
        _QQBtn = [JAButton JAButtonWithType:JAButtonTypeVerticalCenterImageLabel spacing:8];
        _QQBtn.backgroundColor = [UIColor whiteColor];
        _QQBtn.ja_normalImage = [UIImage imageNamed:@"login_icon_qq"];
        _QQBtn.ja_normalTitle = @"QQ";
        _QQBtn.titleLabel.font = [UIFont fontRegular12];
        [_QQBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        [_QQBtn addTarget:self action:@selector(QQLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_QQBtn];
    }
    return _QQBtn;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"第三方账号登陆";
        _titleLB.font = [UIFont fontRegular14];
        _titleLB.textColor = [UIColor color9999];
        [self.view addSubview:_titleLB];
    }
    return _titleLB;
}

- (UIView *)leftLineV {
    if (!_leftLineV) {
        _leftLineV = [[UIView alloc] init];
        _leftLineV.backgroundColor = [UIColor colorCCCC];
        [self.view addSubview:_leftLineV];
    }
    return _leftLineV;
}

- (UIView *)rightLineV {
    if (!_rightLineV) {
        _rightLineV = [[UIView alloc] init];
        _rightLineV.backgroundColor = [UIColor colorCCCC];
        [self.view addSubview:_rightLineV];
    }
    return _rightLineV;
}

@end
