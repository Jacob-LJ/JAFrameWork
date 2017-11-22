//
//  XiaoQLoginController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/22.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "XiaoQLoginController.h"
//vc
#import "JABaseNavigationController.h"
#import "LoginController.h"
#import "GTModifyPhoneController.h"
#import "GTModifyEmailController.h"
#import "GTModifyLoginPasswordController.h"
#import "GTSetNewPayPasswordController.h"
#import "GTModifyPayPasswordController.h"
#import "GTFindPayPasswordController.h"

static NSString * const CellID = @"XiaoQLoginController";

@interface XiaoQLoginController ()

<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation XiaoQLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
}

- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 100;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            LoginController *loginVC = [[LoginController alloc] init];
            JABaseNavigationController *nav = [[JABaseNavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:nav  animated:YES completion:nil];
            
            break;
        }
        case 1: {
            //    GTModifyPhoneController *modifyPhoneVC = [[GTModifyPhoneController alloc] init];
            //    [self.navigationController pushViewController:modifyPhoneVC animated:YES];
            
            //    GTModifyEmailController *modifyEmailVC = [[GTModifyEmailController alloc] init];
            //    [self.navigationController pushViewController:modifyEmailVC animated:YES];
            
            //    GTModifyLoginPasswordController *modifyLoginPwVC = [[GTModifyLoginPasswordController alloc] init];
            //    [self.navigationController pushViewController:modifyLoginPwVC animated:YES];
            
            //    GTSetNewPayPasswordController *setNewPayPwVC = [[GTSetNewPayPasswordController alloc] init];
            //    [self.navigationController pushViewController:setNewPayPwVC animated:YES];
            
            //    GTModifyPayPasswordController *modifyPayPwVC = [[GTModifyPayPasswordController alloc] init];
            //    [self.navigationController pushViewController:modifyPayPwVC animated:YES];
            
            GTFindPayPasswordController *findPayPwVC = [[GTFindPayPasswordController alloc] init];
            [self.navigationController pushViewController:findPayPwVC animated:YES];
            
            break;
        }
        case 2: {
            
            break;
        }
        case 3: {
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"注册登录",
                       @"修改相关，自己打开其他",
                       ];
    }
    return _dataArray;
}

@end
