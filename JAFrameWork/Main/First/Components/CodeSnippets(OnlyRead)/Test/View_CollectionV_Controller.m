//
//  View_CollectionV_Controller.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "View_CollectionV_Controller.h"
//view
#import "jaView_CollectionV_Mas.h"

@interface View_CollectionV_Controller ()

@end

@implementation View_CollectionV_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加一个内嵌 tableView 的 view
    jaView_CollectionV_Mas *view = [[jaView_CollectionV_Mas alloc] init];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
}

@end
