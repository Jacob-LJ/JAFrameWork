//
//  SamplePubuController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/7.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SamplePubuController.h"
//
#import "SamplePubuLayout.h"
//view
#import "SamplePubuCCell.h"

@interface SamplePubuController ()<UICollectionViewDelegate, UICollectionViewDataSource, SamplePubuLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SamplePubuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpCollectionView];
    
}

- (void)setUpNav {
    self.title = @"简单瀑布流";
}

- (void)setUpCollectionView {
    SamplePubuLayout *pubuLayout = [[SamplePubuLayout alloc] init];
    pubuLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:pubuLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorF6F6F6];
    collectionView.showsVerticalScrollIndicator  = NO;
    [self.view addSubview:collectionView];
    
    //register cell
    [collectionView registerClass:[SamplePubuCCell class] forCellWithReuseIdentifier:SamplePubuCCellID];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SamplePubuCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SamplePubuCCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - SamplePubuLayout
- (CGFloat)samplePubuLayout:(SamplePubuLayout *)samplePubuLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth {
    CGFloat factor = ((arc4random() % 2) / 2.0); //0~1;
    CGFloat itemW = (JAScreenW - (SamplePubuCCell_MaxColumnNum + 1) * SamplePubuCCell_LeftMargin) / (SamplePubuCCell_MaxColumnNum * 1.0);
    return itemW * (factor + 1);
}


- (CGFloat)columnCountInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout {
    return SamplePubuCCell_MaxColumnNum;
}

- (CGFloat)columnMarginInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout {
    return SamplePubuCCell_LeftMargin;
}

- (CGFloat)rowMarginInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout {
    return SamplePubuCCell_LeftMargin;
}

- (UIEdgeInsets)edgeInsetsInSamplePubuLayout:(SamplePubuLayout *)samplePubuLayout {
    return UIEdgeInsetsMake(SamplePubuCCell_LeftMargin, SamplePubuCCell_LeftMargin, SamplePubuCCell_LeftMargin, SamplePubuCCell_LeftMargin * 2);
}


@end
