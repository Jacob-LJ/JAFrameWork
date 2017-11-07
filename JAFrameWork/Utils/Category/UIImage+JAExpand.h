//
//  UIImage+JAExpand.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientDirectionType) {
    GradientDirectionTypeTopToBottom = 0,//从上到小
    GradientDirectionTypeLeftToRight = 1,//从左到右
    GradientDirectionTypeUpleftToLowright = 2,//左上到右下
    GradientDirectionTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (JAExpand)


/**
 生成一张渐变颜色的 Image

 @param colors 渐变颜色数组
 @param gradientDirectionType 渐变方向类型
 @param imgSize 生成图片的大小，因为是纯颜色，大小并不重要，因为可以设置 UIImageView 的拉伸模式来适配
 @return 按指定方向渐变颜色的 UIImage 对象
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientDirectionType)gradientDirectionType imgSize:(CGSize)imgSize;

@end
