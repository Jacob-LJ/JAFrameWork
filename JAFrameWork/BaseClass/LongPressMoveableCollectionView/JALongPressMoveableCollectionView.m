//
//  JALongPressMoveableCollectionView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JALongPressMoveableCollectionView.h"
#import "JAMoveableCollectonViewBaseCell.h"

@interface JALongPressMoveableCollectionView ()

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;
@property (strong, nonatomic) NSIndexPath *draggedCellIndexPath;
@property (nonatomic, strong) NSMutableArray *tempDataSource;
@property (nonatomic, strong) UIView *snapshot;

@property (nonatomic, strong) CADisplayLink *edgeScrollTimer;

@property (nonatomic, strong) NSIndexPath *starPositionIndexPath;
@property (nonatomic, strong) NSIndexPath *endPositionIndexPath;

@property (nonatomic, strong) JAMoveableCollectonViewBaseCell *draggingCell;

@end

@implementation JALongPressMoveableCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initData];
        [self addGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self addGesture];
    }
    return self;
}

- (void)initData {
    
    _canExchangeData = YES;
    _canEdgeScroll = YES;
    _edgeScrollRange = 30.f;
}

#pragma mark - Add Gesture

- (void)addGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:longPress];
    self.longPressRecognizer = longPress;
}

#pragma mark - LongPress Action
- (void)handleLongPress:(UILongPressGestureRecognizer *)longPressRecognizer {
    if (!_canExchangeData) return;
    
    CGPoint touchLocation = [longPressRecognizer locationInView:self];
    NSIndexPath *touchIndexPath = [self indexPathForItemAtPoint:touchLocation];
    
    switch (longPressRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            NSLog(@"Began - 开始");
            if (_canEdgeScroll) {
                //开启边缘滚动
                [self startEdgeScroll];
            }
            
            //每次移动开始获取一次数据源
            if (self.moveableDataSource && [self.moveableDataSource respondsToSelector:@selector(dataSourceArrayInMoveCellCollectionView:)]) {
                self.tempDataSource = [self.moveableDataSource dataSourceArrayInMoveCellCollectionView:self].mutableCopy;
            }
            self.draggedCellIndexPath = touchIndexPath;
            self.starPositionIndexPath = touchIndexPath;
            
            if (self.draggedCellIndexPath != nil) {
                
                JAMoveableCollectonViewBaseCell *draggedCell = (JAMoveableCollectonViewBaseCell *)[self cellForItemAtIndexPath:touchIndexPath];
                self.draggingCell = draggedCell;
                self.snapshot = [self customSnapshoFromView:draggedCell];
                self.snapshot.center = draggedCell.center;
                [self addSubview:self.snapshot];
                
                [UIView animateWithDuration:0.25 animations:^{
                    self.snapshot.center = CGPointMake(touchLocation.x, touchLocation.y);
                    self.snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    
                    if (self.redefineDragCellAction) {
                        if ([draggedCell isKindOfClass:[JAMoveableCollectonViewBaseCell class]]) {
                            JAMoveableCollectonViewBaseCell *cell = (JAMoveableCollectonViewBaseCell *)draggedCell;
                            if (cell.beginDraggBlock) {
                                cell.beginDraggBlock();
                            }
                        } else {
                            draggedCell.hidden = YES;
                        }
                    } else {
                        draggedCell.hidden = YES;
                    }
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            NSLog(@"Changed - 变化");
            if (!_canEdgeScroll) {
                if (self.draggedCellIndexPath != nil && ![touchIndexPath isEqual:self.draggedCellIndexPath]) {
                    [self updateDataSourceAndCellFromIndexPath:self.draggedCellIndexPath toIndexPath:touchIndexPath];
                }
                self.snapshot.center = CGPointMake(touchLocation.x, touchLocation.y);
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"Ended or Cancelled - 结束 - %ld",longPressRecognizer.state);
            if (_canEdgeScroll) {
                [self stopEdgeScroll];
            }
            
            if (self.draggedCellIndexPath != nil ) {
                
                //                UICollectionViewCell *draggedCell = [self cellForItemAtIndexPath:self.draggedCellIndexPath];
                JAMoveableCollectonViewBaseCell *draggedCell = self.draggingCell;
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.snapshot.center = draggedCell.center;
                    self.snapshot.transform = CGAffineTransformIdentity;
                    
                } completion:^(BOOL finished) {
                    
                    if (self.redefineDragCellAction) {
                        if ([draggedCell isKindOfClass:[JAMoveableCollectonViewBaseCell class]]) {
                            
                            if (draggedCell.endDragBlock) {
                                draggedCell.endDragBlock();
                            }
                        } else {
                            draggedCell.hidden = NO;
                        }
                    } else {
                        draggedCell.hidden = NO;
                    }
                    
                    self.draggedCellIndexPath = nil;
                    [self.snapshot removeFromSuperview];
                    self.snapshot = nil;
                    
                }];
            }
            
            
            self.endPositionIndexPath = self.draggedCellIndexPath;
            if (!(self.starPositionIndexPath.section == self.endPositionIndexPath.section && self.starPositionIndexPath.row == self.endPositionIndexPath.row)) {
                //通知代理完成交换后,交换的前后indexpath
                if ([self.moveableeDlegate respondsToSelector:@selector(collectionView:FromIndexPath:toIndexPath:)]) {
                    [self.moveableeDlegate collectionView:self FromIndexPath:self.starPositionIndexPath toIndexPath:self.endPositionIndexPath];
                }
                
                //返回交换后的数据源
                if (self.moveableDataSource && [self.moveableDataSource respondsToSelector:@selector(collectionView:freshDataSourceArrayAfterMove:)]) {
                    [self.moveableDataSource collectionView:self freshDataSourceArrayAfterMove:self.tempDataSource.copy];
                }
                
            }
            
        }
            
        default:
            break;
    }
}



- (void)gestureRecognizedChange:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint location = [longPress locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:location];
    
    if (indexPath && ![indexPath isEqual:self.draggedCellIndexPath]) {
        //交换数据源和cell
        [self updateDataSourceAndCellFromIndexPath:self.draggedCellIndexPath toIndexPath:indexPath];
        
    }
    
    self.snapshot.center = CGPointMake(location.x, location.y);
    
}

#pragma mark - UpdateDataSource Action

//TODO: 没处理多组情况
- (void)updateDataSourceAndCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (toIndexPath.item >= self.tempDataSource.count) return;
    BOOL moveItemIsFreezeItem = fromIndexPath.section == self.freezeIndexPath.section && fromIndexPath.item == self.freezeIndexPath.item;
    BOOL moveItemToFreezeItem = toIndexPath.section == self.freezeIndexPath.section && toIndexPath.item == self.freezeIndexPath.item;
    if (moveItemIsFreezeItem || moveItemToFreezeItem) return;
    
    id dragModel = self.tempDataSource[fromIndexPath.item];
    [self.tempDataSource removeObject:dragModel];
    [self.tempDataSource insertObject:dragModel atIndex:toIndexPath.item];
    
    [self moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    
    self.draggedCellIndexPath = toIndexPath;
}

#pragma mark - EdgeScroll
- (void)startEdgeScroll {
    self.edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(processEdgeScroll)];
    [self.edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)processEdgeScroll {
    [self gestureRecognizedChange:self.longPressRecognizer];
    
    if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        if (flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            
            CGFloat minOffsetY = self.contentOffset.y + _edgeScrollRange;
            CGFloat maxOffsetY = self.contentOffset.y + self.bounds.size.height - _edgeScrollRange;
            CGPoint touchPoint = self.snapshot.center;
            //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是tableView还未显示完，需要显示完tableView才停止滚动
            if (touchPoint.y < _edgeScrollRange) {
                if (self.contentOffset.y <= 0) {
                    return;
                }else {
                    if (self.contentOffset.y - 1 < 0) {
                        return;
                    }
                    [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 1) animated:NO];
                    self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y - 1);
                }
            }
            if (touchPoint.y > self.contentSize.height - _edgeScrollRange) {
                if (self.contentOffset.y >= self.contentSize.height - self.bounds.size.height) {
                    return;
                }else {
                    if (self.contentOffset.y + 1 > self.contentSize.height - self.bounds.size.height) {
                        return;
                    }
                    [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 1) animated:NO];
                    self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y + 1);
                }
            }
            //处理滚动
            CGFloat maxMoveDistance = 10;
            if (touchPoint.y < minOffsetY) {
                //cell在往上移动
                CGFloat moveDistance = (minOffsetY - touchPoint.y)/_edgeScrollRange*maxMoveDistance;
                [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - moveDistance) animated:NO];
                self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y - moveDistance);
            }else if (touchPoint.y > maxOffsetY) {
                //cell在往下移动
                CGFloat moveDistance = (touchPoint.y - maxOffsetY)/_edgeScrollRange*maxMoveDistance;
                [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + moveDistance) animated:NO];
                self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y + moveDistance);
            }
            
        } else if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            
            CGFloat minOffsetX = self.contentOffset.x + _edgeScrollRange;
            CGFloat maxOffsetX = self.contentOffset.x + self.bounds.size.width - _edgeScrollRange;
            CGPoint touchPoint = self.snapshot.center;
            //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是collectionView还未显示完，需要显示完collectionView才停止滚动
            if (touchPoint.x < _edgeScrollRange) {
                if (self.contentOffset.x <= 0) {
                    return;
                }else {
                    if (self.contentOffset.x - 1 < 0) {
                        return;
                    }
                    [self setContentOffset:CGPointMake(self.contentOffset.x-1, self.contentOffset.y) animated:NO];
                    self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y - 1);
                }
            }
            if (touchPoint.x > self.contentSize.width - _edgeScrollRange) {
                if (self.contentOffset.x >= self.contentSize.width - self.bounds.size.width) {
                    return;
                }else {
                    if (self.contentOffset.x + 1 > self.contentSize.width - self.bounds.size.width) {
                        return;
                    }
                    [self setContentOffset:CGPointMake(self.contentOffset.x+1, self.contentOffset.y) animated:NO];
                    self.snapshot.center = CGPointMake(touchPoint.x, self.snapshot.center.y + 1);
                }
            }
            //处理滚动
            CGFloat maxMoveDistance = 10;
            if (touchPoint.x < minOffsetX) {
                //cell在往左移动
                CGFloat moveDistance = (minOffsetX - touchPoint.x)/_edgeScrollRange*maxMoveDistance;
                [self setContentOffset:CGPointMake(self.contentOffset.x - moveDistance, self.contentOffset.y) animated:NO];
                self.snapshot.center = CGPointMake(touchPoint.x - moveDistance, self.snapshot.center.y);
            }else if (touchPoint.x > maxOffsetX) {
                //cell在往右移动
                CGFloat moveDistance = (touchPoint.x - maxOffsetX)/_edgeScrollRange*maxMoveDistance;
                [self setContentOffset:CGPointMake(self.contentOffset.x + moveDistance, self.contentOffset.y) animated:NO];
                self.snapshot.center = CGPointMake(touchPoint.x + moveDistance, self.snapshot.center.y);
            }
        }
    }
    
    
}

- (void)stopEdgeScroll {
    if (self.edgeScrollTimer) {
        [self.edgeScrollTimer invalidate];
        self.edgeScrollTimer = nil;
    }
}

#pragma mark - Snapshot Action
- (UIView *)customSnapshoFromView:(UICollectionViewCell *)inputView {
    
    UIView *view = inputView;
    if (self.showSnapshotView) {
        if ([inputView isKindOfClass:[JAMoveableCollectonViewBaseCell class]]) {
            JAMoveableCollectonViewBaseCell *cell = (JAMoveableCollectonViewBaseCell *)inputView;
            if (cell.snapshotV) {
                view = cell.snapshotV;
            }
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 1;
    snapshot.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.16].CGColor;
    if (self.snapShotViewAlpha > 0) {
        snapshot.alpha = self.snapShotViewAlpha;
    } else {
        snapshot.alpha = 0.8;
    }
    
    return snapshot;
}

@end
