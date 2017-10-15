//
//  JAMLSudokuView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACommentFrameModel;

@interface JAMLSudokuView : UIView

@property (nonatomic, copy) void(^clickSudokuImageBlock)(NSInteger index);
@property (nonatomic, strong) JACommentFrameModel *frameModel;

@end