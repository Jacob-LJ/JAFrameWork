//
//  UtilsMacros.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/16.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h


/**
 UIKit Reference
 */
#pragma mark - UIKit Reference
// 字符串判空
#define JAStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 字符串判空 如果为空返回 @“”
#define JAStringNullToEmpty(str)  (JAStringIsEmpty(str)? @"" : str)
// 字符串判空 如果为空返回 replaceStr
#define JAStringNullToReplaceStr(str,replaceStr)  (JAStringIsEmpty(str)? replaceStr : str)

// 数组是否为空
#define JAArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define JADictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)
// 是否是空对象
#define JAObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// Color
//rgba
#define JARGBA(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


/**
 iPhone Size
 */
#define isiPhone             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isiPhone5            (isiPhone && JAScreenH == 568.f)
#define isiPhone6            (isiPhone && JAScreenH == 667.f)
#define isiPhone6P           (isiPhone && JAScreenH == 736.f) // Both orientations
#define isiPhoneX            (isiPhone && JAScreenH == 812.f)




/**
 Weak objc
 */
#pragma mark - Weak objc

//weakSelf
#define JAWeakSelf  __weak typeof(self) weakSelf = self;



/**
 NSLog
 */
#pragma mark - NSLog

#if DEBUG

#define NSLog(format, ...) printf("[%s] %s [第%d行] \n\t\t\t%s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif



#endif /* UtilsMacros_h */
