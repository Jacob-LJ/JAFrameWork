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
 Color
 */
#pragma mark - Color
//rgba
#define JARGBA(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


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
