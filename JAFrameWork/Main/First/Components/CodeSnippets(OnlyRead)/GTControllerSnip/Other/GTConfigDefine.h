//
//  ConfigDefine.h
//  FrameWork
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 Limiao. All rights reserved.
//

#ifndef ConfigDefine_h
#define ConfigDefine_h

#define kDefineWeakSelf  __weak typeof(self) weakSelf = self  //block情况下的 需要弱指针

#define kControllerEndEditing    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]

//适配 350 375 414       568 667 736
#define kAutoLayoutWidth(width)   width*((kUIScreenWidth)/375)
#define kAutoLayoutHeigth(height) height*((kUIScreenHeight)/667)

/**
 字符串是否为空
 @param str NSString 类型 和 子类
 @return  BOOL类型 YES or NO
 */
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str isEqualToString:@"(null)"] ||[str length] < 1 ? YES : NO )

// 字符串判空 如果为空返回@“”
#define kStringNullToempty(str)  kStringIsEmpty(str)? @"": str
#define kStringNullToReplaceStr(str,replaceStr)  kStringIsEmpty(str)? replaceStr:str

/**
 数组是否为空
 @param array NSArray 类型 和 子类
 @return BOOL类型 YES or NO
 */
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

/**
 字典是否为空
 @param dic NSDictionary 类型 和子类
 @return BOOL类型 YES or NO
 */
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)

/**
 是否是空对象

 @param _object NSObject 类型
 @return BOOL类型 YES or NO
 */
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//获取屏幕宽度与高度
#define kUIScreenWidth ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define kUIScreenHeight ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define kUIScreenSize ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreenmainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

#define kUIScreenBounds [UIScreen mainScreen].bounds


//判断是否是 iPhone 的屏幕尺寸
#define kSCREEN_MAX_LENGTH (MAX(kUIScreenWidth, kUIScreenHeight))
#define kSCREEN_MIN_LENGTH (MIN(kUIScreenWidth, kUIScreenHeight))


//获取状态栏宽度
#define kUIStatusBarWidth  [[UIApplication sharedApplication] statusBarFrame].size.width
//获取状态栏高度
#define kUIStatusBarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
//获取导航栏宽度
#define kUINavigationBarWidth  self.navigationController.navigationBar.frame.size.width
//获取导航栏高度
#define kUINavigationBarHeight self.navigationController.navigationBar.frame.size.height

//一些缩写
#define kApplication           [UIApplication sharedApplication]
#define kAPPKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate           [UIApplication sharedApplication].delegate
#define kAppNotificationCenter [NSNotificationCenter defaultCenter]
#define kAppRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kImgWithFileBundle(str,type)   [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:str ofType:type]]
#define kImgWithName(str)  [UIImage imageNamed:str]


// UserDefaults 操作
#define kUserDefaults                  [NSUserDefaults standardUserDefaults]
#define kUserDefaultsRead(KeyStr)      [kUserDefaults objectForKey:KeyStr]
#define kUserDefaultsWrite(obj,KeyStr) [kUserDefaults setObject:obj forKey:KeyStr]


//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kDeviceSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define kAppCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kDeviceIsiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kDeviceIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath   NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif



//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define kIsDevelopementAPP  YES
#define NSLog(format, ...) printf("[%s] %s [第%d行] \n\t\t\t%s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//
//#define NSLog(format, ...) do {                                                                             \
//                                fprintf(stderr, "<%s : %d> %s\n",                                           \
//                                [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//                                __LINE__, __func__);                                                        \
//                                (NSLog)((format), ##__VA_ARGS__);                                           \
//                                fprintf(stderr, "\n\n\n");                                                  \
//                               } while (0);

#else
#define kIsDevelopementAPP  NO
#define NSLog(format, ...)
#endif



//检测用户版本号
#define kIOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define kIOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define kIOS9_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define kIOS8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kIOS7_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


//判断是否是 iPhone 的屏幕尺寸
//#define kUI_IS_IPHONE             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? YES:NO
//#define kUI_IS_IPHONE5            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0) ? YES:NO
//#define kUI_IS_IPHONE6            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0) ? YES:NO
//#define kUI_IS_IPHONE6PLUS        ((UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)) ? YES:NO // Both orientations



#define kUI_IPHONE             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define kUI_IPHONE5            (kUI_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
#define kUI_IPHONE6            (kUI_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
#define kUI_IPHONE6PLUS        (kUI_IPHONE && kSCREEN_MAX_LENGTH == 736.0) // Both orientations
#define kUI_IPhoneX            (kUI_IPHONE && kSCREEN_MAX_LENGTH >  780.0)
////颜色
//#define kRGBColor(r, g, b)         [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//#define kRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
//#define kRandomColor               KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
//#define kHexColor(HexString)       [UIColor colorWithHexString:HexString]
//#define kHexColorA(HexString,a)    [UIColor colorWithHexString:HexString alpha:a]
//
//
//
////字体 字号
//#define kFontSize(a)               [UIFont systemFontOfSize:a]
//#define kFontBoldSize(a)           [UIFont boldSystemFontOfSize:a]
//#define kFontPingFangLightSize(a)  [UIFont fontWithName:@".PingFang-SC-Light" size:a];

// 注册通知
#define kNOTIFY_ADD(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_noParamsFunc) name:_notifyName object:nil];

// 发送通知
#define kNOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];

// 移除通知
#define kNOTIFY_REMOVE(_notifyName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notifyName object:nil];




#endif /* ConfigDefine_h */
