//
//  JADefaultPlaceholderView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/2.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JADefaultPlaceholderView.h"

@interface JADefaultPlaceholderView ()

@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation JADefaultPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame placeholderViewType:(JAPlaceholderViewType)type reloadBlock:(void (^)(void))reloadBlock {
    if (self = [super initWithFrame:frame placeholderViewType:type reloadBlock:reloadBlock]) {
        [self setUpPlaceholderView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _reloadButton.center = self.center;
}

- (void)setUpPlaceholderView {
    
    self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self addSubview:self.reloadButton];
}

#pragma mark -
- (void)reloadClick {
    if (self.reloadClickBlock) {
        NSLog(@"点击了 - %@", [self.reloadButton titleForState:UIControlStateNormal]);
        self.reloadClickBlock();
    }
}

#pragma mark - getter & setter
- (UIButton *)reloadButton {
    
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.backgroundColor = [UIColor redColor];
        _reloadButton.frame = CGRectMake(0, 0, 150, 150);
        _reloadButton.layer.cornerRadius = 75.0;
        
        NSString *path = nil;
        NSString *titleStr = @"";
        switch (self.type) {
            case JAPlaceholderViewTypeNetConnectError: {
                path = [[NSBundle mainBundle] pathForResource:@"JADefaultPlaceholderView_NetConnectError" ofType:@"png"];
                titleStr = @"网络连接失败，点击重新连接!";
                break;
            }
            case JAPlaceholderViewTypeNoData: {
                path = [[NSBundle mainBundle] pathForResource:@"JADefaultPlaceholderView_NoneData" ofType:@"png"];
                titleStr = @"暂无数据，点击重新加载!";
                break;
            }
        }
        
        UIImage *placeholderImage = [UIImage imageWithContentsOfFile:path];
        [_reloadButton setBackgroundImage:placeholderImage forState:UIControlStateNormal];
        [_reloadButton setTitle:titleStr forState:UIControlStateNormal];
        
        [_reloadButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        
        [_reloadButton addTarget:self action:@selector(reloadClick) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect rect = _reloadButton.frame;
        rect.origin.y -= 50;
        _reloadButton.frame = rect;
    }
    return _reloadButton;
}

@end

