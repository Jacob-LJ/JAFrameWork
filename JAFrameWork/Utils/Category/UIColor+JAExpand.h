//
//  UIColor+JAExpand.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JAExpand)

#pragma mark -
+ (UIColor *)ja_randomColor;

+ (UIColor *)ja_colorWithHexString:(NSString *)colorHexStr;

+ (UIColor *)ja_colorWithHexString:(NSString *)colorHexStr alpha:(CGFloat)alpha;

#pragma mark - 项目常用颜色方法
+ (UIColor *)color3333;
+ (UIColor *)color6666;
+ (UIColor *)color9999;

+ (UIColor *)colorCCCC;
+ (UIColor *)colorEEEE;
+ (UIColor *)colorF6F6F6;

+ (UIColor *)colorFF4A2A;
+ (UIColor *)colorFF0000;
+ (UIColor *)colorFC694E;

+ (UIColor *)color53C411;
+ (UIColor *)colorFFD600;
+ (UIColor *)colorFFF5DF;

@end
