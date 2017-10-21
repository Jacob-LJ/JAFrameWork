//
//  NSObject+JAPlaceholderViewSwizzling.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;

@end
