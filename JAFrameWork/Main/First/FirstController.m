//
//  FirstController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "FirstController.h"

//testDemo
#import "CodeSnippetsController.h"
#import "JAPlaceholderViewTestController.h"
#import "MasonryDemoMianController.h"
#import "LayoutDemoMianController.h"

static NSString * const MainCellID = @"MainCell";

@interface FirstController ()

<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FirstController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //加载本地Json文件转数组
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"json"]; //path 为 nil 时需要检查，Cities.json 文件是否已添加到 copy bundle resources内
//    NSError *error = nil;
//    NSData *jsonData = [NSData dataWithContentsOfFile:path];
//
//    NSArray *citys = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                     options:NSJSONReadingAllowFragments
//                                                       error:&error
//                      ];
    
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
            //常用代码片段
            [self.navigationController pushViewController:[[CodeSnippetsController alloc] init] animated:YES];
            break;
        }
        case 1: {
            //masonry 布局 Demo
            [self.navigationController pushViewController:[[MasonryDemoMianController alloc] init] animated:YES];
            break;
        }
        case 2: {
            //tableView 或 collectionView 的空状态占位视图
            [self.navigationController pushViewController:[[JAPlaceholderViewTestController alloc] init] animated:YES];
            break;
        }
        case 3: {
            //布局相关知识点 Demo
            [self.navigationController pushViewController:[[LayoutDemoMianController alloc] init] animated:YES];
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
                       @"CodeSnippets",
                       @"控件集(masonry布局)\nMasonryDemoMianController",
                       @"tableView 或 collectionView 的空状态占位视图\nJAPlaceholderViewTestController",
                       @"布局相关知识点\nLayoutDemoMianController",
                       ];
    }
    return _dataArray;
}

@end
