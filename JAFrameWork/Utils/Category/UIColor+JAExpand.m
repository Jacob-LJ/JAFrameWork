//
//  UIColor+JAExpand.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "UIColor+JAExpand.h"

@implementation UIColor (JAExpand)

#pragma mark - 
+ (UIColor *)ja_randomColor {
    CGFloat hue = arc4random() % 256 / 256.0; //色调随机:0.0 ~ 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //饱和随机:0.5 ~ 1.0
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //亮度随机:0.5 ~ 1.0
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)ja_colorWithHexString:(NSString *)colorHexStr {
    return [self ja_colorWithHexString:colorHexStr alpha:1.0f];
}

+ (UIColor *)ja_colorWithHexString:(NSString *)colorHexStr alpha:(CGFloat)alpha {
    
    //删除字符串中的空格
    NSString *cString = [[colorHexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if (cString.length < 6) {
        NSLog(@"colorWithHexString is wrong！");
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    //如果处理完 字符串不为6，表面输入错误
    if (cString.length != 6) {
        NSLog(@"colorWithHexString is wrong！");
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    // NSScanner是一个类，用于在字符串中扫描指定的字符，尤其是把它们翻译/转换为数字和别的字符串。
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((CGFloat)r / 255.0f) green:((CGFloat)g / 255.0f) blue:((CGFloat)b / 255.0f) alpha:alpha];
}

#pragma mark - 项目常用颜色方法
+ (UIColor *)color3333 {
    return [UIColor colorWithHexString:@"333333"];
}

+ (UIColor *)color6666 {
    return [UIColor colorWithHexString:@"666666"];
}

+ (UIColor *)color9999 {
    return [UIColor colorWithHexString:@"999999"];
}

+ (UIColor *)colorCCCC {
    return [UIColor colorWithHexString:@"cccccc"];
}

+ (UIColor *)colorEEEE {
    return [UIColor colorWithHexString:@"eeeeee"];
}

+ (UIColor *)colorF6F6F6 {
    return [UIColor colorWithHexString:@"f6f6f6"];
}

+ (UIColor *)colorFF4A2A {
    return [UIColor colorWithHexString:@"ff4a2a"];
}

+ (UIColor *)colorFF0000 {
    return [UIColor colorWithHexString:@"ff0000"];
}

+ (UIColor *)colorFC694E {
    return [UIColor colorWithHexString:@"fc694e"];
}


+ (UIColor *)color53C411 {
    return [UIColor colorWithHexString:@"53c411"];
}

+ (UIColor *)colorFFD600 {
    return [UIColor colorWithHexString:@"ffd600"];
}

+ (UIColor *)colorFFF5DF {
    return [UIColor colorWithHexString:@"fff5df"];
}

@end
