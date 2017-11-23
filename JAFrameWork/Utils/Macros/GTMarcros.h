//
//  GTMarcros.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/23.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#ifndef GTMarcros_h
#define GTMarcros_h

//颜色
#define kRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kColor_333333       [UIColor colorWithHexString:@"333333"]
#define kColor_666666       [UIColor colorWithHexString:@"666666"]
#define kColor_999999       [UIColor colorWithHexString:@"999999"]

#define kColor_cccccc       [UIColor colorWithHexString:@"cccccc"]
#define kColor_eeeeee       [UIColor colorWithHexString:@"eeeeee"]
#define kColor_f6f6f6       [UIColor colorWithHexString:@"f6f6f6"]


#define kColor_ff4a2a       [UIColor colorWithHexString:@"ff4a2a"]
#define kColor_ff0000       [UIColor colorWithHexString:@"ff0000"]
#define kColor_fc694e       [UIColor colorWithHexString:@"fc694e"]

#define kColor_53c411       [UIColor colorWithHexString:@"53c411"]
#define kColor_ffd600       [UIColor colorWithHexString:@"ffd600"]
#define kColor_fff5df       [UIColor colorWithHexString:@"fff5df"]


//字体 字号
#define kFontSize(a)                            [UIFont systemFontOfSize:a]
#define kFontBoldSize(a)                        [UIFont boldSystemFontOfSize:a]
#define kFontPingFangLightSize(a)               [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:10.0]
#define kFontForIPhoneVSize(a,b)                kUI_IPHONE5 ?kFontSize(a) :kFontSize(b)



#define kFont_Regular_24                        [UIFont systemFontOfSize:24]
#define kFont_Medium_24                         [UIFont boldSystemFontOfSize:24]
//#define kFontPingFangLightUltraBigSize          [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:24]

#define kFont_Regular_18                        [UIFont systemFontOfSize:18]
#define kFont_Medium_18                         [UIFont boldSystemFontOfSize:18]
//#define kFontPingFangLightRegularBigSize        [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:18]

#define kFont_Regular_16                        [UIFont systemFontOfSize:16]
#define kFont_Medium_16                         [UIFont boldSystemFontOfSize:16]
//#define kFontPingFangLightMediumBigSize         [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:16];

#define kFont_Regular_14                        [UIFont systemFontOfSize:14]
#define kFont_Medium_14                         [UIFont boldSystemFontOfSize:14]
//#define kFontPingFangLightThinBigSize           [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:14];

#define kFont_Regular_12                        [UIFont systemFontOfSize:12]
#define kFont_Medium_12                         [UIFont boldSystemFontOfSize:12]
//#define kFontPingFangLightThinSmallSize         [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:12.0]


#define kFont_Regular_10                        [UIFont systemFontOfSize:10]
#define kFont_Medium_10                         [UIFont boldSystemFontOfSize:10]
//#define kFontPingFangLightMediumSmallSize       [UIFont fontPingFangSCType:LeeFontPingFangSCTypeUltralight withFontSize:10]


#endif /* GTMarcros_h */
