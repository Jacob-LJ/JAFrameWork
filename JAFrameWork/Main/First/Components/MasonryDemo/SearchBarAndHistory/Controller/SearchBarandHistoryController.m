//
//  SearchBarandHistoryController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/11.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "SearchBarandHistoryController.h"
#import "SearchSelectionAndHistoryView.h"

@interface SearchBarandHistoryController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *searchContainerV;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, assign) CGFloat searchContainerVH;
@property (nonatomic, strong) SearchSelectionAndHistoryView *selectionView;

@end

@implementation SearchBarandHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpNav];
    
    [self setUpSelectionView];
}

- (void)setUpInit {
    self.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    //这里的写64和88感觉不太合适，是否有更好的处理方法？动态适配的 因为还有这个情况，http://blog.csdn.net/youshaoduo/article/details/78040558
    CGFloat height = 64;
    if (isiPhoneX) {
        height = 88;
    }
    self.searchContainerVH = height;
}


- (void)setUpNav {
    
    [self.searchContainerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.searchContainerVH);
    }];
}

- (void)setUpSelectionView {
    
    [self.selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.searchContainerVH);
        make.left.right.bottom.equalTo(self.view);
    }];
}


#pragma mark - private
- (void)cancelBtnClick {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - getter & setter
- (UIView *)searchContainerV {
    if (!_searchContainerV) {
        _searchContainerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _searchContainerV.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_searchContainerV];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchContainerV).offset(12);
            make.right.equalTo(_searchContainerV).offset(-56);
            make.bottom.equalTo(_searchContainerV).offset(-7);
            make.height.mas_equalTo(30);
        }];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_searchContainerV);
            make.left.equalTo(self.textField.mas_right);
            make.centerY.equalTo(self.textField);
            make.height.equalTo(self.textField);
        }];
    }
    
    return _searchContainerV;
}


- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor colorEEEE];
        _textField.font = [UIFont fontRegular14];
        _textField.placeholder = @"请输入搜索关键字";
        _textField.layer.cornerRadius = 4;
        _textField.clipsToBounds = YES;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 28, 30)];
        [leftView addSubview:leftImageV];
        leftImageV.contentMode = UIViewContentModeCenter;
        leftImageV.image = [UIImage imageNamed:@"search_search"];
        _textField.leftView = leftView;
        
        [self.searchContainerV addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorFF4A2A] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontRegular16];
        _cancelBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.searchContainerV addSubview:_cancelBtn];
    }
    return _cancelBtn;
}


#pragma mark  history and seletion
- (SearchSelectionAndHistoryView *)selectionView {
    if (!_selectionView) {
        _selectionView = [[SearchSelectionAndHistoryView alloc] init];
        [self.view addSubview:_selectionView];
    }
    return _selectionView;
}

@end
