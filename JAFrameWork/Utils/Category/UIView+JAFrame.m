//
//  UIView+JAFrame.m
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "UIView+JAFrame.h"

@implementation UIView (JAFrame)

// Retrieve and set the origin
- (CGPoint)ja_origin {
    return self.frame.origin;
}

- (void)setJa_origin:(CGPoint) aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (void)setJa_anchorPoint:(CGPoint)ja_anchorPoint {
    
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = ja_anchorPoint;
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake (self.ja_centerX - transition.x, self.ja_centerY - transition.y);
}

- (CGPoint)ja_anchorPoint {
    return self.layer.anchorPoint;
}

// Retrieve and set the size
- (CGSize)ja_size {
    return self.frame.size;
}

- (void) setJa_size:(CGSize) aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (void)setJa_x:(CGFloat)ja_x {
    CGRect frame = self.frame;
    frame.origin.x = ja_x;
    self.frame = frame;
}

- (void)setJa_y:(CGFloat)ja_y {
    CGRect frame = self.frame;
    frame.origin.y = ja_y;
    self.frame = frame;
}

- (void)setJa_width:(CGFloat)ja_width {
    CGRect frame = self.frame;
    frame.size.width = ja_width;
    self.frame = frame;
}

- (void)setJa_height:(CGFloat)ja_height {
    CGRect frame = self.frame;
    frame.size.height = ja_height;
    self.frame = frame;
}

- (CGFloat)ja_x {
    return self.frame.origin.x;
}

- (CGFloat)ja_y {
    return self.frame.origin.y;
}

- (CGFloat)ja_width {
    return self.frame.size.width;
}

- (CGFloat)ja_height {
    return self.frame.size.height;
}

- (CGFloat)ja_rotateAngle {
    CGFloat radius = atan2f(self.transform.b, self.transform.a);
    CGFloat degree = radius * (180 / M_PI);
    if (degree < 0) {
        degree = degree + 360;
    }
    return degree;
}

#pragma mark - top left bottom right
- (CGFloat)ja_top {
    return self.frame.origin.y;
}

- (void)setJa_top:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)ja_left {
    return self.frame.origin.x;
}

- (void)setJa_left:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)ja_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setJa_bottom:(CGFloat)newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)ja_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setJa_right:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

#pragma mark -

- (CGFloat)ja_centerX {
    return self.center.x;
}

- (CGFloat)ja_centerY {
    return self.center.y;
}

- (void)setJa_centerX:(CGFloat)ja_centerX {
    CGPoint center = self.center;
    center.x = ja_centerX;
    self.center = center;
}

- (void)setJa_centerY:(CGFloat)ja_centerY {
    CGPoint center = self.center;
    center.y = ja_centerY;
    self.center = center;
}

+ (instancetype)ja_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (UITabBarController *)ja_tabbarController {
    
    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    return tabbarVC;
}

- (UIViewController *)ja_viewController {
    UIResponder *nextRes = [self nextResponder];
    
    do {
        if ([nextRes isKindOfClass:[UIViewController class]]) {
            return  (UIViewController *)nextRes;
            
        }
        nextRes = [nextRes nextResponder];
    } while (nextRes != nil);
    return nil;
}

- (void)ja_detectScrollsToTopViews {
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:UIScrollView.class]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            scrollView.scrollsToTop = NO;
        }
        
        [view ja_detectScrollsToTopViews];
    }
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(JAOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == JAOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == JAOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

- (void)ja_rotateAnimationWithAngle:(CGFloat)angle {
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformRotate(self.transform, angle);
    } completion:nil];
}

- (void)ja_rotateAnimationIdentity {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

#pragma mark - Constraint
- (NSLayoutConstraint *)ja_heightConstraint{
    NSArray *allConstrint = self.constraints;
    for (NSLayoutConstraint *constraint in allConstrint) {
        if (constraint.firstItem == self && constraint.secondItem == nil && constraint.firstAttribute == NSLayoutAttributeHeight) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint *)ja_widthConstraint{
    NSArray *allConstrint = self.constraints;
    for (NSLayoutConstraint *constraint in allConstrint) {
        if (constraint.firstItem == self && constraint.secondItem == nil && constraint.firstAttribute == NSLayoutAttributeWidth) {
            return constraint;
        }
    }
    return nil;
}

#pragma mark - Corner

- (void)ja_roundCorners:(UIRectCorner)corner radius:(CGFloat)radius{
    
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    CAShapeLayer*   frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    //    frameLayer.strokeColor = [UIColor redColor].CGColor;
    frameLayer.fillColor = nil;
    
    [self.layer addSublayer:frameLayer];
}

- (void)ja_roundTopCornersRadius:(CGFloat)radius {
    [self ja_roundCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:radius];
}

- (void)ja_roundBottomCornersRadius:(CGFloat)radius {
    [self ja_roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:radius];
}

- (void)ja_roundLeftCornerRadius:(CGFloat)radius {
    [self ja_roundCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) radius:radius];
}

- (void)ja_roundRightCornerRadius:(CGFloat)radius{
    [self ja_roundCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:radius];
}

#pragma mark -
- (void)ja_topBorderWidth:(CGFloat)width color:(UIColor *)color {
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, self.ja_width, width);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)ja_leftBorderWidth:(CGFloat)width color:(UIColor *)color {
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, width, self.ja_height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)ja_bottomBorderWidth:(CGFloat)width color:(UIColor *)color {
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.ja_height - width, self.ja_width, width);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

- (void)ja_rightBorderWidth:(CGFloat)width color:(UIColor *)color {
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(self.ja_width - width, 0, width, self.ja_height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

#pragma mark -
// Move via offset
- (void)ja_moveBy:(CGPoint)delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void)ja_scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

- (void)resetOriginAnchorPoint {
    self.ja_anchorPoint = CGPointMake(0.5f, 0.5f);
}

#pragma mark - 截屏
+ (UIImage *)ja_snapshotWindow {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), NO, 0);
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 * 截取inputView
 * scale - The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
 *
 */
+ (UIImage *)ja_snapshoFromView:(UIView *)inputView WithScale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, scale);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 * 获取tableView的截图
 * clipEdeInsets : default is UIEdgeInsetsZero;
 */
+ (UIImage *)ja_getTableViewImage:(UITableView *)tableView withClipEdeInsets:(UIEdgeInsets)clipEdeInsets {
    
    UIImage *viewImage = nil;
    UITableView *scrollView = tableView;
    CGSize finalSize = CGSizeMake(scrollView.contentSize.width - (clipEdeInsets.right + clipEdeInsets.left), scrollView.contentSize.height - (clipEdeInsets.top + clipEdeInsets.bottom));
    UIGraphicsBeginImageContextWithOptions(finalSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context == NULL)
        {
            return nil;
        }
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, -clipEdeInsets.left, -clipEdeInsets.top);
        
        [scrollView.layer renderInContext: context];
        CGContextRestoreGState(context);
        
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end

