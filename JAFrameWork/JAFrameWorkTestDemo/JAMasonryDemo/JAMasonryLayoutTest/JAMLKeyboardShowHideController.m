//
//  JAMLKeyboardShowHideController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAMLKeyboardShowHideController.h"

@interface JAMLKeyboardShowHideController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation JAMLKeyboardShowHideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - NSNotification action
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改下边距约束
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    
    // 更新约束
//    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
//    }];
#warning 2017年10月07日23:41:01 还没搞清楚 为啥layoutIfNeeded要放在 animateblock 中使用
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
    
    // 获得键盘动画时长
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改为以前的约束（距下边距0）
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    // 更新约束
//    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
//    }];
}




@end
