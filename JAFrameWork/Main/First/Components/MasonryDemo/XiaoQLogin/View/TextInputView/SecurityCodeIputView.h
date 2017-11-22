//
//  SecurityCodeIputView.h
//  XQCity
//
//  Created by Jacob on 2017/11/21.
//  Copyright © 2017年 GTLand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityCodeIputView : UIView

@property (nonatomic, copy) NSString *leftTile;;
@property (nonatomic, copy) NSString *leftImageName;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy) void(^textChangedBlock)(NSString *text);

@property (nonatomic, assign) BOOL enableGetBtn;
@property (nonatomic, assign) CGFloat textFieldLeftMargin;

@end
