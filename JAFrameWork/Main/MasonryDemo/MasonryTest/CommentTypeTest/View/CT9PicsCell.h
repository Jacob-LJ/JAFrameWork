//
//  CT9PicsCell.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CTCommentFrameModel;

@interface CT9PicsCell : UITableViewCell

@property (nonatomic, copy) void(^foldOrNotBlock)(void);
@property (nonatomic, copy) void(^clickImageIndexBlock)(NSInteger index);

- (void)configCellFrameModel:(CTCommentFrameModel *)frameModel;

@end
