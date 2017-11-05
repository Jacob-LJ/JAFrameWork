//
//  NSString+JAExpand.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JAExpand)

/**
 判断传入的字符串是否为空
 */
+ (BOOL)ja_isEmptyStrin:(NSString *)str; //此处不写成实例时应为，当 self 就是 nil 时候不会调用任何方法

#pragma mark - 加密
- (NSString *)ja_MD5;

@end
