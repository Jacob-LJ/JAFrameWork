//
//  SettingPwController.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "SettingPwController.h"
//vc
#import "settingPwSuccessController.h"
//view
#import "PasswordInputView.h"

static const CGFloat kNextBtnH = 40;
static const CGFloat kPhoneInputViewH = 50;
static const CGFloat kPhoneInputVTop = 24;
static const CGFloat kNextBtnTop = 37;

@interface SettingPwController ()

@property (nonatomic, strong) PasswordInputView *newInputV;
@property (nonatomic, strong) PasswordInputView *confirmInputV;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation SettingPwController

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
    self.title = @"设置新密码";
    UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)addConstraintOnSubviews {
    
    [self.newInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kPhoneInputVTop);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.confirmInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.newInputV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmInputV.mas_bottom).offset(kNextBtnTop);
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
    
    if (self.newInputV.text.length && self.confirmInputV.text.length) {
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
    settingPwSuccessController *settingSuccVC = [[settingPwSuccessController alloc] init];
    [self.navigationController pushViewController:settingSuccVC animated:YES];
}

#pragma mark - getter & setter
- (PasswordInputView *)newInputV {
    if (!_newInputV) {
        _newInputV = [[PasswordInputView alloc] init];
        _newInputV.leftTile = @"设置新密码";
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
        _confirmInputV.leftTile = @"确认新密码";
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

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"确认" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = kNextBtnH * 0.5;
        _nextBtn.clipsToBounds = YES;
        _nextBtn.titleLabel.font = [UIFont fontRegular16];
        [_nextBtn setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
        _nextBtn.backgroundColor = JARGBA(255, 238, 167, 1);
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.enabled = NO;
        [self.view addSubview:_nextBtn];
    }
    return _nextBtn;
}

@end
