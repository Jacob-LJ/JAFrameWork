//
//  JAMLCommentWith1to9PicsCell.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JACommentFrameModel;

@interface JAMLCommentWith1to9PicsCell : UITableViewCell

@property (nonatomic, copy) void(^foldOrNotBlock)(void);
@property (nonatomic, copy) void(^clickImageIndexBlock)(NSInteger index);

- (void)configCellFrameModel:(JACommentFrameModel *)frameModel;

@end
