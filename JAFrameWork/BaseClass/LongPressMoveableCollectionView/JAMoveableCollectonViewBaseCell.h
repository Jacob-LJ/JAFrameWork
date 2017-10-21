//
//  JAMoveableCollectonViewBaseCell.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAMoveableCollectonViewBaseCell : UICollectionViewCell

@property (nonatomic, strong) UIView *snapshotV;

@property (nonatomic, copy) void(^beginDraggBlock)(void);
@property (nonatomic, copy) void(^endDragBlock)(void);

@end
