//
//  RegisterController.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "RegisterController.h"
//vc
#import "FindPwController.h"
#import "RegisterInfoController.h"
//#import "GTProtocolWebController.h"
//view
#import "PhoneInputView.h"
#import "SecurityCodeIputView.h"
#import "GraphCodeInputView.h"
#import "JAButton.h"
//util


static const CGFloat kLogoTopMargin = 47;
static const CGFloat kLogoImageVWH = 70;
static const CGFloat kPhoneInputViewTopMargin = 30;
static const CGFloat kPhoneInputViewH = 50;
static const CGFloat kLoginBtnH = 40;
static const CGFloat kPwInputVTopMargin = 50;
static const CGFloat kOtherLoginBtnW = 40;
static const CGFloat kOtherLoginBtnH = 62;


@interface RegisterController ()

@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) PhoneInputView *phoneInputV;
@property (nonatomic, strong) SecurityCodeIputView *securityCodeInputV;
@property (nonatomic, strong) GraphCodeInputView *graphCodeInputV;

@property (nonatomic, strong) YYLabel *protocolLB;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *leftLineV;
@property (nonatomic, strong) UIView *rightLineV;
@property (nonatomic, strong) JAButton *weChatBtn;
@property (nonatomic, strong) JAButton *QQBtn;

@property (nonatomic, assign) BOOL isClose;

@end

@implementation RegisterController

- (instancetype)initWithCloseBackItem:(BOOL)isClose {
    if (self = [super init]) {
        self.isClose = isClose;
    }
    return self;
}

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
    if (_isClose) {
        UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(dimiss)];
        
    } else {
        UIImage *closeImage = [[UIImage imageNamed:@"login_nav_icon_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    //test
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(test)];
    
}

- (void)addConstraintOnSubviews {
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kLogoTopMargin);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(kLogoImageVWH);
    }];
    
    [self.graphCodeInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageV.mas_bottom).offset(kPhoneInputViewTopMargin);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.phoneInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageV.mas_bottom).offset(kPhoneInputViewTopMargin);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.securityCodeInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneInputV.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(kPhoneInputViewH);
    }];
    
    [self.protocolLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeInputV.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.securityCodeInputV.mas_bottom).offset(kPwInputVTopMargin);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(kLoginBtnH);
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

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

//test
- (void)test {
    [self addGraphCodeInputView];
}

- (void)nextBtnClick {
    RegisterInfoController *registerInfoVC = [[RegisterInfoController alloc] init];
    [self.navigationController pushViewController:registerInfoVC animated:YES];
}

- (void)forgetPwBtnClick {
    FindPwController *findPwVC = [[FindPwController alloc] init];
    [self.navigationController pushViewController:findPwVC animated:YES];
}

- (void)fastRegisterBtnClick {
    
}

- (void)weChatLogin {
    
}

- (void)QQLogin {
    
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
    
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)addGraphCodeInputView {
    
    [self.graphCodeInputV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageV.mas_bottom).offset(kPhoneInputViewTopMargin+kPhoneInputViewH);
    }];
    
    [self.securityCodeInputV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneInputV.mas_bottom).offset(kPhoneInputViewH);
    }];
}

- (void)userProtocolClick {
//    GTProtocolWebController *userProtocolVC = [[GTProtocolWebController alloc] initWithProtocolWebType:GTProtocolWebType_UsePortocol];
//    [self.navigationController pushViewController:userProtocolVC animated:YES];
}

- (void)securityProtocolClick {
//    GTProtocolWebController *securityProtocolVC = [[GTProtocolWebController alloc] initWithProtocolWebType:GTProtocolWebType_PrivacyClause];
//    [self.navigationController pushViewController:securityProtocolVC animated:YES];
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
        _phoneInputV.leftImageName = @"login_register_icon_phone";
        _phoneInputV.leftTile = @"手机号";
        _phoneInputV.placeHolder = @"请输入手机号";
        _phoneInputV.textFieldLeftMargin = 123;
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
        _securityCodeInputV.leftImageName = @"login_register_icon_code";
        _securityCodeInputV.leftTile = @"验证码";
        _securityCodeInputV.textFieldLeftMargin = 123;
        JAWeakSelf;
        _securityCodeInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_securityCodeInputV];
    }
    return _securityCodeInputV;
}

- (GraphCodeInputView *)graphCodeInputV {
    if (!_graphCodeInputV) {
        _graphCodeInputV = [[GraphCodeInputView alloc] init];
        _graphCodeInputV.textFieldLeftMargin = 123;
        JAWeakSelf;
        _graphCodeInputV.textChangedBlock = ^(NSString *text) {
            [weakSelf inputViewDidChangeText];
        };
        [self.view addSubview:_graphCodeInputV];
    }
    return _graphCodeInputV;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = kLoginBtnH * 0.5;
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
        _titleLB.text = @"第三方账号注册";
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

- (YYLabel *)protocolLB {
    if (!_protocolLB) {
        _protocolLB = [[YYLabel alloc] init];
        
        NSDictionary *attriDict = @{NSForegroundColorAttributeName : [UIColor color6666], NSFontAttributeName : [UIFont fontRegular12]};
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
        
        //
        UIImage *image = [UIImage imageNamed:@"login_register_icon_agree"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:[UIFont fontRegular12] alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        
        //
        NSMutableAttributedString *descText = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意小Q的 " attributes:attriDict];
        [text appendAttributedString:descText];
        
        NSMutableAttributedString *userProtocolText = [[NSMutableAttributedString alloc] initWithString:@"用户协议" attributes:attriDict];
        userProtocolText.underlineStyle = NSUnderlineStyleSingle;
        
        JAWeakSelf;
        [userProtocolText setTextHighlightRange:NSMakeRange(0, userProtocolText.length)
                             color:nil//[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:nil//[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                             NSLog(@"用户协议");
                             [weakSelf userProtocolClick];
                         }];
        [text appendAttributedString:userProtocolText];
        
        //
        NSMutableAttributedString *andText = [[NSMutableAttributedString alloc] initWithString:@" 和 " attributes:attriDict];
        [text appendAttributedString:andText];
        
        //
        NSMutableAttributedString *securityText = [[NSMutableAttributedString alloc] initWithString:@"隐私条款" attributes:attriDict];
        securityText.underlineStyle = NSUnderlineStyleSingle;
        
        [securityText setTextHighlightRange:NSMakeRange(0, userProtocolText.length)
                              color:nil//[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                    backgroundColor:nil//[UIColor colorWithWhite:0.000 alpha:0.220]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                              NSLog(@"隐私条款");
                              [weakSelf securityProtocolClick];
                          }];
        [text appendAttributedString:securityText];
        
        _protocolLB.attributedText = text;
        [self.view addSubview:_protocolLB];
        
    }
    return _protocolLB;
}

@end
