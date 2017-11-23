//
//  SampleDPMenuController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/23.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SampleDPMenuController.h"
//vc
#import "GTDiscoverySortController.h"
#import "GTDiscoveryFilterController.h"
//view
#import "GTDiscoveryCell.h"
#import "YZPullDownMenu.h"
#import "JAButton.h"

static const CGFloat kPullDownMenuH = 40;

@interface SampleDPMenuController ()<UITableViewDelegate, UITableViewDataSource, YZPullDownMenuDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation SampleDPMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    [self setUpPullDownMenu];
    [self setUpTableView];
    
}

- (void)setUpInit {
    
}

- (void)setUpPullDownMenu {
    
    // 初始化标题
    _titles = @[@"智能排序",@"分类筛选"];
    
    YZPullDownMenu *menu = [[YZPullDownMenu alloc] init];
    menu.frame = CGRectMake(0, JANavBarH, kScreenWidth, kPullDownMenuH);
    menu.separateLineColor = [UIColor clearColor];
    menu.coverColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self.view addSubview:menu];
    menu.dataSource = self;
    
    // 添加子控制器
    [self setupAllChildViewController];
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController {
    GTDiscoverySortController *sortVC = [[GTDiscoverySortController alloc] init];
    GTDiscoveryFilterController *filterVC = [[GTDiscoveryFilterController alloc] init];
    [self addChildViewController:sortVC];
    [self addChildViewController:filterVC];
}

- (void)setUpNav {
    self.title = @"发现";
}

- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 100;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[GTDiscoveryCell class] forCellReuseIdentifier:GTDiscoveryCellID];
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kPullDownMenuH+JANavBarH);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    if (isiPhoneX) {
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, JAScreenW, 20)];
    }
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTDiscoveryCell *cell = [tableView dequeueReusableCellWithIdentifier:GTDiscoveryCellID forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGTDiscoveryCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu {
    return _titles.count;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index {
    
    JAButton *button = [JAButton JAButtonWithType:JAButtonTypeHorizontalCenterLabelImage spacing:2];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontRegular14];
    [button setTitleColor:[UIColor color9999] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor color3333] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"discoever_sort_gray_down"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"discoever_sort_black_down"] forState:UIControlStateSelected];
    pullDownMenu.otherSelectedImage = [UIImage imageNamed:@"discoever_sort_black_up"];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index {
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index {
    return 200;
}


@end
