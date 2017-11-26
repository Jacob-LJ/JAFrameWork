//
//  jaTableViewVC_GT.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABaseViewController.h"

//防止报错引入
#import "GTConfigDefine.h"
#import "GTBaseVCMethods.h"

@interface jaTableViewVC_GT : JABaseViewController

//防止报错引入的
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;


/**
 tableView 是否显示 空载状态
 */
@property (nonatomic ,assign) BOOL isShowEmptyView;

/**
 tableView 空载状态下 btn 的名字  暂时用不上
 */
@property (nonatomic ,copy) NSString *tintBtnTitle;

/**
 tableView 空载状态下 提示文字
 */
@property (nonatomic ,copy) NSString *tintStr;


/**
 tableView 空载状态下 btn 的图片
 */
@property (nonatomic,copy)NSString *tintBtnImgName;


/**
 tableView 空载状态下 空载下图片名字
 */
@property (nonatomic,copy) NSString *tintImgName;

@end
