//
//  JAPlaceholderViewTestController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAPlaceholderViewTestController.h"
//vc
#import "DefaultPlaceholderVController.h"

static NSString * const JAPlaceholderViewTestCellID = @"JAPlaceholderViewTestCellID";

@interface JAPlaceholderViewTestController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation JAPlaceholderViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JAPlaceholderViewTestCellID];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JAPlaceholderViewTestCellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[DefaultPlaceholderVController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[UIViewController alloc]init ] animated:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"DefaultPlaceholder",
                       @"CustomPlaceholder",
                       @"MultiGroupTableView",
                       ];
    }
    return _dataArray;
}

@end
