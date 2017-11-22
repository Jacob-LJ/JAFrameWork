//
//  settingPwSuccessController.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "settingPwSuccessController.h"

static const CGFloat kNextBtnH = 40;
static const CGFloat kTipImageVH = 197;
static const CGFloat kTipLBTop = 10;
static const CGFloat kConfirmBtnTop = 44;

@interface settingPwSuccessController ()

@property (nonatomic, strong) UIImageView *tipImageV;
@property (nonatomic, strong) UILabel *tipLB;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation settingPwSuccessController

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
    
    [self.tipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kTipImageVH);
    }];
    
    [self.tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipImageV.mas_bottom).offset(kTipLBTop);
        make.centerX.equalTo(self.view);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLB.mas_bottom).offset(kConfirmBtnTop);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kNextBtnH);
    }];
}

#pragma mark - private action

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmBtnClick {
    
}

#pragma mark - getter & setter
- (UIImageView *)tipImageV {
    if (!_tipImageV) {
        _tipImageV = [[UIImageView alloc] init];
        _tipImageV.image = [UIImage imageNamed:@"login_icon_complete"];
        _tipImageV.contentMode = UIViewContentModeCenter;
        [self.view addSubview:_tipImageV];
    }
    return _tipImageV;
}

- (UILabel *)tipLB {
    if (!_tipLB) {
        _tipLB = [[UILabel alloc] init];
        _tipLB.text = @"新密码设置成功，不要再丢啦～";
        _tipLB.font = [UIFont fontRegular16];
        _tipLB.textColor = [UIColor color3333];
        [self.view addSubview:_tipLB];
    }
    return _tipLB;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"去登录" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = kNextBtnH * 0.5;
        _confirmBtn.clipsToBounds = YES;
        _confirmBtn.titleLabel.font = [UIFont fontRegular16];
        [_confirmBtn setTitleColor:[UIColor color3333] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = JARGBA(254, 216, 55, 1);
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmBtn];
    }
    return _confirmBtn;
}

@end
