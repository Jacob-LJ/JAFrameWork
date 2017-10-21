//
//  JABasePlaceholderView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABasePlaceholderView.h"

@interface JABasePlaceholderView ()

@end

@implementation JABasePlaceholderView

- (instancetype)initWithFrame:(CGRect)frame placeholderViewType:(JAPlaceholderViewType)type reloadBlock:(void(^)(void))reloadBlock {
    if (self = [super initWithFrame:frame]) {
        _reloadClickBlock = reloadBlock;
        _type = type;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame placeholderViewType:JAPlaceholderViewTypeNetConnectError reloadBlock:NULL];
}

@end

