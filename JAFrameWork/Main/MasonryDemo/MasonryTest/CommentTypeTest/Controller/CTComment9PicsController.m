//
//  CTComment9PicsController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "CTComment9PicsController.h"
//view
#import "CT9PicsCell.h"
//model
#import "CTCommentFrameModel.h"
#import "CTCommentModel.h"
//uitil
//#import "XLPhotoBrowser.h"

static NSString * const CT9PicsCellID = @"CT9PicsCell";

@interface CTComment9PicsController ()<UITableViewDelegate, UITableViewDataSource>//, XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) XLPhotoBrowser *selBrowser;

@end

@implementation CTComment9PicsController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self prepareData];
    
}

- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //屏蔽iOS 11的self-sizing
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    //
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CT9PicsCell class] forCellReuseIdentifier:CT9PicsCellID];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
    }];
    
    //    JAWeakSelf;
    //    [self.tableView Lee_normalHeaderRefreshWithBlock:^{
    //        [weakSelf refreshData];
    //    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CT9PicsCell *cell = [tableView dequeueReusableCellWithIdentifier:CT9PicsCellID forIndexPath:indexPath];
    JAWeakSelf;
    CTCommentFrameModel *frameModel = self.dataArray[indexPath.row];
    cell.foldOrNotBlock = ^{
        frameModel.foldUpContent = !frameModel.isFoldUpContent;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.clickImageIndexBlock = ^(NSInteger index) {
        [weakSelf showBroswerViewWithIndex:index modelImageNum:frameModel.model.imageCount];
    };
    [cell configCellFrameModel:frameModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTCommentFrameModel *frameModel = self.dataArray[indexPath.row];
    return frameModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

#pragma mark - private action
- (void)refreshData {
    [self prepareData];
    [self.tableView reloadData];
    //    [self.tableView Lee_endNormalHeaderRefresh];
}


- (void)showBroswerViewWithIndex:(NSInteger)index modelImageNum:(NSInteger)imageNum {
    //
    //    NSArray *strings = @[
    //                         @"http://img.wdjimg.com/image/video/d999011124c9ed55c2dd74e0ccee36ea_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2ddcad6dcc38c5ca88614b7c5543199a_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/6d6ccfd79ee1deac2585150f40915c09_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2111a863ea34825012b0c5c9dec71843_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/b4085a983cedd8a8b1e83ba2bd8ecdd8_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2d59165e816151350a2b683b656a270a_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/dc2009ee59998039f795fbc7ac2f831f_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/d999011124c9ed55c2dd74e0ccee36ea_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2ddcad6dcc38c5ca88614b7c5543199a_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/6d6ccfd79ee1deac2585150f40915c09_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2111a863ea34825012b0c5c9dec71843_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/b4085a983cedd8a8b1e83ba2bd8ecdd8_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/2d59165e816151350a2b683b656a270a_0_0.jpeg",
    //                         @"http://img.wdjimg.com/image/video/dc2009ee59998039f795fbc7ac2f831f_0_0.jpeg"
    //                         ];
    //
    //    NSMutableArray *imageUrls = [NSMutableArray array];
    //    for (int i = 0; i < imageNum; i++) {
    //        [imageUrls addObject:strings[i]];
    //    }
    //
    //    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:imageUrls currentImageIndex:index];
    //    browser.browserStyle = XLPhotoBrowserStyleSimple;
    //    self.selBrowser = browser;
    //    self.selBrowser.delegate = self;
}

#pragma mark - setter & getter
- (void)prepareData {
    //产生9个数字+三个随机字母
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i =0; i<20; i++) {
        CTCommentModel *commentModel = [[CTCommentModel alloc] init];
        NSInteger state = (arc4random() % 3);
        switch (state) {
            case 0: {
                commentModel.content = @"我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒我是设计的卡号富士康和饭卡和府撒";
                break;
            }
            case 1: {
                commentModel.content = @"这是测试数据这是测试数据这是测试数据这是测试数据这是测试数据这是测试数据卡号富士";
                break;
            }
            case 2: {
                commentModel.content = @"";
                break;
            }
                
            default:
                break;
        }
        commentModel.imageCount = (arc4random() % 10);
        
        CTCommentFrameModel *frameModel = [[CTCommentFrameModel alloc] init];
        frameModel.model = commentModel;
        [array addObject:frameModel];
    }
    
    self.dataArray = [array copy];
}

@end
