//
//  MasonryDemoMianController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "MasonryDemoMianController.h"
//vc
#import "MTKeyboardShowHideController.h"
#import "CTComment9PicsController.h"
#import "SearchBarandHistoryController.h"

static NSString * const JAMasonryLayoutTestCellID = @"JAMasonryLayoutTestCell";

@interface MasonryDemoMianController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MasonryDemoMianController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JAMasonryLayoutTestCellID];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); //所有边的布局
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JAMasonryLayoutTestCellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[MTKeyboardShowHideController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[CTComment9PicsController alloc] init] animated:YES];
            break;
        case 2:
            [self presentViewController:[[SearchBarandHistoryController alloc] init] animated:YES completion:NULL];
            break;
        case 3:
            break;
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"0 MTKeyboardShowHideController \n 使用 masonry 显示隐藏键盘",
                       @"1 CTComment9PicsController \n  九宫格评论",
                       @"2 SearchBarandHistoryController \n 简单Nav内的searchBar和靠左的 collectionView搜索关键字历史记录",
                       
                       ];
    }
    return _dataArray;
}

@end
