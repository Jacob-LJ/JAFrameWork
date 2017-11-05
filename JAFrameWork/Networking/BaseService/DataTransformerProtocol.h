//
//  DataTransformerProtocol.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataTransformerProtocol <NSObject>

@optional

- (id)dataFromNSDictionary:(NSDictionary *)dic error:(NSError **)error;

- (id)dataFromNSArray:(NSArray *)array error:(NSError **)error;

@end
