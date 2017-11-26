//
//  View_tableView_MasController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "View_tableView_MasController.h"
#import "jaView_tableView_Mas.h"

@interface View_tableView_MasController ()

@end

@implementation View_tableView_MasController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加一个内嵌 tableView 的 view
    jaView_tableView_Mas *view = [[jaView_tableView_Mas alloc] init];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(70);
        make.right.bottom.equalTo(self.view).offset(-70);
    }];
}

@end
