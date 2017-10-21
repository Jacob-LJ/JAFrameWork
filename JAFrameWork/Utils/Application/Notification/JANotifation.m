//
//  JANotifation.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/21.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JANotifation.h"

@implementation JANotifation

#pragma mark - User Login
NSString *const JANoti_UserDidLogin  = @"JANoti_UserDidLogin";//用户登陆成功通知
NSString *const JANoti_UserDidLogOut = @"JANoti_UserDidLogOut";//用户退出登录通知

#pragma mark - City Change Login
extern NSString *const JANoti_CityChanged;//用户切换了城市通知

@end
