//
//  HIstoryAlignmentLayout.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FlowAlignment) {
    FlowAlignmentJustyfied,
    FlowAlignmentLeft,
    FlowAlignmentCenter,
    FlowAlignmentRight
};

@interface HIstoryAlignmentLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) FlowAlignment alignment;

@end
