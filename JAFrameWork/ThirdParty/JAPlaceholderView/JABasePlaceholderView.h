//
//  JABasePlaceholderView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 占位图类型

 - JAPlaceholderViewTypeNetConnectError: 网络连接错误
 - JAPlaceholderViewTypeNoData: 没有数据返回
 */
typedef NS_ENUM(NSUInteger, JAPlaceholderViewType) {
    JAPlaceholderViewTypeNetConnectError,
    JAPlaceholderViewTypeNoData,
};

@interface JABasePlaceholderView : UIView

@property (nonatomic, assign, readonly) JAPlaceholderViewType type;
@property (nonatomic, copy, readonly) void(^reloadClickBlock)(void);

/**
 按指定类型，初始化占位View
 
 @param type 占位图类型
 @param reloadBlock 存放点击 PlaceholderView 时的 Action，如果没有点击 Action 的话，可以忽略此属性
 */
- (instancetype)initWithFrame:(CGRect)frame placeholderViewType:(JAPlaceholderViewType)type reloadBlock:(void(^)(void))reloadBlock NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
