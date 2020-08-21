//
//  MyTabbar.m
//  tabbar
//
//  Created by FriendWu on 2019/7/31.
//  Copyright © 2019 FriendWu. All rights reserved.
//

#import "MyTabbar.h"
#import "HomePageViewController.h"
#import "PersonalCenterViewController.h"
#import "RegistViewController.h"
@implementation MyTabbar
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        HomePageViewController * homePageViewController = [[HomePageViewController alloc] init];
        UINavigationController * homePageNavigationController = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
        
        
        PersonalCenterViewController * personalCenterViewController = [[PersonalCenterViewController alloc] init];
        UINavigationController * personalCenterNavigationController = [[UINavigationController alloc] initWithRootViewController:personalCenterViewController];
        
        NSArray * tabBarItemsAttributes = [self tabBarItemsAttributes];
        NSArray * viewControllers       = @[homePageNavigationController,
                                            personalCenterNavigationController];
        
        CYLTabBarController * tabBarController = [[CYLTabBarController alloc] init];
        
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
        tabBarController.viewControllers = viewControllers;
        [self customizeTabBarAppearance];
        _tabBarController = tabBarController;
    }
    
    return _tabBarController;
}


- (NSArray *)tabBarItemsAttributes {
    NSDictionary * tabBarItem1Attribute = @{
                                            CYLTabBarItemTitle : NSLocalizedString(@"首页", nil),
                                            CYLTabBarItemImage : @"tab_home_n_icon",
                                            CYLTabBarItemSelectedImage : @"tab_home_s_icon",
                                            };
    NSDictionary * tabBarItem5Attribute = @{
                                            CYLTabBarItemTitle : NSLocalizedString(@"个人中心",nil),
                                            CYLTabBarItemImage : @"tab_mypage_n_icon",
                                            CYLTabBarItemSelectedImage : @"tab_mypage_s_icon"
                                            };
    NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute,
                                       tabBarItem5Attribute];
    
    return tarBarItemsAttrbutes;
}
- (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRGB:0x666666];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = APP_COLOR;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end
