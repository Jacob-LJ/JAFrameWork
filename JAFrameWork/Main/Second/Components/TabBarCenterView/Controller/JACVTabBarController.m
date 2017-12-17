//
//  JACVTabBarController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/12/17.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JACVTabBarController.h"
#import "JABaseNavigationController.h"
//view
#import "JACVTabBar.h"

@interface JACVTabBarController ()

@end

@implementation JACVTabBarController

+ (instancetype)shareInstance {
    
    static JACVTabBarController *tabbarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarC = [[JACVTabBarController alloc] init];
    });
    return tabbarC;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setUpSubControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:[[JACVTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setUpSubControllers {
    //第一
    UIViewController *first = [[UIViewController alloc] init];
    first.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    JABaseNavigationController *recommendNav = [[JABaseNavigationController alloc] initWithRootViewController:first];
    recommendNav.tabBarItem = [self tabBarItemWithTitle:@"第一" image:@"home_tab_icon_discover_n" selectedImage:@"home_tab_icon_discover_s"];
    
    //
    UIViewController *second = [[UIViewController alloc] init];
    second.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    JABaseNavigationController *discoveryNav = [[JABaseNavigationController alloc] initWithRootViewController:second];
    discoveryNav.tabBarItem = [self tabBarItemWithTitle:@"第二" image:@"home_tab_icon_menber_n" selectedImage:@"home_tab_icon_menber_s"];
    
    //
    UIViewController *third = [[UIViewController alloc] init];
    third.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    JABaseNavigationController *depositNav = [[JABaseNavigationController alloc] initWithRootViewController:third];
    depositNav.tabBarItem = [self tabBarItemWithTitle:@"第三" image:@"home_tab_icon_recharge_n" selectedImage:@"home_tab_icon_recharge_s"];
    
    //
    UIViewController *fourth = [[UIViewController alloc] init];
    fourth.view.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    JABaseNavigationController *memberNav = [[JABaseNavigationController alloc] initWithRootViewController:fourth];
    memberNav.tabBarItem = [self tabBarItemWithTitle:@"第四" image:@"home_tab_icon_recommendation_n" selectedImage:@"home_tab_icon_recommendation_s"];
    
    self.viewControllers = @[recommendNav, discoveryNav, depositNav, memberNav];
}

- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName:JARGBA(252, 51, 77, 1),
                                   }
                        forState:UIControlStateSelected];
    
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName:JARGBA(77, 77, 77, 1),
                                   }
                        forState:UIControlStateNormal];
    return item;
    
}

@end
