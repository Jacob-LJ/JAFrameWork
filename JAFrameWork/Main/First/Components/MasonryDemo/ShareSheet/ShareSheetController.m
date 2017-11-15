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
    
    GTShareActionSheet *shareSheet = [[GTShareActionSheet alloc] initWithFrame:CGRectMake(0, 0, JAScreenW, JAScreenH)];
    shareSheet.clickShareItemBlock = ^(GTShareItem *item) {
        NSLog(@"%@",item);
    };
    [shareSheet showShareActionSheet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
