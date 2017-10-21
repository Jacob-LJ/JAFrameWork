//
//  JALongPressMoveableTableView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JALongPressMoveableTableView.h"

@interface JALongPressMoveableTableView ()

@property (nonatomic, weak) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) CADisplayLink *edgeScrollTimer;
@property (nonatomic, strong) UIView *snapshot;
@property (nonatomic, strong) NSIndexPath  *sourceIndexPath;
@property (nonatomic, strong) NSMutableArray *tempDataSource;

@property (nonatomic, strong) NSIndexPath *starPositionIndexPath;
@property (nonatomic, strong) NSIndexPath *endPositionIndexPath;

@end

@implementation JALongPressMoveableTableView

//@synthesize delegate;
//@synthesize dataSource;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
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

#pragma mark Add Gesture

- (void)addGesture {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self addGestureRecognizer:longPress];
    self.longPress = longPress;
}

#pragma mark - LongPress Action
- (void)longPressGestureRecognized:(id)sender {
    if (!_canExchangeData) return;
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:location];
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                
                if (_canEdgeScroll) {
                    //开启边缘滚动
                    [self startEdgeScroll];
                }
                
                //每次移动开始获取一次数据源
                if (self.moveableDataSource && [self.moveableDataSource respondsToSelector:@selector(dataSourceArrayInMoveCellTableView:)]) {
                    self.tempDataSource = [self.moveableDataSource dataSourceArrayInMoveCellTableView:self].mutableCopy;
                }
                
                self.sourceIndexPath = indexPath;
                self.starPositionIndexPath = indexPath;
                
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                
                self.snapshot = [self customSnapshoFromView:cell];
                
                __block CGPoint center = cell.center;
                self.snapshot.center = center;
                
                [self addSubview:self.snapshot];
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    center.y = location.y;
                    self.snapshot.center = center;
                    self.snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            if (!_canEdgeScroll) {
                if (indexPath && ![indexPath isEqual:self.sourceIndexPath]) {
                    //交换数据源和cell
                    [self updateDataSourceAndCellFromIndexPath:self.sourceIndexPath toIndexPath:indexPath];
                    self.sourceIndexPath = indexPath;
                }
                
                self.snapshot.center = CGPointMake(self.snapshot.center.x, location.y);
            }
            
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (_canEdgeScroll) {
                [self stopEdgeScroll];
            }
            
            //返回交换后的数据源
            if (self.moveableDataSource && [self.moveableDataSource respondsToSelector:@selector(tableView:freshDataSourceArrayAfterMove:)]) {
                [self.moveableDataSource tableView:self freshDataSourceArrayAfterMove:self.tempDataSource.copy];
            }
            
            //通知代理完成交换后,交换的前后indexpath
            self.endPositionIndexPath = self.sourceIndexPath;
            if (!(self.starPositionIndexPath.section == self.endPositionIndexPath.section && self.starPositionIndexPath.row == self.endPositionIndexPath.row)) {
                if ([self.moveableDelegate respondsToSelector:@selector(tableView:FromIndexPath:toIndexPath:)]) {
                    [self.moveableDelegate tableView:self FromIndexPath:self.starPositionIndexPath toIndexPath:self.endPositionIndexPath];
                }
            }
            
            // Clean up.
            UITableViewCell *cell = [self cellForRowAtIndexPath:self.sourceIndexPath];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.snapshot.center = cell.center;
                self.snapshot.transform = CGAffineTransformIdentity;
                
                
            } completion:^(BOOL finished) {
                
                cell.hidden = NO;
                self.sourceIndexPath = nil;
                [self.snapshot removeFromSuperview];
                self.snapshot = nil;
                
            }];
            
            break;
        }
            
        default: {
            break;
        }
    }
}

- (void)gestureRecognizedChange:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint location = [longPress locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:location];
    
    if (indexPath && ![indexPath isEqual:self.sourceIndexPath]) {
        //交换数据源和cell
        [self updateDataSourceAndCellFromIndexPath:self.sourceIndexPath toIndexPath:indexPath];
        self.sourceIndexPath = indexPath;
    }
    
    self.snapshot.center = CGPointMake(self.snapshot.center.x, location.y);
    
}

#pragma mark - UpdateDataSource Action
- (void)updateDataSourceAndCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if ([self numberOfSections] == 1) {
        //只有一组
        //        [self.tempDataSource exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        id dragModel = self.tempDataSource[fromIndexPath.item];
        [self.tempDataSource removeObject:dragModel];
        [self.tempDataSource insertObject:dragModel atIndex:toIndexPath.item];
        //交换cell
        [self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    }else {
        //有多组
        id fromData = self.tempDataSource[fromIndexPath.section][fromIndexPath.row];
        id toData = self.tempDataSource[toIndexPath.section][toIndexPath.row];
        NSMutableArray *fromArray = [self.tempDataSource[fromIndexPath.section] mutableCopy];
        NSMutableArray *toArray = [self.tempDataSource[toIndexPath.section] mutableCopy];
        [fromArray replaceObjectAtIndex:fromIndexPath.row withObject:toData];
        [toArray replaceObjectAtIndex:toIndexPath.row withObject:fromData];
        [self.tempDataSource replaceObjectAtIndex:fromIndexPath.section withObject:fromArray];
        [self.tempDataSource replaceObjectAtIndex:toIndexPath.section withObject:toArray];
        //交换cell
        [self beginUpdates];
        [self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [self moveRowAtIndexPath:toIndexPath toIndexPath:fromIndexPath];
        [self endUpdates];
    }
}

#pragma mark - Snapshot Action
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    UIView *view = inputView;
    //自定义截图 view
//    if ([inputView isKindOfClass:[WTAllTaskCell class]]) {
//        WTAllTaskCell *Cell = (WTAllTaskCell *)inputView;
//        view = Cell.rounderView ;
//    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    snapshot.alpha = 0.8;
    
    return snapshot;
}

#pragma mark - EdgeScroll
- (void)startEdgeScroll {
    self.edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(processEdgeScroll)];
    [self.edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)processEdgeScroll {
    [self gestureRecognizedChange:self.longPress];
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
            self.snapshot.center = CGPointMake(self.snapshot.center.x, self.snapshot.center.y - 1);
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
            self.snapshot.center = CGPointMake(self.snapshot.center.x, self.snapshot.center.y + 1);
        }
    }
    //处理滚动
    CGFloat maxMoveDistance = 10;
    if (touchPoint.y < minOffsetY) {
        //cell在往上移动
        CGFloat moveDistance = (minOffsetY - touchPoint.y)/_edgeScrollRange*maxMoveDistance;
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - moveDistance) animated:NO];
        self.snapshot.center = CGPointMake(self.snapshot.center.x, self.snapshot.center.y - moveDistance);
    }else if (touchPoint.y > maxOffsetY) {
        //cell在往下移动
        CGFloat moveDistance = (touchPoint.y - maxOffsetY)/_edgeScrollRange*maxMoveDistance;
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + moveDistance) animated:NO];
        self.snapshot.center = CGPointMake(self.snapshot.center.x, self.snapshot.center.y + moveDistance);
    }
}

- (void)stopEdgeScroll {
    if (self.edgeScrollTimer) {
        [self.edgeScrollTimer invalidate];
        self.edgeScrollTimer = nil;
    }
}

@end
