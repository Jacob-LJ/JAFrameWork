//
//  Cell_CollectionV_Controller.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "Cell_CollectionV_Controller.h"
#import "jaCell_CollectionV_Mas.h"

@interface Cell_CollectionV_Controller ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation Cell_CollectionV_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 150;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[jaCell_CollectionV_Mas class] forCellReuseIdentifier:jaCell_CollectionV_MasID];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view); //所有边的布局
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    jaCell_CollectionV_Mas *cell = [tableView dequeueReusableCellWithIdentifier:jaCell_CollectionV_MasID forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
