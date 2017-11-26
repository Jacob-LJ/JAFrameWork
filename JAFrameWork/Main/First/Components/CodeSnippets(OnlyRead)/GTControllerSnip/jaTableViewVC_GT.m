//
//  jaTableViewVC_GT.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "jaTableViewVC_GT.h"
//view
#import "GTFoodSpecialOffersTableViewCell.h"

@interface jaTableViewVC_GT ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation jaTableViewVC_GT

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    [self setUpTableView];
    
}

- (void)setUpInit {
    self.page = 1;
}

- (void)setUpNav {
    self.title = @"TableViewVC";
}

- (void)setUpTableView {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GTFoodSpecialOffersTableViewCell class] forCellReuseIdentifier:@"GTFoodSpecialOffersTableViewCell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    if (kUI_IPhoneX) {
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 20)];
    }
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    kDefineWeakSelf;
    [self.tableView Lee_normalHeaderRefreshWithBlock:^{
        [weakSelf getListInfo];
    }];
    [self.tableView Lee_normalFooterRefreshWithBlock:^{
        [weakSelf getMoreListInfo];
    }];
    [self.tableView Lee_beginNormalHeaderRefresh];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTFoodSpecialOffersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GTFoodSpecialOffersTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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

#pragma mark - private


#pragma mark - net
//获取列表信息
- (void)getListInfo {
    
//    self.page = 1;
//    NSDictionary *params = @{
//                             @"sortType" : @(self.selectedSortType), //category默认是0，sort默认是1
//                             @"categoryType" : @(self.selectedCategroyType),
//                             @"pageNo" : @(self.page),
//                             @"pageSize" : @10,
//                             };
//    [GTDiscoveryNetworking discoveryListWithParams:params controller:nil completionHandler:^(GTDiscoveryListModel *responseObj, NSError *error, NSInteger statusCode) {
//
//        if (!error) {
//            self.listModel = responseObj;
//            if (responseObj.displayPage.records.count) {
//                [self showEmptyView:NO];
//            } else {
//                [self showEmptyView:YES];
//            }
//        } else {
//            //
//            self.isShowEmptyView = YES;
//        }
        [self.tableView reloadData];
        [self.tableView Lee_endNormalHeaderRefresh];
        [self.tableView Lee_endNormalFooterRefresh];
//    }];
}

- (void)getMoreListInfo {
    
//    self.page++;
//    NSDictionary *params = @{
//                             @"sortType" : @(self.selectedSortType),
//                             @"categoryType" : @(self.selectedCategroyType),
//                             @"pageNo" : @(self.page),
//                             @"pageSize" : @10,
//                             };
//    [GTDiscoveryNetworking discoveryListWithParams:params controller:nil completionHandler:^(GTDiscoveryListModel *responseObj, NSError *error, NSInteger statusCode) {
//
//        if (!error) {
//            if (responseObj.displayPage.records.count) {
//                NSMutableArray *recordsM = [NSMutableArray arrayWithArray:self.listModel.displayPage.records];
//                [recordsM addObjectsFromArray:responseObj.displayPage.records];
//                self.listModel = responseObj;
//                self.listModel.displayPage.records = recordsM;
                [self.tableView Lee_endNormalFooterRefresh];
//            } else {
//                [self.tableView Lee_endNormalFooterRefreshWithNoMoreData];
//            }
//
//        } else {
//            //
//        }
//        [self.tableView reloadData];
//
//    }];
}

#pragma mark - empty action
- (void)showEmptyView:(BOOL)show {
    
    if (show) {
        self.isShowEmptyView = YES;
        self.tintStr = @"暂无活动信息";
//            self.tintImgName = @"general_message";
//            self.tintBtnImgName = @"home_vote";
    } else {
        self.isShowEmptyView = NO;
    }
}

- (void)emptyDataSetImgDidTapNetWorking {
    [self.tableView Lee_beginNormalHeaderRefresh];
    
}

- (void)emptyDataSetBtnDidTapNetWorking {
    NSLog(@"点击了空状态按钮事件");
}

@end
