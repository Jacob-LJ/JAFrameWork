//
//  JAButton.h
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    JAButtonTypeHorizontalCenterImageLabel,
    JAButtonTypeHorizontalCenterLabelImage,
    JAButtonTypeHorizontalLeftImageLabel,
    JAButtonTypeHorizontalLeftLabelImage,
    JAButtonTypeHorizontalRightImageLabel,
    JAButtonTypeHorizontalRightLabelImage,
    
    JAButtonTypeVerticalCenterImageLabel,
    JAButtonTypeVerticalCenterLabelImage,
    JAButtonTypeVerticalTopImageLabel,
    JAButtonTypeVerticalTopLabelImage,
    JAButtonTypeVerticalBottomImageLabel,
    JAButtonTypeVerticalBottomLabelImage,
    //ja
    JAButtonTypeVerticalLeftCenterImageLabel,
    
} JAButtonType;

typedef NS_ENUM(NSUInteger, JAButtonUnreadDotImageAlignment) {
    JAButtonUnreadDotImageAlignmentRightTop,
    JAButtonUnreadDotImageAlignmentLeftTop,
    JAButtonUnreadDotImageAlignmentRightBottom,
    JAButtonUnreadDotImageAlignmentLeftBottom,
};

@interface JAButton : UIButton

@property (nonatomic, assign) JAButtonType ja_type;
@property (nonatomic, assign) IBInspectable CGFloat ja_imageLabelSpacing;
@property (nonatomic, assign) IBInspectable CGFloat ja_minCenterMargin;

@property (nonatomic, assign) CGFloat ja_horizontalCenterX;

@property (nonatomic, strong) UIImage *ja_normalImage;
@property (nonatomic, strong) UIImage *ja_selectedImage;

@property (nonatomic, strong) NSAttributedString *ja_normalAttributeString;
@property (nonatomic, copy) NSString *ja_normalTitle;
@property (nonatomic, copy) NSString *ja_selectedTitle;

@property (nonatomic, strong) UIColor *ja_normalTitleColor;
@property (nonatomic, strong) UIColor *ja_selectedTitleColor;

//ja
//未读标签图
@property (nonatomic, assign) BOOL showUnreadDotImage; ///< default is hidden
@property (nonatomic, assign) JAButtonUnreadDotImageAlignment unreadDotAlignment;
@property (nonatomic, strong) UIImage *unreadDotImage;
@property (nonatomic, assign) UIEdgeInsets dotImageInsets;



+ (instancetype)JAButtonWithType:(JAButtonType)type spacing:(CGFloat)spacing;


@end
