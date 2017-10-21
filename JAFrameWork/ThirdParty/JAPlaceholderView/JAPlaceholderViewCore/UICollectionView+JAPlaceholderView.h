//
//  UICollectionView+JAPlaceholderView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (JAPlaceholderView)

@property (nonatomic, assign) BOOL firstReload; //是否在第一次 reloadData 之前不展示 placeHolderView，default NO;
@property (nonatomic, weak) UIView *placeholderView; //可自定义占位图
@property (nonatomic, copy) void(^reloadBlock)(void); //点击 placeholderView actionBlcok

@end
