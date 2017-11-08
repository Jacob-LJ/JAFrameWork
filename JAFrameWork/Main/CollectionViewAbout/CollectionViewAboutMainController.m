//
//  CollectionViewAboutMainController.m
//  JAFrameWork
//
//  Created by Jacob on 2017/11/8.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "CollectionViewAboutMainController.h"
//vc
#import "SamplePubuController.h"

static NSString * const JACollectionViewAboutCellID = @"JACollectionViewAboutCell";

@interface CollectionViewAboutMainController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CollectionViewAboutMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:JACollectionViewAboutCellID];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); //所有边的布局
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JACollectionViewAboutCellID forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[SamplePubuController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
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
                       @"1 SamplePubuController \n 简单瀑布流CollectionView",
                       @"2",
                       @"3",
                       ];
    }
    return _dataArray;
}

@end
