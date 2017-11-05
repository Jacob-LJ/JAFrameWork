//
//  JAImagePickerController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAImagePickerController.h"

@interface JAImagePickerController ()

@property (nonatomic, weak) UIButton *leftBtn;

@end

@implementation JAImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JAWeakSelf;
    self.navLeftBarButtonSettingBlock = ^(UIButton *leftButton) {
        weakSelf.leftBtn = leftButton;
        [leftButton setImage:[UIImage imageNamed:@"mine_back_cheng"] forState:UIControlStateNormal];
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    };
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor color6666];
    [self.navigationBar addSubview:lineView];
    lineView.frame = CGRectMake(0, 43, JAScreenW, 1);
    
    //    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(self.navigationBar);
    //        make.bottom.equalTo(self.navigationBar).offset(-1);
    //        make.height.mas_equalTo(1);
    //    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.naviBgColor = [UIColor whiteColor];
    self.naviTitleColor = [UIColor color3333];
    self.naviTitleFont = [UIFont fontMedium18];
    self.barItemTextColor = JARGBA(234, 88, 59, 1);
}

@end
