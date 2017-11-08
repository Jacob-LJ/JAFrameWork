//
//  LayoutDemoMianController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "LayoutDemoMianController.h"
//vc
#import "LDTranslatesAutoresizingMaskController.h"
#import "SearchBarandHistoryView.h"

static NSString * const JALayoutDemoCellID = @"JALayoutDemoCell";

@interface LayoutDemoMianController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LayoutDemoMianController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JALayoutDemoCellID];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); //所有边的布局
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JALayoutDemoCellID forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[LDTranslatesAutoresizingMaskController alloc] init] animated:YES];
            break;
        case 1:
            [self presentViewController:[[SearchBarandHistoryView alloc] init] animated:YES completion:NULL];
            break;
        case 2:
            [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"1 UIViewProperty \n translatesAutoresizingMaskIntoConstraints",
                       @"2 SearchBarandHistoryView \n 简单Nav内的searchBar和靠左的 collectionView搜索关键字历史记录",
                       @"3",
                       ];
    }
    return _dataArray;
}

@end

