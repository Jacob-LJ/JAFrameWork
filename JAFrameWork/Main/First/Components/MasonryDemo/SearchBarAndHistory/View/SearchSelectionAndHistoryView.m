//
//  SearchSelectionAndHistoryView.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/11.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SearchSelectionAndHistoryView.h"
#import "SearchHistoryCCell.h"
#import "HIstoryAlignmentLayout.h"

static NSString * const SearchHistoryCCellID = @"SearchHistoryCCell";

@interface SearchSelectionAndHistoryView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *switcherView;
@property (nonatomic, strong) UILabel *svTitleLB;
@property (nonatomic, strong) UIButton *svDiscountBtn;
@property (nonatomic, strong) UIButton *svMerchantBtn;
@property (nonatomic, strong) UIView *verticalLineV;

@property (nonatomic, strong) UIView *historyView;
@property (nonatomic, strong) UILabel *hvTitleLB;
@property (nonatomic, strong) UIButton *hvCleanBtn;
@property (nonatomic, strong) UICollectionView *hvColletionView;

//test
@property (strong, nonatomic) NSArray *items;

@end

@implementation SearchSelectionAndHistoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self generateItems];
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.switcherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(kSwitchViewH);
    }];
    
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.switcherView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchHistoryCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchHistoryCCellID forIndexPath:indexPath];
    [cell configCellWithAttriTitle:self.items[indexPath.item]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 0;
    NSAttributedString *attriStr = self.items[indexPath.item];
    CGSize maxSize = CGSizeMake(MAXFLOAT, GTSearchHistoryCCellH);
    CGFloat attriStrW = [attriStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
    width = attriStrW + 20;
    
    return CGSizeMake(width, GTSearchHistoryCCellH);
}

#pragma mark - private
- (void)discountBtnClick {
    
}

- (void)merchantBtnClick {
    
}

- (void)cleanBtnClcik {
    
}

#pragma mark - getter & setter
- (UIView *)switcherView {
    if (!_switcherView) {
        _switcherView = [[UIView alloc] init];
        [self addSubview:_switcherView];
        
        [self.svTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_switcherView).offset(36);
            make.centerX.equalTo(_switcherView);
        }];
        
        [self.verticalLineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.svTitleLB.mas_bottom).offset(25);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(14);
            make.centerX.equalTo(_switcherView);
        }];
        
        [self.svDiscountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.verticalLineV.mas_left).offset(-23);
            make.centerY.equalTo(self.verticalLineV);
        }];
        
        [self.svMerchantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.verticalLineV.mas_right).offset(23);
            make.centerY.equalTo(self.verticalLineV);
        }];
        
    }
    return _switcherView;
}

- (UILabel *)svTitleLB {
    if (!_svTitleLB) {
        _svTitleLB = [[UILabel alloc] init];
        _svTitleLB.text = @"指定搜索内容";
        _svTitleLB.textColor = [UIColor color9999];
        _svTitleLB.font = [UIFont fontRegular14];
        [self.switcherView addSubview:_svTitleLB];
    }
    return _svTitleLB;
}

- (UIButton *)svDiscountBtn {
    if (!_svDiscountBtn) {
        _svDiscountBtn = [[UIButton alloc] init];
        _svDiscountBtn.titleLabel.font = [UIFont fontRegular16];
        [_svDiscountBtn setTitle:@"优惠" forState:UIControlStateNormal];
        [_svDiscountBtn setTitleColor:[UIColor colorFF4A2A] forState:UIControlStateNormal];
        [_svDiscountBtn addTarget:self action:@selector(discountBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.switcherView addSubview:_svDiscountBtn];
    }
    return _svDiscountBtn;
}

- (UIButton *)svMerchantBtn {
    if (!_svMerchantBtn) {
        _svMerchantBtn = [[UIButton alloc] init];
        _svMerchantBtn.titleLabel.font = [UIFont fontRegular16];
        [_svMerchantBtn setTitle:@"商家" forState:UIControlStateNormal];
        [_svMerchantBtn setTitleColor:[UIColor colorFF4A2A] forState:UIControlStateNormal];
        [_svMerchantBtn addTarget:self action:@selector(merchantBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.switcherView addSubview:_svMerchantBtn];
    }
    return _svMerchantBtn;
}

- (UIView *)verticalLineV {
    if (!_verticalLineV) {
        _verticalLineV = [[UIView alloc] init];
        _verticalLineV.backgroundColor = [UIColor colorFF4A2A];
        [self.switcherView addSubview:_verticalLineV];
    }
    return _verticalLineV;
}

#pragma mark - history
- (UIView *)historyView {
    if (!_historyView) {
        _historyView = [[UIView alloc] init];
        [self addSubview:_historyView];
        
        [self.hvTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_historyView);
            make.height.mas_equalTo(24);
            make.centerX.equalTo(_historyView);
        }];
        
        [self.hvCleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_historyView);
            make.right.equalTo(_historyView).offset(-12);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [self.hvColletionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hvTitleLB.mas_bottom).offset(24);
            make.left.equalTo(_historyView).offset(12);
            make.right.equalTo(_historyView).offset(-12);
            make.bottom.equalTo(_historyView).offset(-12);
        }];
    }
    return _historyView;
}

- (UILabel *)hvTitleLB {
    if (!_hvTitleLB) {
        _hvTitleLB = [[UILabel alloc] init];
        _hvTitleLB.text = @"历史搜索记录";
        _hvTitleLB.textColor = [UIColor color9999];
        _hvTitleLB.font = [UIFont fontRegular14];
        [self.historyView addSubview:_hvTitleLB];
    }
    return _hvTitleLB;
}

- (UIButton *)hvCleanBtn {
    if (!_hvCleanBtn) {
        _hvCleanBtn = [[UIButton alloc] init];
        [_hvCleanBtn setImage:[UIImage imageNamed:@"search_delect"] forState:UIControlStateNormal];
        [_hvCleanBtn addTarget:self action:@selector(cleanBtnClcik) forControlEvents:UIControlEventTouchUpInside];
        [self.historyView addSubview:_hvCleanBtn];
    }
    return _hvCleanBtn;
}

- (UICollectionView *)hvColletionView {
    if (!_hvColletionView) {
        HIstoryAlignmentLayout *flowLayout = [[HIstoryAlignmentLayout alloc] init];
        flowLayout.alignment = FlowAlignmentLeft;
        flowLayout.minimumInteritemSpacing = 12;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _hvColletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _hvColletionView.backgroundColor = [UIColor whiteColor];
        _hvColletionView.delegate = self;
        _hvColletionView.dataSource = self;
        [_hvColletionView registerClass:[SearchHistoryCCell class] forCellWithReuseIdentifier:SearchHistoryCCellID];
        [self.historyView addSubview:_hvColletionView];
    }
    return _hvColletionView;
}

//test
- (void)generateItems {
    
    NSNumberFormatter *nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterSpellOutStyle;
    NSMutableArray *array = [NSMutableArray array];
    
    const NSInteger count = 28;
    //文字数组
    for (NSInteger i = 0; i < count; ++i) {
        NSString *str = [NSString stringWithFormat:@"%@", [nf stringFromNumber:@(i)]];
        NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:str attributes:@{
                                                                                                   NSForegroundColorAttributeName : [UIColor color3333],
                                                                                                   NSFontAttributeName : [UIFont fontRegular14],
                                                                                                   }];
        [array addObject:attriStr];
    }
    //乱序
    for (NSInteger i = 0; i < count - 1; ++i) {
        id peek = [array objectAtIndex:i + arc4random_uniform((int)(count - i))];
        [array replaceObjectAtIndex:i withObject:peek];
    }
    self.items = array.copy;
}

@end
