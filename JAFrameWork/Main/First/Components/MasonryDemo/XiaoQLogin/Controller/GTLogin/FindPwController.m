//
//  FindPwController.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "FindPwController.h"
//vc
#import "SettingPwController.h"
//view
#import "PhoneInputView.h"
#import "SecurityCodeIputView.h"

static const CGFloat kNextBtnH = 40;
static const CGFloat kPhoneInputViewH = 50;
static const CGFloat kPhoneInputVTop = 24;
static const CGFloat kNextBtnTop = 37;

@interface FindPwController ()

@property (nonatomic, strong) PhoneInputView *phoneInputV;
@property (nonatomic, strong) SecurityCodeIputView *securityCodeInputV;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation FindPwController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    [self addConstraintOnSubviews];
    
}

- (void)setUpInit {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeTop; //reference http://www.jianshu.com/p/a7fa9932c46c
}

- (void)setUpNav {
    self.title = @"找回密码";
    UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)addConstraintOnSubviews {
    
    [self.phoneInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kPhoneInputVTop);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.securityCodeInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeInputV.mas_bottom).offset(kNextBtnTop);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kNextBtnH);
    }];
}

#pragma mark - private action

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inputViewDidChangeText {
    
    if (self.phoneInputV.text.length && self.securityCodeInputV.text.length) {
        [_nextBtn setTitleColor:[UIColor color3333] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = JARGBA(254, 216, 55, 1);
        _nextBtn.enabled = YES;
    } else {
        [_nextBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        _nextBtn.enabled = NO;
    }
}

- (void)nextBtnClick {
    SettingPwController *setPwVC = [[SettingPwController alloc] init];
    [self.navigationController pushViewController:setPwVC animated:YES];
}

#pragma mark - getter & setter
- (PhoneInputView *)phoneInputV {
    if (!_phoneInputV) {
        _phoneInputV = [[PhoneInputView alloc] init];
        _phoneInputV.leftTile = @"手机号";
        _phoneInputV.leftImageName = nil;
        _phoneInputV.placeHolder = @"请输入手机号";
        JAWeakSelf;
        _phoneInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_phoneInputV];
    }
    return _phoneInputV;
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

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = kNextBtnH * 0.5;
        _nextBtn.clipsToBounds = YES;
        _nextBtn.titleLabel.font = [UIFont fontRegular16];
        [_nextBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _nextBtn.enabled = NO;
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

@end
