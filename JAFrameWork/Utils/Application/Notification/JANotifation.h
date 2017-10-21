//
//  JANotifation.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JANotifation : NSObject

#pragma mark - User Login
extern NSString *const JANoti_UserDidLogin;//用户登陆成功通知
extern NSString *const JANoti_UserDidLogOut;//用户退出登录通知

#pragma mark - City Change Login
extern NSString *const JANoti_CityChanged;//用户切换了城市通知

/*
或者
 
 #pragma mark - 功能模块名称
 extern NSString *const JANoti_功能模块名称(或意思明确的简写)_通知命名;//中文描述
 
*/

@end
