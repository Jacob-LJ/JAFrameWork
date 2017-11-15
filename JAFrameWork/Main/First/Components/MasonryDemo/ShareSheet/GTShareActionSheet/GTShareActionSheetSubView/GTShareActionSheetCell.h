//
//  GTShareActionSheetCell.h
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GTShareItem;

static NSString * const GTShareActionSheetCellID = @"GTShareActionSheetCell";

@interface GTShareActionSheetCell : UITableViewCell

@property (nonatomic, copy) void(^clickItemBlock)(GTShareItem *item);

- (void)configWithItemArray:(NSArray *)itemArray;

@end
