//
//  UITableView+testLoad.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/3.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "UITableView+testLoad.h"
#import "NSObject+JAPlaceholderViewSwizzling.h"

@implementation UITableView (testLoad)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
//                               bySwizzledSelector:@selector(TEST_reloadData)];
//    });
//}
//
//- (void)TEST_reloadData {
//    NSLog(@"调用 - TEST_reloadData");
//    [self TEST_reloadData];
//}

@end
