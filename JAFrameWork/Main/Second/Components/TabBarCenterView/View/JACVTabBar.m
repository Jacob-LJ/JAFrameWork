//
//  JACVTabBar.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/12/17.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JACVTabBar.h"

@implementation JACVTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count;
    // 确定单个控件的大小
    CGFloat btnW = self.width / (count + 1);
    CGFloat btnH = 48; //原因是有一条黑线 View 高度 1；tabbar 默认是49高度，iPhone X 则为 83，此时的 item 高度不变，距离底部间隔时34;
    
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == count / 2) {
                index ++;
            }
            CGFloat btnX = index * btnW;
            subView.frame = CGRectMake(btnX, 0, btnW, btnH);
            
            index ++;
        }
    }
}

@end
