//
//  jaCell_Mas.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

/*
 Titile   : jaCell_Mas
 Summary  : Mas布局Cell内imageV+titleLB+descLB+btmLine
 ShortCut : jaCell_Mas
 */

#import "jaCell_Mas.h"

static const CGFloat kImageVWH = 68;
static const CGFloat kLeftMargin = 12;

@interface jaCell_Mas ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *descLB;
@property (nonatomic, strong) UIView *btmLineV;

@end

@implementation jaCell_Mas

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kLeftMargin*2);
        make.left.equalTo(self.contentView).offset(kLeftMargin);
        make.size.mas_equalTo(CGSizeMake(kImageVWH, kImageVWH));
    }];
    
//    self.titleLB.preferredMaxLayoutWidth = (kScreenWidth - kLeftMargin * 2);
//    [self.titleLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV);
        make.left.equalTo(self.imageV.mas_right).offset(kLeftMargin);
        make.right.equalTo(self.contentView).offset(-kLeftMargin);
    }];
    
    [self.descLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLB.mas_bottom).offset(12);
        make.left.equalTo(self.imageV.mas_right).offset(kLeftMargin);
        make.right.equalTo(self.contentView).offset(-kLeftMargin);
    }];
    
    [self.btmLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kLeftMargin);
        make.right.equalTo(self.contentView).offset(-kLeftMargin);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - getter & setter
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.image = [UIImage imageNamed:@"login_icon_logo"];
        _imageV.layer.cornerRadius = 4;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.numberOfLines = 1;
        _titleLB.font = kFont_Medium_18;
        _titleLB.textColor = kColor_333333;
        [self.contentView addSubview:_titleLB];
        
        _titleLB.text = @"探鱼";
    }
    return _titleLB;
}

- (UILabel *)descLB {
    if (!_descLB) {
        _descLB = [[UILabel alloc] init];
        _descLB.numberOfLines = 2;
        [self.contentView addSubview:_descLB];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 4;
        NSDictionary *attriDict = @{
                                    NSFontAttributeName : kFont_Regular_12,
                                    NSForegroundColorAttributeName : kColor_666666,
                                    NSParagraphStyleAttributeName : style,
                                    };
        //主要防止空字符串崩溃
        _descLB.attributedText = [[NSAttributedString alloc] initWithString:@"最文艺的烤鱼，吃过忘不了，等你来品尝，风里雨里高德等你" attributes:attriDict];
        _descLB.lineBreakMode = NSLineBreakByTruncatingTail; //Lable设置富文本时不会默认设置 lineBreakMode 的，而普通text则会给个默认省略号 lineBreakMode
    }
    return _descLB;
}

- (UIView *)btmLineV {
    if (!_btmLineV) {
        _btmLineV = [[UIView alloc] init];
        _btmLineV.backgroundColor = kColor_eeeeee;
        [self.contentView addSubview:_btmLineV];
    }
    return _btmLineV;
}

@end
