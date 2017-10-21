//
//  UITableView+JAPlaceholderView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "UITableView+JAPlaceholderView.h"
#import "NSObject+JAPlaceholderViewSwizzling.h"
#import "JADefaultPlaceholderView.h"

@interface UITableView ()

@property (nonatomic, assign) BOOL originalScrollEnabled; //用来记录UIScrollView最初的scrollEnabled

@end

@implementation UITableView (JAPlaceholderView)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
//                               bySwizzledSelector:@selector(JA_reloadData)];
//    });
//}
//
//- (void)JA_reloadData {
//    NSLog(@"调用 - JA_reloadData");
//    if (self.enableEmptyPlaceholderView) {
//
//        // 先记录原本的scrollEnabled
//        if (self.placeholderView.hidden || self.placeholderView == nil) {
//            self.originalScrollEnabled = self.scrollEnabled;
//        }
//
//        //非首次刷新检测是否为空 解决数据加载未完成显示占位图情况
//        if (!self.hidePlaceholderVWhenfirstReload) {
//            [self checkEmpty];
//        }
//        self.hidePlaceholderVWhenfirstReload = NO;
//    }
//
//
//    [self JA_reloadData];
//}
//
//
//- (void)checkEmpty {
//
//    BOOL isEmpty = YES;
//
//    id <UITableViewDataSource> dataSource = self.dataSource;
//    NSInteger sections = 1; //默认只有一组
//    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
//        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
//    }
//
//    for (NSInteger i = 0; i <= sections; i++) {
//        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前TableView各组行数
//        if (rows) {
//            isEmpty = NO; //若行数存在，不为空
//        }
//    }
//
//    if (isEmpty) {
//        //若为空，显示占位图
//        if (!self.placeholderView) {
//            //没有自定义，创建默认占位图
//            [self createDefaultPlaceholderView];
//        }
//        self.placeholderView.hidden = NO;
//        [self addSubview:self.placeholderView];
//
//        self.scrollEnabled = !self.disableScrollWhenShowPlaceholder;
//
//    } else {
//        //不为空，隐藏占位图
//        self.placeholderView.hidden = YES;
//
//        // 复原UIScrollView的scrollEnabled
//        self.scrollEnabled = self.originalScrollEnabled;
//    }
//}
//
//- (void)createDefaultPlaceholderView {
//
//    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//
//    __weak typeof(self) weakSelf = self;
//    JADefaultPlaceholderView *placeholderView = [[JADefaultPlaceholderView alloc] initWithFrame:self.bounds placeholderViewType:JAPlaceholderViewTypeNoData reloadBlock:^{
//        if (weakSelf.defaultPlaceholderViewClickBlock) {
//            weakSelf.defaultPlaceholderViewClickBlock();
//        }
//    }];
//
//    self.placeholderView = placeholderView;
//}
//
//#pragma mark - setter & getter
////可自定义占位图
//- (UIView *)placeholderView {
//    return objc_getAssociatedObject(self, @selector(placeholderView));
//}
//
//- (void)setPlaceholderView:(UIView *)placeholderView {
//    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
////是否在第一次 reloadData 之前不展示 placeHolderView，default NO;
//- (BOOL)hidePlaceholderVWhenfirstReload {
//    return [objc_getAssociatedObject(self, @selector(hidePlaceholderVWhenfirstReload)) boolValue];
//}
//
//- (void)setHidePlaceholderVWhenfirstReload:(BOOL)hidePlaceholderVWhenfirstReload {
//    objc_setAssociatedObject(self, @selector(hidePlaceholderVWhenfirstReload), @(hidePlaceholderVWhenfirstReload), OBJC_ASSOCIATION_ASSIGN);
//}
//
////点击默认 placeholderView actionBlcok
//- (void (^)(void))defaultPlaceholderViewClickBlock {
//    return objc_getAssociatedObject(self, @selector(defaultPlaceholderViewClickBlock));
//}
//
//- (void)setDefaultPlaceholderViewClickBlock:(void (^)(void))defaultPlaceholderViewClickBlock {
//    objc_setAssociatedObject(self, @selector(defaultPlaceholderViewClickBlock), defaultPlaceholderViewClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
////用来记录UIScrollView最初的scrollEnabled
//- (BOOL)originalScrollEnabled {
//    return [objc_getAssociatedObject(self, @selector(originalScrollEnabled)) boolValue];
//}
//
//- (void)setOriginalScrollEnabled:(BOOL)originalScrollEnabled {
//    objc_setAssociatedObject(self, @selector(originalScrollEnabled), @(originalScrollEnabled), OBJC_ASSOCIATION_ASSIGN);
//}
//
////当显示 PlaceholderView时候不能滚动，default NO;
//- (BOOL)disableScrollWhenShowPlaceholder {
//    return [objc_getAssociatedObject(self, @selector(disableScrollWhenShowPlaceholder)) boolValue];
//}
//
//- (void)setDisableScrollWhenShowPlaceholder:(BOOL)disableScrollWhenShowPlaceholder {
//    return objc_setAssociatedObject(self, @selector(disableScrollWhenShowPlaceholder), @(disableScrollWhenShowPlaceholder), OBJC_ASSOCIATION_ASSIGN);
//}
//
////是否开启空状态占位图展示，default NO;
//- (BOOL)enableEmptyPlaceholderView {
//    return [objc_getAssociatedObject(self, @selector(enableEmptyPlaceholderView)) boolValue];
//}
//
//- (void)setEnableEmptyPlaceholderView:(BOOL)enableEmptyPlaceholderView {
//    objc_setAssociatedObject(self, @selector(enableEmptyPlaceholderView), @(enableEmptyPlaceholderView), OBJC_ASSOCIATION_ASSIGN);
//}

@end
