//
//  View_MasController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "View_MasController.h"
//view
#import "jaView_Mas.h"

@interface View_MasController ()

@end

@implementation View_MasController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加一个内嵌 tableView 的 view
    jaView_Mas *view = [[jaView_Mas alloc] init];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
}

@end
