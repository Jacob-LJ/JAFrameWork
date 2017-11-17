//
//  GTShareActionSheet.h
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTShareItem.h"

@interface GTShareActionSheet : UIView

@property (nonatomic, copy) void(^clickShareItemBlock)(GTShareItem *item);

+ (instancetype)showShareActionSheet;

@end
