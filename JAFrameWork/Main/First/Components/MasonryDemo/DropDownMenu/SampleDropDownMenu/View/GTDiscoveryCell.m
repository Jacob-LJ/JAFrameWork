//
//  GTDiscoveryCell.m
//  XQCity
//
//  Created by Jacob on 2017/11/22.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import "GTDiscoveryCell.h"

static const CGFloat kLeftMargin = 10;
static const CGFloat kBgImageVH = 170;
static const CGFloat kTagContainerVW = 87;
static const CGFloat kTagContainerVH = 29;

@interface GTDiscoveryCell ()

@property (nonatomic, strong) UIView *containerV;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIButton *descBtn;
@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UILabel *priceLB;

@property (nonatomic, strong) UIView *tagContainerV;
@property (nonatomic, strong) UIImageView *tagBgImageV;
@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation GTDiscoveryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addConstraintOnSubviews];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    
    [self.containerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kLeftMargin);
        make.left.equalTo(self.contentView).offset(kLeftMargin);
        make.right.equalTo(self.contentView).offset(-kLeftMargin);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.tagContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(17);
        make.left.equalTo(self.contentView).offset(7);
        make.size.mas_equalTo(CGSizeMake(kTagContainerVW, kTagContainerVH));
    }];
}

#pragma mark - getter & setter
- (UIView *)containerV {
    if (!_containerV) {
        _containerV = [[UIView alloc] init];
        _containerV.backgroundColor = [UIColor whiteColor];
        _containerV.layer.cornerRadius = 8;
        _containerV.clipsToBounds = YES;
        //layout subView
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.containerV);
            make.height.mas_equalTo(kBgImageVH);
        }];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageV.mas_bottom).offset(kLeftMargin);
            make.left.equalTo(self.imageV).offset(kLeftMargin);
            make.right.equalTo(self.imageV).offset(-kLeftMargin);
        }];
        [self.descBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_bottom).offset(15);
            make.left.equalTo(self.containerV).offset(kLeftMargin);
        }];
        [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_bottom).offset(15);
            make.left.equalTo(self.containerV).offset(122);
        }];
        [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerV).offset(-kLeftMargin);
            make.bottom.equalTo(self.containerV).offset(-7);
        }];
        
        [self.contentView addSubview:_containerV];
    }
    return _containerV;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        [self.containerV addSubview:_imageV];
    }
    return _imageV;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.numberOfLines = 1;
        _titleLB.font = kFont_Regular_14;
        _titleLB.textColor = kColor_333333;
        [self.containerV addSubview:_titleLB];
        
        _titleLB.text = @"会员福利 | 超人气小课程开堂了，科学实验等你来！";
    }
    return _titleLB;
}

- (UIButton *)descBtn {
    if (!_descBtn) {
        _descBtn = [[UIButton alloc] init];
        _descBtn.titleLabel.font = [UIFont fontRegular12];
        [_descBtn setTitleColor:[UIColor color6666] forState:UIControlStateNormal];
        [_descBtn setImage:[UIImage imageNamed:@"discover_icon_location_disabled"] forState:UIControlStateNormal];
        [self.containerV addSubview:_descBtn];
        
        [_descBtn setTitle:@"调查范围" forState:UIControlStateNormal];
    }
    return _descBtn;
}

- (UIButton *)dateBtn {
    if (!_dateBtn) {
        _dateBtn = [[UIButton alloc] init];
        _dateBtn.titleLabel.font = [UIFont fontRegular12];
        [_dateBtn setTitleColor:[UIColor color6666] forState:UIControlStateNormal];
        [_dateBtn setImage:[UIImage imageNamed:@"discover_icon_location_disabled"] forState:UIControlStateNormal];
        [self.containerV addSubview:_dateBtn];
        
        [_dateBtn setTitle:@"2017-10-30" forState:UIControlStateNormal];
    }
    return _dateBtn;
}

- (UILabel *)priceLB {
    if (!_priceLB) {
        _priceLB = [[UILabel alloc] init];
        _priceLB.numberOfLines = 1;
        [self.containerV addSubview:_priceLB];
//        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//        style.lineSpacing = 4;
        NSDictionary *attriDict1 = @{
                                     NSFontAttributeName : kFont_Regular_18,
                                     NSForegroundColorAttributeName : kRGBAColor(237, 119, 75, 1),
                                     };
        NSMutableAttributedString *attriM = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:attriDict1];
        
        NSDictionary *attriDict = @{
                                    NSFontAttributeName : kFont_Regular_24,
                                    NSForegroundColorAttributeName : kRGBAColor(237, 119, 75, 1),
                                    //                                    NSParagraphStyleAttributeName : style,
                                    };
        NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:@"99999" attributes:attriDict];
        
        [attriM appendAttributedString:attriStr];
        _priceLB.attributedText = attriM;
    }
    return _priceLB;
}

- (UIView *)tagContainerV {
    if (!_tagContainerV) {
        _tagContainerV = [[UIView alloc] init];
        [self.contentView addSubview:_tagContainerV];
        //layout subView
        [self.tagBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tagContainerV);
        }];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagContainerV).offset(3);
            make.right.bottom.equalTo(self.tagContainerV);
            make.left.equalTo(self.tagContainerV);
        }];
    }
    return _tagContainerV;
}

- (UIImageView *)tagBgImageV {
    if (!_tagBgImageV) {
        _tagBgImageV = [[UIImageView alloc] init];
        _tagBgImageV.image = [UIImage imageNamed:@"discover_tag_yellow"];
        [self.tagContainerV addSubview:_tagBgImageV];
    }
    return _tagBgImageV;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = kColor_333333;
        _tagLabel.font = [UIFont fontRegular12];
        [self.tagContainerV addSubview:_tagLabel];
        
        _tagLabel.text = @"送优惠券";
    }
    return _tagLabel;
}

@end
