//
//  GTShareActionSheetCell.m
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import "GTShareActionSheetCell.h"
#import "GTShareActionSheetConst.h"
//view
#import "GTShareItemCCell.h"

@interface GTShareActionSheetCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemArray;

@end


@implementation GTShareActionSheetCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - public
- (void)configWithItemArray:(NSArray *)itemArray {
    self.itemArray = [NSArray arrayWithArray:itemArray];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GTShareItemCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTShareItemCCellID forIndexPath:indexPath];
    GTShareItem *item = self.itemArray[indexPath.item];
    [cell configWithModel:item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GTShareItem *item = self.itemArray[indexPath.item];
    if (self.clickItemBlock) {
        self.clickItemBlock(item);
    }
}

#pragma mark - getter & setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth / 4.0, kSASTableViewCellH);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //register
        [_collectionView registerClass:[GTShareItemCCell class] forCellWithReuseIdentifier:GTShareItemCCellID];
        
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

@end
