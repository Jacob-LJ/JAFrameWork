//
//  ApplicationService.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationService : NSObject


#pragma mark - Application Info
//如下不添加前缀是因为方便项目间的互用

/// Application's Bundle Name (show in SpringBoard).
+ (NSString *)appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
+ (NSString *)appBundleID;

/// Application's Version.  e.g. "1.2.0"
+ (NSString *)appVersion;

/// Application's Build number. e.g. "123"
+ (NSString *)appBuildVersion;

/// 系统名字
+ (NSString *)getCurrentDeviceSystemName;

/// 设备的系统号
+ (NSString *)getCurrentDeviceSystemVersion;


#pragma mark -

@end
