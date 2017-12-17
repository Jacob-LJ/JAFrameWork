//
//  SecondController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SecondController.h"
//vc
#import "JACVTabBarController.h"

static NSString * const MainCellID = @"MainCell";

@interface SecondController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SecondController

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
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MainCellID];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellID forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            case 0: {
                //
                JACVTabBarController *tabBarVC = [JACVTabBarController shareInstance];
                tabBarVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tabBarVC animated:YES];
                break;
            }
            case 1: {

                break;
            }
            case 2: {

                break;
            }
            case 3: {
                break;
            }
            case 4: {
                
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
                       @"CenterView Tabar Demo",
                       ];
    }
    return _dataArray;
}

@end
