//
//  GTDiscoveryFilterController.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "GTDiscoveryFilterController.h"

#import "GTPullDownSortCell.h"

extern NSString * const YZUpdateMenuTitleNote;

@interface GTDiscoveryFilterController ()

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, assign) NSInteger selectedCol;

@end

@implementation GTDiscoveryFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _selectedCol = 0;
    
    _titleArray = @[@"综合排序",@"人排序",@"评排序",@"评最多"];
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GTPullDownSortCell class] forCellReuseIdentifier:GTPullDownSortCellID];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCol inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTPullDownSortCell *cell = [tableView dequeueReusableCellWithIdentifier:GTPullDownSortCellID];
    [cell configWithTitle:_titleArray[indexPath.row]];
    if (indexPath.row == 0) {
        [cell setSelected:YES animated:NO];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedCol = indexPath.row;
    // 更新菜单标题
    [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":@"斯蒂芬斯蒂芬"}];
    
}

@end
