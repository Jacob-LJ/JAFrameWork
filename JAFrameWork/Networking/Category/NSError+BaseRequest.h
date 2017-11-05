//
//  NSError+BaseRequest.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  自定义的错误码
 */
typedef NS_ENUM(NSInteger, BRErrorCode) {
    /**
     *  操作脏数据，需要刷新数据后再操作
     */
    BRErrorCode_DataInvalid      = -1,
    
    /**
     *  Json数据解析错误
     */
    BRErrorCode_JsonResolveError = -900,
    
    /**
     *  通用错误，APP可直接显示该状态下地错误提示
     */
    BRErrorCode_Error            = -1000
};

@interface NSError (BaseRequest)


/**
 *  JSON数据解析出错
 */
+ (NSError *)br_jsonResolveError;

/**
 *  一般错误
 */
+ (NSError *)br_errorWithMessage:(NSString *)message;

+ (NSError *)br_errorWithCode:(NSInteger)code Message:(NSString *)message;

@end
