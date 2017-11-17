//
//  GTShareActionSheet.m
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import "GTShareActionSheet.h"
//view
#import "GTShareActionSheetCell.h"
//
#import "GTShareActionSheetConst.h"
//model
#import "GTShareItem.h"

@interface GTShareActionSheet ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *actionSheetContainerV;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *descLB;

@property (nonatomic, strong) UIView *footerV;
@property (nonatomic, strong) UIView *marginV;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) NSMutableArray *shareItemArrM;
@property (nonatomic, strong) NSMutableArray *funcItemArrM;

@end

@implementation GTShareActionSheet

+ (instancetype)showShareActionSheet {
    
    GTShareActionSheet *shareSheet = [[GTShareActionSheet alloc] initWithFrame:CGRectMake(0, 0, JAScreenW, JAScreenH)];
    
    CGFloat margin = 0;
    if (isiPhoneX) margin = 20;
    
    [shareSheet.actionSheetContainerV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shareSheet).offset(JAScreenH - shareSheet.actionSheetContainerV.bounds.size.height - margin);
    }];
    [shareSheet setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:kSASAnimationDuration animations:^{
        [shareSheet layoutIfNeeded];
    }];
    
    return shareSheet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addConstraintOnSubviews];
        
        self.alpha = 0;
        [UIView animateWithDuration:kSASAnimationDuration animations:^{
            self.alpha = 1;
        }];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

- (void)addConstraintOnSubviews {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat actionSheetContainerVH = kSASActionSheetContainerVH;
    if (!self.shareItemArrM.count) actionSheetContainerVH -= (kSASTableViewCellH + kSASMarginSecitonH);
    
    [self.actionSheetContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(JAScreenH);
        make.height.mas_equalTo(actionSheetContainerVH);
    }];
    
    [self layoutIfNeeded];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    if (self.shareItemArrM.count) count += 1;
    if (self.funcItemArrM.count) count += 1;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTShareActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:GTShareActionSheetCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.shareItemArrM.count) {
            [cell configWithItemArray:self.shareItemArrM];
        } else {
            [cell configWithItemArray:self.funcItemArrM];
        }
    } else if (indexPath.section == 1) {
        [cell configWithItemArray:self.funcItemArrM];
    }
    JAWeakSelf;
    cell.clickItemBlock = ^(GTShareItem *item) {
        if (weakSelf.clickShareItemBlock) {
            weakSelf.clickShareItemBlock(item);
            [weakSelf dismissSheet];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSASTableViewCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        if (tableView.numberOfSections == 1) {
            return 0.01;
        }
        return kSASMarginSecitonH;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - private
- (void)dismissSheet {
    
    [self.actionSheetContainerV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(JAScreenH);
    }];
    
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:kSASAnimationDuration animations:^{
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:kSASAnimationDuration animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
    
    
}

#pragma mark - getter & setter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSheet)];
        [_bgView addGestureRecognizer:tap];
        
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIView *)actionSheetContainerV {
    if (!_actionSheetContainerV) {
        _actionSheetContainerV = [[UIView alloc] init];
        _actionSheetContainerV.backgroundColor = [UIColor whiteColor];
        
        //subview layout
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_actionSheetContainerV).offset(kSASMargin);
            make.left.right.equalTo(_actionSheetContainerV);
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_actionSheetContainerV).offset(kSASTitleSectionH);
            make.left.right.equalTo(_actionSheetContainerV);
            make.height.mas_equalTo(kSASTableViewH);
        }];
        
        [self.footerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_actionSheetContainerV);
            make.height.mas_equalTo(kSASFooterH);
        }];
        
        [self.descLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.footerV.mas_top).offset(-kSASMargin);
            make.left.right.equalTo(_actionSheetContainerV);
        }];
        
        [self addSubview:_actionSheetContainerV];
    }
    
    return _actionSheetContainerV;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"分享到";
        _titleLB.textColor = [UIColor color9999];
        _titleLB.font = [UIFont fontMedium14];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        [self.actionSheetContainerV addSubview:_titleLB];
    }
    return _titleLB;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        
        //register cell
        [_tableView registerClass:[GTShareActionSheetCell class] forCellReuseIdentifier:GTShareActionSheetCellID];
        
        [_actionSheetContainerV addSubview:_tableView];
    }
    return _tableView;
}

- (UILabel *)descLB {
    if (!_descLB) {
        _descLB = [[UILabel alloc] init];
        _descLB.text = @"此网页由www.utopa.cn提供";
        _descLB.textColor = [UIColor color9999];;
        _descLB.font = [UIFont fontMedium12];
        _descLB.textAlignment = NSTextAlignmentCenter;
        [self.actionSheetContainerV addSubview:_descLB];
    }
    return _descLB;
}

- (UIView *)footerV {
    if (!_footerV) {
        _footerV = [[UIView alloc] init];
        [self.actionSheetContainerV addSubview:_footerV];
        
        //layou subview
        [self.marginV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_footerV);
            make.height.mas_equalTo(kSASMargin);
        }];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.marginV.mas_bottom);
            make.left.right.bottom.equalTo(_footerV);
        }];
    }
    return _footerV;
}

- (UIView *)marginV {
    if (!_marginV) {
        _marginV = [[UIView alloc] init];
        _marginV.backgroundColor = [UIColor colorF6F6F6];
        
        [self.footerV addSubview:_marginV];
    }
    return _marginV;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:JARGBA(0, 118, 255, 1) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontMedium16];
        [_cancelBtn addTarget:self action:@selector(dismissSheet) forControlEvents:UIControlEventTouchUpInside];
        [self.footerV addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (NSMutableArray *)shareItemArrM {
    if (!_shareItemArrM) {
        _shareItemArrM = [NSMutableArray arrayWithCapacity:1];
        
        BOOL hadInstalledWeixin = YES;//[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
        BOOL hadInstalledQQ = YES;//[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
        BOOL hadInstalledSina = YES;//[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibosso://"]];
        
        if (hadInstalledQQ) {
            GTShareItem *item1 = [[GTShareItem alloc] init];
            item1.imgName = @"general_qq";
            item1.name = @"QQ";
            item1.itemType = GTShareItemTypeQQ;
            [_shareItemArrM addObject:item1];
        }
        
        if (hadInstalledWeixin) {
            GTShareItem *item1 = [[GTShareItem alloc] init];
            item1.imgName = @"general_weixin";
            item1.name = @"微信好友";
            item1.itemType = GTShareItemTypeWeChatFriend;
            [_shareItemArrM addObject:item1];
            
            GTShareItem *item2 = [[GTShareItem alloc] init];
            item2.imgName = @"general_pengyouquan";
            item2.name = @"朋友圈";
            item2.itemType = GTShareItemTypeWeChatCircle;
            [_shareItemArrM addObject:item2];
        }
        
        if (hadInstalledSina) {
            GTShareItem *item1 = [[GTShareItem alloc] init];
            item1.imgName = @"general_weibo";
            item1.name = @"微博";
            item1.itemType = GTShareItemTypeWeiBo;
            [_shareItemArrM addObject:item1];
        }
        
    }
    return _shareItemArrM;
}

- (NSMutableArray *)funcItemArrM {
    if (!_funcItemArrM) {
        _funcItemArrM = [NSMutableArray arrayWithCapacity:1];
        
        GTShareItem *item1 = [[GTShareItem alloc] init];
        item1.imgName = @"general_shuaxin";
        item1.name = @"刷新";
        item1.itemType = GTShareItemTypeRefresh;
        [_funcItemArrM addObject:item1];
        
        GTShareItem *item2 = [[GTShareItem alloc] init];
        item2.imgName = @"general_copylink";
        item2.name = @"复制链接";
        item2.itemType = GTShareItemTypeCopyLink;
        [_funcItemArrM addObject:item2];
        
    }
    return _funcItemArrM;
}

@end
