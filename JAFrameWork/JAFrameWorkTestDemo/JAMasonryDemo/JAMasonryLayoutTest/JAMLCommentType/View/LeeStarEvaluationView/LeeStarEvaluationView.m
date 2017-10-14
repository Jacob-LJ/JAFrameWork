//
//  LeeStarEvaluationView.m
//  LinkEOL_Project
//
//  Created by mac on 2017/5/8.
//  Copyright © 2017年 Limiao. All rights reserved.
//

#import "LeeStarEvaluationView.h"


typedef void(^LeeEvaluateViewDidChooseStarBlock)(NSUInteger count);

@interface LeeStarEvaluationView ()

@property (nonatomic, assign)   NSUInteger index;
@property (nonatomic, copy)     LeeEvaluateViewDidChooseStarBlock evaluateViewChooseStarBlock;

@end


@implementation LeeStarEvaluationView

/**************初始化TggEvaluationView*************/
+ (instancetype)evaluationViewWithChooseStarBlock:(void(^)(NSUInteger count))evaluateViewChoosedStarBlock {
    LeeStarEvaluationView *evaluationView = [[LeeStarEvaluationView alloc] init];
    evaluationView.backgroundColor = [UIColor grayColor];
    evaluationView.evaluateViewChooseStarBlock = ^(NSUInteger count) {
        if (evaluateViewChoosedStarBlock) {
            evaluateViewChoosedStarBlock(count);
        }
    };
    return evaluationView;
}



#pragma mark - AccessorMethod
- (void)setStarCount:(NSUInteger)starCount {
    self.index = starCount;

    
    if (starCount == 0) {
        return;
    }
    
    if (_starCount != starCount) {
        _starCount = starCount;
        
        if (starCount > self.totalStar) {
            starCount = self.totalStar;
        }
        
        [self setNeedsDisplay];

        if (self.evaluateViewChooseStarBlock) {
            self.evaluateViewChooseStarBlock(self.index);
        }
    }
}


- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    self.userInteractionEnabled = tapEnabled;
}

- (void)setSpacing:(CGFloat)spacing {
    if (_spacing != spacing) {
        _spacing = spacing;
        [self setNeedsDisplay];
    }
}



#pragma mark - DrawStarsMethod

/**************重写*************/
- (void)drawRect:(CGRect)rect {
    
//    NSLog(@"spacing %f",self.spacing);
   
    UIImage *norImage = [UIImage imageNamed:@"home_score_gray"];
    UIImage *selImage = [UIImage imageNamed:@"home_score_cheng"];
    // 图片没间隙自己画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 默认间隙为星星一半
    CGFloat spacing = self.frame.size.width / (20.00 * ((CGFloat)self.totalStar /5.00)); //以20 为起点
    CGFloat top = 0;
    CGFloat starWidth = spacing * 2;
    if (self.spacing != 0) {
        
        if (self.spacing > 1) {
            self.spacing = 1;
        }
        // 在中间 为 0.5；
        starWidth = self.frame.size.width / ((self.spacing * 10 + 5) * ((CGFloat)self.totalStar /5.00));
        spacing = starWidth * self.spacing;
    }
    // 如果高度过高则居中
    if (self.frame.size.height > starWidth) {
        top = (self.frame.size.height - starWidth) / 2;
    }
    // 画图
    
    for (NSInteger i = 0; i < self.totalStar; i++) {
        //        NSLog(@"--%ld -%ld",i,self.totalStar);
        
        UIImage *drawImage = i < self.index ? selImage : norImage;
        [self drawImage:context CGImageRef:drawImage.CGImage CGRect:CGRectMake((i == 0) ? spacing : 2 * i * spacing + spacing + starWidth * i, top, starWidth, starWidth)];
    }
    // 瞬间画满,需要图片有间隙
    //CGContextDrawTiledImage(context, CGRectMake(0, 0, 30, 30), image.CGImage);
}

/**************将坐标翻转画图*************/
- (void)drawImage:(CGContextRef)context CGImageRef:(CGImageRef)image CGRect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    
    CGContextRestoreGState(context);
}


#pragma mark - TouchGestureMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.index = point.x / (self.frame.size.width / self.totalStar) + 1;
    if (self.index == (self.totalStar +1)) {
        self.index --;
    }
    
    [self setNeedsDisplay];
    if (self.evaluateViewChooseStarBlock) {
        self.evaluateViewChooseStarBlock(self.index);
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

-(void)dealloc{

    NSLog(@"dealloc ---- %@",self.class);
    
}


@end
