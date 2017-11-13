//
//  DefaultPlaceholderVController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "DefaultPlaceholderVController.h"
#import "JAPlaceholderView.h"

#import "JAPlaceholderTableView.h"

static NSString * const DefaultPlaceholderVCellID = @"DefaultPlaceholderVCell";

@interface DefaultPlaceholderVController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JAPlaceholderTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation DefaultPlaceholderVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpTableView];
}

- (void)setUpInit {
    
    self.title = @"TableViewDefaultPlaceholderVController";
    _dataArr = [[NSMutableArray alloc] init];
}

- (void)setUpTableView {
    
    _tableView = [[JAPlaceholderTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultPlaceholderVCellID];
    
    
    //设置 PlaceholderView 行为
    _tableView.enableEmptyPlaceholderView = YES;
    __weak typeof(self) weakSelf = self;
    //点击默认 placeholderView actionBlcok
    _tableView.defaultPlaceholderViewClickBlock = ^{
        [weakSelf refresh];
    };
    
    //在第一次 reloadData 之前不展示 placeHolderView
    _tableView.hidePlaceholderVWhenfirstReload = YES;
    //当显示 PlaceholderView时候不能滚动
    _tableView.disableScrollWhenShowPlaceholder = YES;
    
    [self.view addSubview:_tableView];
    
    //模拟刷新操作
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
}

- (void)refresh {
    //模拟刷新 偶数调用有数据 奇数无数据
    [_refreshControl beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        static NSUInteger i = 0;
        if (i %2 == 0) {
            for (NSInteger i = 0; i < arc4random()%10 + 1; i++) {
                [_dataArr addObject:[NSString stringWithFormat:@"Jacob Ramdon Test Data - %ld",i]];
            }
            NSLog(@"有 - 数据返回");
        } else {
            [_dataArr removeAllObjects];
            NSLog(@"没有 - 数据返回");
        }
        i++;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_refreshControl endRefreshing];
        });
    });
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultPlaceholderVCellID];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

@end
