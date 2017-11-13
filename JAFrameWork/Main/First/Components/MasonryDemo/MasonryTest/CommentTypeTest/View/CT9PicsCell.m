//
//  CT9PicsCell.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "CT9PicsCell.h"

#import "LeeStarEvaluationView.h"
#import "CTSudokuView.h"
#import "CTCommentFrameModel.h"
#import "CTCommentModel.h"

#import <YYLabel.h>
#import <NSAttributedString+YYText.h>

@interface CT9PicsCell ()

@property (nonatomic, strong) UIImageView *avatarImageV;
@property (nonatomic, strong) UILabel *dateLB;

@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIView *starContainerV;
@property (nonatomic, strong) LeeStarEvaluationView *starView;
@property (nonatomic, strong) UIView *verticalCenterNameLBStarViewContainerV;

@property (nonatomic, strong) YYLabel *contentLB;
@property (nonatomic, strong) CTSudokuView *sudokuView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) CTCommentFrameModel *frameModel;


@end

@implementation CT9PicsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加约束
        [self addConstraintsOnSubviews];
    }
    return self;
}

- (void)addConstraintsOnSubviews {
    
    CGFloat sudokuViewTopMargin = 12;
    
    //头像
    [self.avatarImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(kAvatarTopMargin);
        make.width.height.mas_equalTo(kAvatarWH);
    }];
    
    //日期
    [self.dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kLRMargin);
        make.centerY.equalTo(self.nameLB.mas_centerY);
    }];
    
    //垂直居中名字和星星打分的容器
    [self.verticalCenterNameLBStarViewContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageV.mas_right).offset(kImageVNameLBMargin);
        make.right.lessThanOrEqualTo(self.dateLB.mas_left).offset(-kLRMargin);
        make.height.equalTo(self.nameLB.mas_height).offset(self.starView.frame.size.height);
        make.centerY.equalTo(self.avatarImageV.mas_centerY);
    }];
    //名字
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_top);
        make.left.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_left);
        make.right.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_right);
        
    }];
    //星星打分ContainerView
    [self.starContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLB.mas_bottom);
        make.left.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_left);
        make.bottom.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_bottom);
        make.right.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_right);
    }];
    
    
    //正文内容
    self.contentLB.preferredMaxLayoutWidth = (JAScreenW - kAvatarWH - kLRMargin * 3);
    [self.contentLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_bottom).offset(kLRMargin);
        make.left.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_left);
        make.right.greaterThanOrEqualTo(self.contentView.mas_right).offset(-kLRMargin);
    }];
    
    //九宫格view
    [self.sudokuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLB.mas_bottom).offset(sudokuViewTopMargin);
        make.left.equalTo(self.contentLB.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-kLRMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kLRMargin * 2);
    }];
    
    //分隔线
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kLRMargin);
        make.right.equalTo(self.contentView.mas_right).offset(-kLRMargin);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
}

#pragma mark - Private
- (void)addSeeMoreButton {
    
    JAWeakSelf
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"... 查看全文"];
    
    YYTextHighlight *hi = [[YYTextHighlight alloc] init];
    [hi setColor:[UIColor colorWithHexString:@"#FF002D"]];
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        if (weakSelf.foldOrNotBlock) {
            weakSelf.foldOrNotBlock();
        }
    };
    
    [text setColor:[UIColor colorWithHexString:@"#FF002D"] range:[text.string rangeOfString:@"查看全文"]];
    [text setTextHighlight:hi range:[text.string rangeOfString:@"查看全文"]];
    text.font = [UIFont systemFontOfSize:14];
    
    YYLabel *seeMore = [[YYLabel alloc] init];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.font alignment:YYTextVerticalAlignmentCenter];
    self.contentLB.truncationToken = truncationToken;
}

#pragma mark - configModel
- (void)configCellFrameModel:(CTCommentFrameModel *)frameModel {
    self.frameModel = frameModel;
    CTCommentModel *commentModel = frameModel.model;
    
    //正文
    [self.contentLB setNumberOfLines:frameModel.isFoldUpContent ? 2 : 0];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    NSString *contentStr = commentModel.content;
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:contentStr attributes:@{
                                                                                                    NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                                    NSForegroundColorAttributeName : [UIColor color6666],
                                                                                                    NSParagraphStyleAttributeName : style,
                                                                                                    }]];
    
    self.contentLB.attributedText = text;
    [self addSeeMoreButton];
    
    [self.contentLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verticalCenterNameLBStarViewContainerV.mas_bottom).offset(frameModel.contentLBTopMargin);
    }];
    
    //九宫格
    [self.sudokuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLB.mas_bottom).offset(frameModel.sudokuViewTopMargin);
        make.left.equalTo(self.contentLB.mas_left);
        make.size.mas_equalTo(frameModel.sudokuViewSize);
    }];
    [self.contentView updateConstraintsIfNeeded];
    
    self.sudokuView.frameModel = frameModel;
    self.sudokuView.clickSudokuImageBlock = self.clickImageIndexBlock;
    
}

#pragma mark - setter & getter
//头像
- (UIImageView *)avatarImageV {
    if (!_avatarImageV) {
        _avatarImageV = [[UIImageView alloc] init];
        _avatarImageV.layer.cornerRadius = kAvatarWH * 0.5;
        _avatarImageV.clipsToBounds = YES;
        _avatarImageV.backgroundColor = [UIColor purpleColor];
        //        _avatarImageV.image = kImgWithName(@"test1");
        [self.contentView addSubview:_avatarImageV];
    }
    return _avatarImageV;
}

//星星打分containerView
- (UIView *)starContainerV {
    if (!_starContainerV) {
        _starContainerV = [[UIView alloc] init];
        //        _starContainerV.backgroundColor = [UIColor purpleColor];
        [self.verticalCenterNameLBStarViewContainerV addSubview:_starContainerV];
    }
    return _starContainerV;
}

//星星view
- (LeeStarEvaluationView *)starView {
    if (!_starView) {
        CGFloat starViewW = 90;
        CGFloat starViewH = 20;
        _starView = [LeeStarEvaluationView evaluationViewWithChooseStarBlock:NULL];
        _starView.frame = CGRectMake(0, 0, starViewW, starViewH);
        _starView.spacing = 0.2;
        _starView.starCount = 3;
        _starView.backgroundColor = [UIColor whiteColor];
        _starView.totalStar = 5;
        _starView.tapEnabled = NO;
        [self.starContainerV addSubview:_starView];
    }
    return _starView;
}

//日期
- (UILabel *)dateLB {
    if (!_dateLB) {
        _dateLB = [[UILabel alloc] init];
        _dateLB.text = @"2017.5.7";
        _dateLB.font = [UIFont systemFontOfSize:12];
        _dateLB.textColor = [UIColor color9999];
        [self.contentView addSubview:_dateLB];
    }
    return _dateLB;
}

//垂直居中名字和星星打分的容器
- (UIView *)verticalCenterNameLBStarViewContainerV {
    if (!_verticalCenterNameLBStarViewContainerV) {
        _verticalCenterNameLBStarViewContainerV = [[UIView alloc] init];
        //        _verticalCenterNameLBStarViewContainerV.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_verticalCenterNameLBStarViewContainerV];
    }
    return _verticalCenterNameLBStarViewContainerV;
}

//名字
- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.text = @"我是昵称";
        _nameLB.font = [UIFont systemFontOfSize:16];
        _nameLB.textColor = [UIColor color3333];
        [self.verticalCenterNameLBStarViewContainerV addSubview:_nameLB];
    }
    return _nameLB;
}

//正文内容
- (YYLabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[YYLabel alloc] init];
        _contentLB.font = [UIFont systemFontOfSize:14];
        _contentLB.textColor = [UIColor color6666];
        _contentLB.numberOfLines = 2;
        [self.contentView addSubview:_contentLB];
    }
    return _contentLB;
}

//九宫格view
- (CTSudokuView *)sudokuView {
    if (!_sudokuView) {
        _sudokuView = [[CTSudokuView alloc] init];
        //        _sudokuView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_sudokuView];
    }
    return _sudokuView;
}

//分隔线
- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorEEEE];
        [self.contentView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}

@end
