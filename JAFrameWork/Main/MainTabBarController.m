//
//  MainTabBarController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/5.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "MainTabBarController.h"
//vc
#import "JABaseNavigationController.h"
//subRootVC
#import "FirstController.h"
#import "SecondController.h"
#import "ThirdController.h"
#import "FourthController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (instancetype)init {
    if (self = [super init]) {
        [self setUpSubControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)setUpSubControllers {
    //第一
     JABaseNavigationController *recommendNav = [[JABaseNavigationController alloc] initWithRootViewController:[[FirstController alloc] init]];
    recommendNav.tabBarItem = [self tabBarItemWithTitle:@"推荐" image:@"home_tab_icon_discover_n" selectedImage:@"home_tab_icon_discover_s"];
    
    //
    JABaseNavigationController *discoveryNav = [[JABaseNavigationController alloc] initWithRootViewController:[[SecondController alloc] init]];
    discoveryNav.tabBarItem = [self tabBarItemWithTitle:@"发现" image:@"home_tab_icon_menber_n" selectedImage:@"home_tab_icon_menber_s"];
    
    //
    JABaseNavigationController *depositNav = [[JABaseNavigationController alloc] initWithRootViewController:[[ThirdController alloc] init]];
    depositNav.tabBarItem = [self tabBarItemWithTitle:@"充值" image:@"home_tab_icon_recharge_n" selectedImage:@"home_tab_icon_recharge_s"];
    
    //
    JABaseNavigationController *memberNav = [[JABaseNavigationController alloc] initWithRootViewController:[[FourthController alloc] init]];
    memberNav.tabBarItem = [self tabBarItemWithTitle:@"会员" image:@"home_tab_icon_recommendation_n" selectedImage:@"home_tab_icon_recommendation_s"];
    
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
