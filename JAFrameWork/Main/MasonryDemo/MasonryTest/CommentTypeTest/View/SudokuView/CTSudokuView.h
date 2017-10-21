//
//  CTSudokuView.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTCommentFrameModel;

@interface CTSudokuView : UIView

@property (nonatomic, copy) void(^clickSudokuImageBlock)(NSInteger index);
@property (nonatomic, strong) CTCommentFrameModel *frameModel;

@end
