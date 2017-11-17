//
//  ShareSheetController.m
//  JAFrameWork
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "ShareSheetController.h"
#import "GTShareActionSheet.h"

@interface ShareSheetController ()

@end

@implementation ShareSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    label.text = @"点击屏幕";
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GTShareActionSheet *shareSheet = [GTShareActionSheet showShareActionSheet];
    JAWeakSelf;
    shareSheet.clickShareItemBlock = ^(GTShareItem *item) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:item.name message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }]];
        [weakSelf presentViewController:alertVc animated:YES completion:nil];
    };
}

@end
