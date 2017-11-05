//
//  BRResponseMessage.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRResponseMessage : NSObject

//ps: 此处根据应用返回的字段命名

/**
 *  响应状态码，@link{GTErrorCode}
 */
@property (nonatomic, assign) NSInteger code;

/**
 *  错误提示信息
 */
@property (nonatomic, copy) NSString *msg;

/**
 *  返回的数据
 */
@property (nonatomic, strong) id data;

- (instancetype)initWithResponseDictionary:(NSDictionary *)dic;

@end
