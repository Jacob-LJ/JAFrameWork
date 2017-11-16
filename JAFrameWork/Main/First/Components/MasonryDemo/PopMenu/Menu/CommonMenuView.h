//
//  CommonMenuView.h
//  PopMenuTableView
//
//  Created by 孔繁武 on 2016/12/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuModel.h"

typedef void(^ItemsClickBlock)(NSString *str, NSInteger tag);
typedef void(^BackViewTapBlock)(void);

@interface CommonMenuView : UIView
/* 菜单点击回掉，默认值：6; */
@property (nonatomic,copy) ItemsClickBlock itemsClickBlock;

@property (nonatomic,copy) BackViewTapBlock backViewTapBlock;
/* 最多菜单项个数，默认值：6; */
@property (nonatomic,assign) NSInteger maxValueForItemCount;

/**
 *  @param frame            菜单frame, 可以传CGRectZero，宽度默认120，高度自适应
 *  @param dataArray        菜单项内容
 *  @param itemsClickBlock  点击某个菜单项的blick
 *  @param backViewTapBlock 点击背景遮罩的block
 */
+ (CommonMenuView *)createMenuWithFrame:(CGRect)frame dataArray:(NSArray<MenuModel *> *)dataArray itemsClickBlock:(void(^)(NSString *str, NSInteger tag))itemsClickBlock backViewTap:(void(^)(void))backViewTapBlock;

/**
 *  @param point 展示坐标
 */
+ (void)showMenuAtPoint:(CGPoint)point;

/* 隐藏菜单 */
+ (void)hideMenu;

/* 移除菜单 */
+ (void)clearMenu;

/**
 *  @param appendItemsArray 需要追加的菜单项内容数组
 */
+ (void)appendMenuItemsWith:(NSArray<MenuModel *> *)appendItemsArray;

/**
 *  @param newItemsArray 需要更新的菜单项内容数组
 */
+ (void)updateMenuItemsWith:(NSArray<MenuModel *> *)newItemsArray;


@end
