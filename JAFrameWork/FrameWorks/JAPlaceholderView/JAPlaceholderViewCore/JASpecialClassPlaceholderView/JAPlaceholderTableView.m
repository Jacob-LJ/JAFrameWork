//
//  JAPlaceholderTableView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/4.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAPlaceholderTableView.h"
//view
#import "JADefaultPlaceholderView.h"
//category
#import "NSObject+JAPlaceholderViewSwizzling.h"

@interface JAPlaceholderTableView ()

@property (nonatomic, assign) BOOL originalScrollEnabled; //用来记录UIScrollView最初的scrollEnabled

@end

@implementation JAPlaceholderTableView

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(JA_reloadData)];
    });
}

- (void)JA_reloadData {
    NSLog(@"调用 JAPlaceholderTableView - JA_reloadData");
    if (self.enableEmptyPlaceholderView) {
        
        // 先记录原本的scrollEnabled
        if (self.placeholderView.hidden || self.placeholderView == nil) {
            self.originalScrollEnabled = self.scrollEnabled;
        }
        
        //非首次刷新检测是否为空 解决数据加载未完成显示占位图情况
        if (!self.hidePlaceholderVWhenfirstReload) {
            [self checkEmpty];
        }
        self.hidePlaceholderVWhenfirstReload = NO;
    }
    
    
    [self JA_reloadData];
}


- (void)checkEmpty {
    
    BOOL isEmpty = YES;
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1; //默认只有一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前TableView各组行数
        if (rows) {
            isEmpty = NO; //若行数存在，不为空
        }
    }
    
    if (isEmpty) {
        //若为空，显示占位图
        if (!self.placeholderView) {
            //没有自定义，创建默认占位图
            [self createDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
        
        self.scrollEnabled = !self.disableScrollWhenShowPlaceholder;
        
    } else {
        //不为空，隐藏占位图
        self.placeholderView.hidden = YES;
        
        // 复原UIScrollView的scrollEnabled
        self.scrollEnabled = self.originalScrollEnabled;
    }
}

- (void)createDefaultPlaceholderView {
    
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    __weak typeof(self) weakSelf = self;
    JADefaultPlaceholderView *placeholderView = [[JADefaultPlaceholderView alloc] initWithFrame:self.bounds placeholderViewType:JAPlaceholderViewTypeNoData reloadBlock:^{
        if (weakSelf.defaultPlaceholderViewClickBlock) {
            weakSelf.defaultPlaceholderViewClickBlock();
        }
    }];
    
    self.placeholderView = placeholderView;
}

@end
