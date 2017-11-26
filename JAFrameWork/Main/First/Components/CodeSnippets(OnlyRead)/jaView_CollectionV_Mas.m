//
//  jaView_CollectionV_Mas.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

/*
 Titile   : jaView_CollectionV_Mas
 Summary  : Mas布局View内带CollectionView
 ShortCut : jaView_CollectionV_Mas
 */

#import "jaView_CollectionV_Mas.h"
//view
#import "jaCCell_Mas.h"

static const CGFloat kMaxColumn = 3;

@interface jaView_CollectionV_Mas ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation jaView_CollectionV_Mas

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUpCollectionView];
    }
    return self;
}

- (void)setUpCollectionView {
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    CGFloat totalMargin = self.flowLayout.minimumInteritemSpacing * (kMaxColumn - 1);
    //    CGFloat itemWH = (JAScreenW - totalMargin) / kMaxColumn;
    //    CGSize itemSize = CGSizeMake(itemWH, itemWH);
    //    flowLayout.itemSize = itemSize;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = NO;
//    collectionView.scrollEnabled = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[jaCCell_Mas class] forCellWithReuseIdentifier:jaCCell_MasID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    self.flowLayout = flowLayout;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    jaCCell_Mas *cell = [collectionView dequeueReusableCellWithReuseIdentifier:jaCCell_MasID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击-- %@",indexPath);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat totalMargin = self.flowLayout.minimumInteritemSpacing * (kMaxColumn - 1);
    CGFloat itemWH = (JAScreenW - totalMargin) / kMaxColumn;
    return CGSizeMake(itemWH, itemWH);
}


@end
