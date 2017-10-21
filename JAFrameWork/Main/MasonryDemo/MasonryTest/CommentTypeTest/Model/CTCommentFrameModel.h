//
//  CTCommentFrameModel.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

static const CGFloat kAvatarWH = 54;
static const CGFloat kLRMargin = 12;
static const CGFloat kAvatarTopMargin = 12;
static const CGFloat kImageVNameLBMargin = 12;
static const CGFloat kImageCellPading = 8;
static const CGFloat kBottomMargin = 24;

@class CTCommentModel;

@interface CTCommentFrameModel : NSObject

@property (nonatomic, strong, readonly) NSDictionary *contentAttributeDit; //正文内容属性

@property (nonatomic, strong) CTCommentModel *model;
@property (nonatomic, assign, readonly) NSInteger maxRowNum;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGSize sudokuViewSize;//九宫格view大小
@property (nonatomic, assign) CGSize imageVItemSize;//九宫格图片大小


@property (nonatomic, assign, readonly) CGFloat contentLBTopMargin;
@property (nonatomic, assign, readonly) CGFloat sudokuViewTopMargin;

@property (nonatomic, assign, getter=isFoldUpContent) BOOL foldUpContent;

@end
