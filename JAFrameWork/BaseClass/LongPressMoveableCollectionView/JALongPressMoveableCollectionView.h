//
//  JALongPressMoveableCollectionView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JALongPressMoveableCollectionView;

@protocol JALongPressMoveableCollectionViewDataSource <UICollectionViewDataSource>

@required
/**
 *  获取tableView的数据源数组
 */
- (NSArray *)dataSourceArrayInMoveCellCollectionView:(JALongPressMoveableCollectionView *)collectionView;
/**
 *  返回移动之后调换后的数据源
 */
- (void)collectionView:(JALongPressMoveableCollectionView *)collectionView freshDataSourceArrayAfterMove:(NSArray *)newDataSourceArray;

@end

@protocol JALongPressMoveableCollectionViewDelegate <UICollectionViewDelegate>

/**
 *  移动的开始和结束位置
 */
- (void)collectionView:(JALongPressMoveableCollectionView *)collectionView FromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@interface JALongPressMoveableCollectionView : UICollectionView

//用于移动的数据源
@property (nonatomic, weak) id<JALongPressMoveableCollectionViewDataSource> moveableDataSource;
@property (nonatomic, weak) id<JALongPressMoveableCollectionViewDelegate> moveableeDlegate;

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

@property (nonatomic, assign) CGFloat snapShotViewAlpha; ///< 拖动图的alpha值
@property (nonatomic, assign) BOOL showSnapshotView; ///< 使用继承于HLMMoveableCollectonViewCell的snapshotV作为截图view

@property (nonatomic, assign) BOOL redefineDragCellAction; ///< 自定义cell开始拖动和结束拖动时候的动作 default is NO, if YES, fill action -beginDraggBlock and -endDragBlock  in cell which inherit HLMMoveableCollectonViewCell;

@property (nonatomic, strong) NSIndexPath *freezeIndexPath; ///< 不进行交换的特殊indexPath


@end
