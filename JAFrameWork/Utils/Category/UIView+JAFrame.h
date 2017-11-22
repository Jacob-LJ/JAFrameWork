//
//  UIView+JAFrame.h
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JAOscillatoryAnimationToBigger,
    JAOscillatoryAnimationToSmaller,
} JAOscillatoryAnimationType;

@interface UIView (JAFrame)

@property CGPoint ja_origin;
@property CGSize ja_size;

@property (nonatomic, assign) CGFloat ja_x;
@property (nonatomic, assign) CGFloat ja_y;
@property (nonatomic, assign) CGFloat ja_width;
@property (nonatomic, assign) CGFloat ja_height;

#pragma mark - top left bottom right
@property  (nonatomic, assign) CGFloat ja_top;
@property  (nonatomic, assign) CGFloat ja_left;
@property  (nonatomic, assign) CGFloat ja_bottom;
@property  (nonatomic, assign) CGFloat ja_right;

@property (nonatomic, assign) CGFloat ja_centerX;
@property (nonatomic, assign) CGFloat ja_centerY;

//更改锚点
@property (nonatomic, assign) CGPoint ja_anchorPoint;
- (void)resetOriginAnchorPoint;

//获得旋转的角度  0 ~ 360
@property (nonatomic, assign) CGFloat ja_rotateAngle;

- (UITabBarController *)ja_tabbarController;

/**
 快速返回xib创建的View对象
 */
+ (instancetype)ja_viewFromXib;

/**
 当前View所在的Controller实例对象
 */
- (UIViewController *)ja_viewController;

/**
 递归获取view子控件中的Scrollview,并将其scrollsToTop属性设为NO
 */
- (void)ja_detectScrollsToTopViews;


/**
 放大缩小的震动效果
 
 @param layer view的layer
 @param type  放大 / 缩小 类型
 */
+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(JAOscillatoryAnimationType)type;

/**
 旋转效果
 
 @param angle 角度
 */
- (void)ja_rotateAnimationWithAngle:(CGFloat)angle;
- (void)ja_rotateAnimationIdentity;

#pragma mark - Constraint
/**
 获取高度约束
 */
- (NSLayoutConstraint *)ja_heightConstraint;

/**
 获取宽度约束
 */
- (NSLayoutConstraint *)ja_widthConstraint;

#pragma mark - Corner 圆角处理

- (void)ja_roundCorners:(UIRectCorner)corner radius:(CGFloat)radius;

- (void)ja_roundTopCornersRadius:(CGFloat)radius;
- (void)ja_roundBottomCornersRadius:(CGFloat)radius;
- (void)ja_roundLeftCornerRadius:(CGFloat)radius;
- (void)ja_roundRightCornerRadius:(CGFloat)radius;

#pragma mark - 添加 带颜色的layer边
- (void)ja_topBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)ja_leftBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)ja_bottomBorderWidth:(CGFloat)width color:(UIColor *)color;
- (void)ja_rightBorderWidth:(CGFloat)width color:(UIColor *)color;

#pragma mark -

/**
 按照给定定delta(point)改变View的origin值
 */
- (void)ja_moveBy:(CGPoint)delta;

/**
 按照给定的scaleFactor比例因子, 改变View的height 和 width
 */
- (void)ja_scaleBy:(CGFloat)scaleFactor;

#pragma mark - 截屏
+ (UIImage *)ja_snapshotWindow;
/**
 * 截取inputView
 */
+ (UIImage *)ja_snapshoFromView:(UIView *)inputView WithScale:(CGFloat)scale;


/**
 * 获取tableView的截图
 * clipEdeInsets : default is UIEdgeInsetsZero;
 */
+ (UIImage *)ja_getTableViewImage:(UITableView *)tableView withClipEdeInsets:(UIEdgeInsets)clipEdeInsets;


@end
