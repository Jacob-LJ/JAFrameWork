//
//  GTShareItemCCell.h
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTShareItem;

static NSString * const GTShareItemCCellID = @"GTShareItemCCell";

@interface GTShareItemCCell : UICollectionViewCell

- (void)configWithModel:(GTShareItem *)shareItem;

@end
