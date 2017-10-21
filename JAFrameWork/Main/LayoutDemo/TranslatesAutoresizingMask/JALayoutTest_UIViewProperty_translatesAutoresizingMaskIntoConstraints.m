//
//  JALayoutTest_UIViewProperty_translatesAutoresizingMaskIntoConstraints.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JALayoutTest_UIViewProperty_translatesAutoresizingMaskIntoConstraints.h"

@interface JALayoutTest_UIViewProperty_translatesAutoresizingMaskIntoConstraints ()

@end

@implementation JALayoutTest_UIViewProperty_translatesAutoresizingMaskIntoConstraints

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"旋转屏幕看看，subView大小会随着父控件变化";
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-80);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat containerVX = 30;
    CGFloat containerVH = 200;
    CGFloat containerVW = self.view.bounds.size.width - 2*containerVX;
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(containerVX);
        make.right.bottom.equalTo(self.view).offset(-containerVX);
        make.height.mas_equalTo(containerVH);
    }];
    
    [self.view layoutIfNeeded]; //下面的 subView 使用 frame 进行布局，那么参照的就是 containerView 的 frame 进行的，有因为添加约束后的 containerView 的 frame 值是 zero，而让 containerView 的父View 更新布局，则可马上确定 containerView 的 frame，那么下面的 subview 布局 就不会混乱。
    
    
    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor redColor];
//    subView.translatesAutoresizingMaskIntoConstraints = YES; //代码创建的 View 该属性为 YES，SB 创建的 View 则默认为 NO，因为使用 SB 默认就是手动添加constraint。
    subView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    subView.frame = CGRectMake(20, 20, containerVW - 40, containerVH - 40);
    [containerView addSubview:subView];
    
}


@end
