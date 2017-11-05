//
//  BRResponseMessage.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "BRResponseMessage.h"

@implementation BRResponseMessage

- (instancetype)initWithResponseDictionary:(NSDictionary *)dic {
    
    if (!dic || ![dic isKindOfClass:NSDictionary.class]) {
        return nil;
    }
    
    if (self = [super init]) {
        @try {
            _code = [dic[@"code"] integerValue];
            _msg = dic[@"msg"];
            _data = dic[@"data"];
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
            return nil;
        }
    }
    return self;
}

@end
