//
//  jaCollectionViewVC_GT.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABaseViewController.h"

//防止报错引入
#import "GTConfigDefine.h"
#import "GTBaseVCMethods.h"

@interface jaCollectionViewVC_GT : JABaseViewController

@property (nonatomic ,strong) UICollectionView *collectionView;

@property (nonatomic ,assign) BOOL isShowEmptyView;


@property (nonatomic, strong) UICollectionViewLayout *layout;

@property (nonatomic ,copy) NSString *tintStr;

@property (nonatomic ,copy) NSString *tintBtnTitle;
@property (nonatomic,copy)NSString *tintBtnImgName;
@property (nonatomic,copy) NSString *tintImgName;

@end
