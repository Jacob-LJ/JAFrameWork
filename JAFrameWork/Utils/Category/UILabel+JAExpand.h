//
//  UILabel+JAExpand.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JAExpand)

/**
 给label添加水平横线, 横线高度1 如带横线的原价格
 
 @param color 可以为nil，默认为kColor_999999颜色
 @param extraW 超出label宽度值，默认3
 */
- (void)addHorizontalLineWithColor:(UIColor *)color extraLBWidth:(CGFloat)extraW;

@end
