//
//  NSError+BaseRequest.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "NSError+BaseRequest.h"

static NSString *const kBRErrorDomain = @"应用BundelID.com";

@implementation NSError (BaseRequest)

/**
 *  JSON数据解析出错
 */
+ (NSError *)br_jsonResolveError{
    return [NSError errorWithDomain:kBRErrorDomain
                               code:BRErrorCode_JsonResolveError
                           userInfo:@{
                                      NSLocalizedDescriptionKey : NSLocalizedString(@"JsonResolveError", @"数据解析出错")
                                      }
            ];
}


/**
 *  一般错误
 */
+ (NSError *)br_errorWithMessage:(NSString *)message{
    return [NSError br_errorWithCode:BRErrorCode_Error Message:message];
}


+ (NSError *)br_errorWithCode:(NSInteger)code Message:(NSString *)message{
    return [NSError errorWithDomain:kBRErrorDomain
                               code:code
                           userInfo:@{
                                      NSLocalizedDescriptionKey : message
                                      }];
}

@end
