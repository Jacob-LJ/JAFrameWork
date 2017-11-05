//
//  NSString+JAExpand.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "NSString+JAExpand.h"
//加密
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (JAExpand)

/**
 判断传入的字符串是否为空
 */
+ (BOOL)ja_isEmptyStrin:(NSString *)str {
    return ([str isKindOfClass:[NSNull class]] || str == nil ||  str.length < 1) ? YES : NO;
}

#pragma mark - 加密
- (NSString *)ja_MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
