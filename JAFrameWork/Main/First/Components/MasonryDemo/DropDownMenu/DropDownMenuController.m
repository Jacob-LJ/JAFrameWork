//
//  DropDownMenuController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/23.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "DropDownMenuController.h"
//vc
#import "SampleDPMenuController.h"

static NSString * const CellID = @"DropDownMenuController";

@interface DropDownMenuController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DropDownMenuController

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
            SampleDPMenuController *sampleDPMenuVC = [[SampleDPMenuController alloc] init];
            [self.navigationController pushViewController:sampleDPMenuVC animated:YES];
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
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"简单下拉菜单",
                       ];
    }
    return _dataArray;
}

@end
