//
//  JAMasonryLayoutTestController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAMasonryLayoutTestController.h"
//vc
#import "JAMLKeyboardShowHideController.h"

static NSString * const JAMasonryLayoutTestCellID = @"JAMasonryLayoutTestCell";

@interface JAMasonryLayoutTestController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation JAMasonryLayoutTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[JAMLKeyboardShowHideController alloc] init] animated:YES];
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
                       @"1 keyboard show hide",
                       @"2",
                       @"3",
                       ];
    }
    return _dataArray;
}

@end
