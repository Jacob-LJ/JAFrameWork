//
//  RegisterInfoController.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "RegisterInfoController.h"
//view
#import "PasswordInputView.h"
#import "UserNameInputView.h"
//#import "LeePhotoOrAlbumImagePicker.h"

static const CGFloat kLogoTopMargin = 42;
static const CGFloat kLogoImageVWH = 80;
static const CGFloat kNewInputViewTopMargin = 30;
static const CGFloat kInputViewH = 50;
static const CGFloat kLoginBtnH = 40;
static const CGFloat kUserNameInputVTopMargin = 36;


@interface RegisterInfoController ()

@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UILabel *clickTapLB;
@property (nonatomic, strong) PasswordInputView *newInputV;
@property (nonatomic, strong) PasswordInputView *confirmInputV;
@property (nonatomic, strong) UserNameInputView *userNameInputV;

@property (nonatomic, strong) UIButton *loginBtn;
//@property (nonatomic, strong) LeePhotoOrAlbumImagePicker *imagePicker;

@end

@implementation RegisterInfoController

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
    self.title = @"注册";
    UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(dimiss)];
}

- (void)addConstraintOnSubviews {
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kLogoTopMargin);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(kLogoImageVWH);
    }];
    
    [self.clickTapLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageV.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [self.newInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clickTapLB.mas_bottom).offset(kNewInputViewTopMargin);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.confirmInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.userNameInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kInputViewH);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameInputV.mas_bottom).offset(kUserNameInputVTopMargin);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kLoginBtnH);
    }];
}

#pragma mark - private action

- (void)dimiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginBtnClick {
    
}

- (void)selectImage {
//    self.imagePicker = [[LeePhotoOrAlbumImagePicker alloc] init];
//    JAWeakSelf;
//    [self.imagePicker getPhotoAlbumOrTakeAPhotoWithController:self andWithBlock:^(UIImage *image) {
//        weakSelf.logoImageV.image = image;
//    }];
}

- (void)inputViewDidChangeText {
    if (self.newInputV.text.length && self.confirmInputV.text.length && self.userNameInputV.text.length) {
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
        _logoImageV.image = [UIImage imageNamed:@"img_photo"];
        _logoImageV.userInteractionEnabled = YES;
        _logoImageV.layer.cornerRadius = kLogoImageVWH * 0.5;
        _logoImageV.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
        [_logoImageV addGestureRecognizer:tap];
        [self.view addSubview:_logoImageV];
    }
    return _logoImageV;
}

- (UILabel *)clickTapLB {
    if (!_clickTapLB) {
        _clickTapLB = [[UILabel alloc] init];
        _clickTapLB.text = @"点击选择头像";
        _clickTapLB.textColor = [UIColor color9999];
        _clickTapLB.font = [UIFont fontRegular14];
        [self.view addSubview:_clickTapLB];
    }
    return _clickTapLB;
}

- (PasswordInputView *)newInputV {
    if (!_newInputV) {
        _newInputV = [[PasswordInputView alloc] init];
        _newInputV.leftTile = @"密码";
        _newInputV.leftImageName = nil;
        _newInputV.placeHolder = @"请输入8-20位密码";
        JAWeakSelf;
        _newInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_newInputV];
    }
    return _newInputV;
}

- (PasswordInputView *)confirmInputV {
    if (!_confirmInputV) {
        _confirmInputV = [[PasswordInputView alloc] init];
        _confirmInputV.leftTile = @"确认密码";
        _confirmInputV.leftImageName = nil;
        _confirmInputV.placeHolder = @"请再输入一遍密码";
        JAWeakSelf;
        _confirmInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_confirmInputV];
    }
    return _confirmInputV;
}

- (UserNameInputView *)userNameInputV {
    if (!_userNameInputV) {
        _userNameInputV = [[UserNameInputView alloc] init];
        _userNameInputV.leftImageName = nil;
        JAWeakSelf;
        _userNameInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_userNameInputV];
    }
    return _userNameInputV;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
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


@end
