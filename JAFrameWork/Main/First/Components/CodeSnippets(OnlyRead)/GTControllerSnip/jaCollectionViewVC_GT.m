//
//  jaCollectionViewVC_GT.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "jaCollectionViewVC_GT.h"
//view
#import "GTShareItemCCell.h"

@interface jaCollectionViewVC_GT ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSInteger page;

@end

@implementation jaCollectionViewVC_GT

- (instancetype)init {
    if (self = [super init]) {
        [self setUpFlowLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    [self setUpNav];
    [self setUpCollectionView];
    
}

- (void)setUpFlowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth / 2.0, 100);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout = flowLayout;
}

- (void)setUpNav {
    
}

- (void)setUpCollectionView {
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = kColor_f6f6f6;
    self.collectionView.showsVerticalScrollIndicator  = NO;
    [self.view addSubview:self.collectionView];
    
    //register cell
    [self.collectionView registerClass:[GTShareItemCCell class] forCellWithReuseIdentifier:GTShareItemCCellID];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    kDefineWeakSelf;
    [self.collectionView Lee_normalHeaderRefreshWithBlock:^{
        [weakSelf getShopList];
    }];
    [self.collectionView Lee_normalFooterRefreshWithBlock:^{
        [weakSelf getMoreShoplist];
    }];
    
    [self.collectionView Lee_beginNormalHeaderRefresh];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GTShareItemCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTShareItemCCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 - %@", indexPath);
}

#pragma mark - private

#pragma mark - networking
- (void)getShopList {
    [self getShoplistWithCategoryNo:@""];
}

- (void)getShoplistWithCategoryNo:(NSString *)categoryNo {
//    self.page = 1;
//
//    NSDictionary *params = @{
//                             @"categoryNo" : kStringNullToempty(categoryNo),
//                             @"mallId" : kUserDefaultsGetMallId,
//                             @"pageNo" : @(self.page),
//                             @"pageSize" : @10,
//                             };
//
//    [self.view showLoadingView];
//    [GTDiscoveryNetWorking getDiscoveryShopListWithParams:params controller:nil completionHandler:^(GTDiscoveryShopListModel *responseObj, NSError *error, NSInteger statusCode) {
//
//        [self.view dismissLoadingView];
//        if (error) {
//            NSLog(@"%@", error);
//            [self.view showMessageView:nil text:error.localizedDescription];
//            self.isShowEmptyView = YES;
//            self.collectionView.mj_footer.hidden = YES;
//
//        } else {
//            //空状态处理
//            if (!responseObj.records.count) {
//                [self showEmptyView:YES];
//                self.collectionView.mj_footer.hidden = YES;
//            } else {
//                [self showEmptyView:NO];
//                self.collectionView.mj_footer.hidden = NO;
//            }
//        }
//
//        self.shopListModel = responseObj;
//        [self.collectionView reloadData];
//        [self.collectionView setContentOffset:CGPointZero animated:0];
        [self.collectionView Lee_endNormalFooterRefresh];
        [self.collectionView Lee_endNormalHeaderRefresh];
//    }];
}

- (void)getMoreShoplist {
    
//    self.page++;
//    NSDictionary *params = @{
//                             @"categoryNo" : kStringNullToempty(self.selectCategoryNo),
//                             @"mallId" : kUserDefaultsGetMallId,
//                             @"pageNo" : @(self.page),
//                             @"pageSize" : @10,
//                             };
//
//    [self.view showLoadingView];
//    [GTDiscoveryNetWorking getDiscoveryShopListWithParams:params controller:nil completionHandler:^(GTDiscoveryShopListModel *responseObj, NSError *error, NSInteger statusCode) {
//
//        [self.view dismissLoadingView];
//        if (error) {
//            NSLog(@"%@", error);
//            [self.view showMessageView:nil text:error.localizedDescription];
//            self.isShowEmptyView = YES;
//
//        } else {
//            //空状态处理
//            if (!responseObj.records.count) {
//                [self showEmptyView:YES];
//            } else {
//                [self showEmptyView:NO];
//            }
//
//            if (responseObj.records.count) {
//                NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
//                [arrayM addObjectsFromArray:self.shopListModel.records];
//                [arrayM addObjectsFromArray:responseObj.records];
//                self.shopListModel = responseObj;
//                self.shopListModel.records = arrayM;
//                [self.collectionView reloadData];
                [self.collectionView Lee_endNormalFooterRefresh];
//            } else {
//                [self.collectionView Lee_endNormalFooterRefreshWithNoMoreData];
//            }
//        }
//
//    }];
    
}

#pragma mark - empty action
- (void)showEmptyView:(BOOL)show {
    
    if (show) {
        self.isShowEmptyView = YES;
        self.tintStr = @"暂无店铺信息";
        //            self.tintImgName = @"general_message";
        //            self.tintBtnImgName = @"home_vote";
    } else {
        self.isShowEmptyView = NO;
    }
}

//点击图片
- (void)emptyDataSetImgDidTapNetWorking {
    [self.collectionView Lee_beginNormalHeaderRefresh];
}

//如果有按钮
- (void)emptyDataSetBtnDidTapNetWorking {
    NSLog(@"点击了空状态按钮事件");
}

@end
