//
//  JALongPressMoveableTableView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

//长按进入移动cell样式

#import <UIKit/UIKit.h>

@class JALongPressMoveableTableView;

@protocol JALongPressMoveableTableViewDataSource <UITableViewDataSource>

@required
/**
 *  获取tableView的数据源数组
 */
- (NSArray *)dataSourceArrayInMoveCellTableView:(JALongPressMoveableTableView *)tableView;

/**
 *  返回移动之后调换后的数据源
 */
- (void)tableView:(JALongPressMoveableTableView *)tableView freshDataSourceArrayAfterMove:(NSArray *)newDataSourceArray;

@end

@protocol JALongPressMoveableTableViewDelegate <UITableViewDelegate>

/**
 *  移动的开始和结束位置
 */
- (void)tableView:(JALongPressMoveableTableView *)tableView FromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end



@interface JALongPressMoveableTableView : UITableView

//用于移动的数据源
@property (nonatomic, weak) id<JALongPressMoveableTableViewDataSource> moveableDataSource;

@property (nonatomic, weak) id<JALongPressMoveableTableViewDelegate> moveableDelegate;

/**
 *  是否允许长按拖动交换数据
 */
@property (nonatomic, assign) BOOL canExchangeData;
/**
 *  是否允许拖动到屏幕边缘后，开启边缘滚动，默认YES
 */
@property (nonatomic, assign) BOOL canEdgeScroll;
/**
 *  边缘滚动触发范围，默认150，越靠近边缘速度越快
 */
@property (nonatomic, assign) CGFloat edgeScrollRange;

@end
