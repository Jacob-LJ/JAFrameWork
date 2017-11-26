//
//  CodeSnippetsController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "CodeSnippetsController.h"

//vc
#import "View_tableView_MasController.h"
#import "View_MasController.h"
#import "View_CollectionV_Controller.h"
#import "Cell_CollectionV_Controller.h"

static NSString * const CodeSnippetsControllerID = @"CodeSnippetsController";

@interface CodeSnippetsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CodeSnippetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CodeSnippetsControllerID];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); //所有边的布局
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CodeSnippetsControllerID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[View_tableView_MasController alloc] init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[View_MasController alloc] init] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[View_CollectionV_Controller alloc] init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[Cell_CollectionV_Controller alloc] init] animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - getter & setter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @"jaView_tableView_Mas \njaCell_Mas",
                       @"View_MasController",
                       @"View_CollectionV_Controller \njaCCell_Mas",
                       @"Cell_CollectionV_Controller \njaCell_CollectionV_Mas "
                       ];
    }
    return _dataArray;
}

@end
