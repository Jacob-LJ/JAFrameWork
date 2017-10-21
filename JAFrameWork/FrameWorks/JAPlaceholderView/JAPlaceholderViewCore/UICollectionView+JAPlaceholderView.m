//
//  UICollectionView+JAPlaceholderView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "UICollectionView+JAPlaceholderView.h"
#import "NSObject+JAPlaceholderViewSwizzling.h"
#import "JADefaultPlaceholderView.h"

@implementation UICollectionView (JAPlaceholderView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(JA_reloadData)];
    });
}

- (void)JA_reloadData {
    if (!self.firstReload) { //非首次刷新检测是否为空 解决数据加载未完成显示占位图情况
        [self checkEmpty];
    }
    self.firstReload = NO;
    [self JA_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES;
    
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource collectionView:self numberOfItemsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty) {//若为空，加载占位图
        //默认占位图
        if (!self.placeholderView) {
            [self createDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    } else {//不为空，移除占位图
        self.placeholderView.hidden = YES;
    }
}

- (void)createDefaultPlaceholderView {
    
    __weak typeof(self) weakSelf = self;
    JADefaultPlaceholderView *placeholderView = [[JADefaultPlaceholderView alloc] initWithFrame:self.bounds placeholderViewType:JAPlaceholderViewTypeNoData reloadBlock:^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
    
    self.placeholderView = placeholderView;
}

- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
