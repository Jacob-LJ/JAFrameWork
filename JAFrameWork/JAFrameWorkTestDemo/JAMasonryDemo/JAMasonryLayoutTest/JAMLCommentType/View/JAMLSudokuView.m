//
//  JAMLSudokuView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JAMLSudokuView.h"
#import "JAMLSudokuViewCCell.h"
#import "JACommentModel.h"
#import "JACommentFrameModel.h"

static NSString * const JAMLSudokuViewCCellID = @"JAMLSudokuViewCCell";

@interface JAMLSudokuView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation JAMLSudokuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUpCollectionView];
    }
    return self;
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = kImageCellPading;
    flowLayout.minimumLineSpacing = kImageCellPading;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[JAMLSudokuViewCCell class] forCellWithReuseIdentifier:JAMLSudokuViewCCellID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    self.flowLayout = flowLayout;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.frameModel.model.imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JAMLSudokuViewCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JAMLSudokuViewCCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击-- %@",indexPath);
    if (self.clickSudokuImageBlock) {
        self.clickSudokuImageBlock(indexPath.item);
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.frameModel.imageVItemSize;
}

#pragma mark - getter & setter
- (void)setFrameModel:(JACommentFrameModel *)frameModel {
    _frameModel = frameModel;
    [self.collectionView reloadData];
}

@end
