//
//  APImageCCell.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, APImageCCellType) {
    APImageCCellType_add,
    APImageCCellType_image,
};

@interface APImageCCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) APImageCCellType type;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void(^deleteImageBlock)(NSInteger index);

@end
