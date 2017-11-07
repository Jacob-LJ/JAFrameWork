//
//  SamplePubuLayout.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

//reference from https://github.com/renyufei8023/WaterFlow

#import <UIKit/UIKit.h>

@class SamplePubuLayout;

@protocol SamplePubuLayoutDelegate <NSObject>

@required
- (CGFloat)samplePubuLayout:(SamplePubuLayout *)samplePubuLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout;
- (CGFloat)columnMarginInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout;
- (CGFloat)rowMarginInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout;
- (UIEdgeInsets)edgeInsetsInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout;

@end

@interface SamplePubuLayout : UICollectionViewLayout

@property (nonatomic ,weak) id<SamplePubuLayoutDelegate> delegate;

@end
