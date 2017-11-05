//
//  TaskProtocol.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataTransformerProtocol.h"

@protocol TaskProtocol <NSObject>

@property (readonly, getter = isCancelled) BOOL cancelled;
@property (readonly, getter = isExecuting) BOOL executing;
@property (readonly, getter = isFinished) BOOL finished;
@property (readonly, getter = isReady) BOOL ready;
//@property (nonatomic, copy, readonly) NSString *url;

@property (nonatomic, strong) id<DataTransformerProtocol> dataTransformer;

//- (BOOL) isCachedResponse;
- (void) cancel;

@end
