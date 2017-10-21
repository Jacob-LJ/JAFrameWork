//
//  JACommentFrameModel.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/14.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JACommentFrameModel.h"
#import "JACommentModel.h"
#import <YYLabel.h>


@interface JACommentFrameModel ()

@property (nonatomic, strong) YYLabel *contentLB;
@property (nonatomic, assign) CGFloat contentLBMaxW;

@end

@implementation JACommentFrameModel
@synthesize contentAttributeDit = _contentAttributeDit;

- (instancetype)init {
    if (self = [super init]) {
        _contentLBTopMargin = 12;
        _sudokuViewTopMargin = 12;
        _contentLBMaxW = (JAScreenW - kAvatarWH - kLRMargin * 3);
        _foldUpContent = YES;
    }
    return self;
}

#pragma mark - getter & setter
- (NSDictionary *)contentAttributeDit {
    
    if (!_contentAttributeDit) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        _contentAttributeDit = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName : kColor6666,
                                 NSParagraphStyleAttributeName : style,
                                 };
    }
    return _contentAttributeDit;
}

- (void)setModel:(JACommentModel *)model {
    _model = model;
    
    //正文内容高度
    CGFloat contentH = 0;
    if (model.content.length) {
        _contentLBTopMargin = 5.5;
        
        contentH = [self caculateContentHeightWithContentStr:model.content];
        
    } else {
        _contentLBTopMargin = 0;
    }
    
    //九宫格大小
    //九宫格图片默认大小
    CGFloat itemW = (_contentLBMaxW - 2 * kImageCellPading) / 3.0;
    self.imageVItemSize = CGSizeMake(itemW, itemW);
    
    CGFloat maxColumn = 3;
    CGFloat sudokuW = 0;
    CGFloat sudokuH = 0;
    if (model.imageCount) {
        _sudokuViewTopMargin = 12;
        //正常九宫格的view大小
        NSInteger maxRow = (model.imageCount + maxColumn - 1) / maxColumn;
        _maxRowNum = maxRow;
        
        sudokuW = _contentLBMaxW;
        sudokuH = maxRow * itemW + (maxRow - 1) * kImageCellPading;
        
        //特殊情况
        if (model.imageCount == 1) {
            sudokuW = 100;
            sudokuH = 150;
            self.imageVItemSize = CGSizeMake(sudokuW, sudokuH);
        } else if (model.imageCount == 4) {
            sudokuW = 2 * itemW + kImageCellPading+1;
            sudokuH = sudokuW;
        }
    } else {
        _sudokuViewTopMargin = 0;
    }
    
    self.sudokuViewSize = CGSizeMake(sudokuW, sudokuH);
    
    //cell 的高度
    self.cellHeight = kAvatarTopMargin + kAvatarWH + self.contentLBTopMargin + contentH + self.sudokuViewTopMargin + sudokuH + kBottomMargin;
    
}

#pragma mark - Private
- (CGFloat)caculateContentHeightWithContentStr:(NSString *)contentStr {
    if (!self.isFoldUpContent) {
        self.contentLB.numberOfLines = 0;
    } else {
        self.contentLB.numberOfLines = 2;
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:contentStr attributes:self.contentAttributeDit]];
    self.contentLB.attributedText = text;
    [self.contentLB sizeToFit];
    
    CGFloat contentH = self.contentLB.frame.size.height;
    return contentH;
}

#pragma mark - getter & setter
//正文内容
- (YYLabel *)contentLB {
    if (!_contentLB) {
        
        _contentLB = [[YYLabel alloc] initWithFrame:CGRectMake(0, 0, _contentLBMaxW, CGFLOAT_MAX)];
        _contentLB.numberOfLines = 2;
    }
    return _contentLB;
}

- (void)setFoldUpContent:(BOOL)foldUpContent {
    _foldUpContent = foldUpContent;
    CGFloat contentH = [self caculateContentHeightWithContentStr:self.model.content];
    self.cellHeight = kAvatarTopMargin + kAvatarWH + self.contentLBTopMargin + contentH + self.sudokuViewTopMargin + self.sudokuViewSize.height + kBottomMargin;
}


@end
