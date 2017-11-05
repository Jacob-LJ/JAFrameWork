//
//  BaseRequestService.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "BaseRequestService.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "BRResponseMessage.h"

//categroy
#import "NSError+BaseRequest.h"

static const NSTimeInterval kTimeoutInterval = 15.0;

@interface BaseRequestService ()

@property (nonatomic, strong) NSURL *baseURL;

@property (nonatomic, strong) NSMutableArray *urlFilters;
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

@end

@implementation BaseRequestService

- (instancetype)initWithBaseURL:(NSURL *)baseURL{
    if (self = [super init]) {
        _baseURL = baseURL;
        //AFNetworkActivityIndicatorManager 所有通过AF发送的请求, 都会在电池条上出现圆圈提示
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _requestManager = [AFHTTPSessionManager manager];
        
        _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        _requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //允许无效证书
        [_requestManager.securityPolicy setAllowInvalidCertificates:YES];
        
        _requestManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        //配置响应序列化
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[
                                                                                          @"application/json",
                                                                                          @"text/html",
                                                                                          @"text/json",
                                                                                          @"text/plain",
                                                                                          @"text/javascript",
                                                                                          @"text/xml",
                                                                                          @"image/*",
                                                                                          @"application/octet-stream",
                                                                                          @"application/zip"
                                                                                          ]];
        //请求时间
        _requestManager.requestSerializer.timeoutInterval = kTimeoutInterval;
        
    }
    return self;
}

/**
 *  GET请求
 */
- (id<TaskProtocol>)baseRequestGET:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion {
    
    AFHTTPSessionManager *requestManager = self.requestManager;
    
    NSURLSessionDataTask *operation = [requestManager GET:path
                                               parameters:parameters
                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
                                                     
                                                 }
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      
                                                      [self handleSuccRequest:task responseObj:responseObject completion:completion];
                                                      
                                                  }
                                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                      [self handleFailureRequest:task error:error completion:completion];
                                                      
                                                  }];
    
    NSLog(@"🌍GET:%@", operation.currentRequest.URL);
    
    return (id<TaskProtocol>)operation;
    
}

/**
 *  POST请求
 */
- (id<TaskProtocol>)baseRequestPOST:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion {
    
    AFHTTPSessionManager *requestManager = self.requestManager;
    
    NSURLSessionDataTask *operation = [requestManager POST:path
                                                parameters:parameters
                                                  progress:NULL
                                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                       [self handleSuccRequest:task responseObj:responseObject completion:completion];
                                                   }
                                                   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                       [self handleFailureRequest:task error:error completion:completion];
                                                   }];
    
    NSLog(@"🌍POST:%@ \n%@", operation.currentRequest.URL, parameters);
    
    return (id<TaskProtocol>)operation;
}

/**
 *  PATCH请求
 */
- (id<TaskProtocol>)baseRequestPATCH:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion {
    
    AFHTTPSessionManager *requestManager = self.requestManager;
    
    NSURLSessionDataTask *operation = [requestManager PATCH:path
                                                 parameters:parameters
                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        [self handleSuccRequest:task responseObj:responseObject completion:completion];
                                                    }
                                                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                        [self handleFailureRequest:task error:error completion:completion];
                                                    }];
    
    NSLog(@"🌍PATCH:%@ \n%@", operation.currentRequest.URL, parameters);
    
    return (id<TaskProtocol>)operation;
    
}


/**
 *  DELETE请求
 */
- (id<TaskProtocol>)baseRequestDELETE:(NSString *)path parameters:(NSDictionary *)parameters completion:(CompletionBlock)completion {
    
    AFHTTPSessionManager *requestManager = self.requestManager;
    
    NSURLSessionDataTask *operation = [requestManager DELETE:path
                                                  parameters:parameters
                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                         [self handleSuccRequest:task responseObj:responseObject completion:completion];
                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                         [self handleFailureRequest:task error:error completion:completion];
                                                     }];
    
    NSLog(@"🌍POST:%@ \n%@", operation.currentRequest.URL, parameters);
    
    return (id<TaskProtocol>)operation;
}


#pragma mark - private
/**
 处理请求成功
 */
- (void)handleSuccRequest:(NSURLSessionDataTask *)operation responseObj:(id)responseObject completion:(CompletionBlock)completion {
    
    NSLog(@"🌍response：%@", responseObject);
    
    BRResponseMessage *respMsg = [[BRResponseMessage alloc] initWithResponseDictionary:responseObject];
    
    if (respMsg) {
        
        if (respMsg.code == 0) {
            //请求成功
            NSError *error = nil;
            //数据处理
            id transformedResult = [self transformData:respMsg.data forRequest:(id<TaskProtocol>)operation error:&error];
            
            completion(transformedResult, (id<TaskProtocol>)operation, error);
            
        } else {
            //请求失败
            completion(nil, (id<TaskProtocol>)operation, [NSError br_errorWithCode:respMsg.code Message:respMsg.msg]);
        }
        
    } else {
        //返回的 responseObject 不是 JSON 格式
        completion(nil, (id<TaskProtocol>)operation, [NSError br_jsonResolveError]);
    }
    
}
/**
 处理请求失败
 */
- (void)handleFailureRequest:(NSURLSessionDataTask *)operation error:(NSError *)error completion:(CompletionBlock)completion {
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
    NSInteger statusCode = response.statusCode;
    NSString *responseString = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
    NSLog(@"🌍response：%@", responseString);
    
    if (operation.state == NSURLSessionTaskStateCanceling || !completion) {
        return;
    }
    
    NSLog(@"❌%@  error:\n%@ \n errorUserInfo:\n%@", operation.currentRequest.URL, error,error.userInfo);
    
    //请求失败，网络错误
    NSString *msg = error.localizedDescription;
    
    if (operation.response) {
        //自定义 error msg
        if (statusCode >= 500 && statusCode <= 599) {
            msg = @"服务异常，请联系客服";
            
        } else if(statusCode == 404) {
            msg = @"请求资源不存在";
            
        } else {
            msg = responseString;
        }
    }
    
    completion(nil, (id<TaskProtocol>)operation, [NSError br_errorWithCode:statusCode Message:msg]);
    
}

#pragma mark - 数据转换处理
- (id)transformData:(id)data forRequest:(id<TaskProtocol>)request error:(NSError **)error{
    
    id transformedResult = data;
    //    id<HLMDataTransformer> dataTransformer = request.dataTransformer;
    //
    //    if (!result || !dataTransformer) {
    //        return result;
    //    }
    //
    //    if ([result isKindOfClass:NSArray.class]) {
    //
    //        if ([dataTransformer respondsToSelector:@selector(dataFromNSArray:error:)]) {
    //            transformedResult = [dataTransformer dataFromNSArray:result error:error];
    //        }
    //
    //    }else if ([result isKindOfClass:NSDictionary.class]){
    //
    //        if ([dataTransformer respondsToSelector:@selector(dataFromNSDictionary:error:)]) {
    //            transformedResult = [dataTransformer dataFromNSDictionary:result error:error];
    //        }
    //
    //    }
    
    return transformedResult;
}


@end

