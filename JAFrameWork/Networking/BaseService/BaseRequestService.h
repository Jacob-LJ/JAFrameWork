//
//  BaseRequestService.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskProtocol.h"

typedef void(^CompletionBlock)(id data, id<TaskProtocol> operation, NSError *error);

@interface BaseRequestService : NSObject




@property (nonatomic, strong, readonly) NSURL *baseURL;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;


/**
 *  GET请求
 */
- (id<TaskProtocol>)baseRequestGET:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion;

/**
 *  POST请求
 */
- (id<TaskProtocol>)baseRequestPOST:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion;

/**
 *  PATCH请求
 */
- (id<TaskProtocol>)baseRequestPATCH:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion;

/**
 *  DELETE请求
 */
- (id<TaskProtocol>)baseRequestDELETE:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion;

@end
