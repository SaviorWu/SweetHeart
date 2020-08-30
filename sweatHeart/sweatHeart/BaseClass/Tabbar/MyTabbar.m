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
#import "MessageViewController.h"
#import "OrderViewController.h"
@implementation MyTabbar
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        HomePageViewController * homePageViewController = [[HomePageViewController alloc] init];
        UINavigationController * homePageNavigationController = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
        
        MessageViewController * messagePageViewController = [[MessageViewController alloc] init];
        UINavigationController * messageNavigationController = [[UINavigationController alloc] initWithRootViewController:messagePageViewController];
        
        OrderViewController * orderViewController = [[OrderViewController alloc] init];
        UINavigationController * orderNavigationController = [[UINavigationController alloc] initWithRootViewController:orderViewController];
        
        PersonalCenterViewController * personalCenterViewController = [[PersonalCenterViewController alloc] init];
        UINavigationController * personalCenterNavigationController = [[UINavigationController alloc] initWithRootViewController:personalCenterViewController];
        
        NSArray * tabBarItemsAttributes = [self tabBarItemsAttributes];
        NSArray * viewControllers       = @[homePageNavigationController,
                                            messageNavigationController,
                                            orderNavigationController,
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
    NSDictionary * tabBarItem1Attribute = @{CYLTabBarItemTitle : @"首页",
                                            CYLTabBarItemImage : @"homepage_unselect",
                                            CYLTabBarItemSelectedImage : @"homepage_select",
    };
    NSDictionary * tabBarItem2Attribute = @{
        CYLTabBarItemTitle : @"消息",
        CYLTabBarItemImage : @"message_unselect",
        CYLTabBarItemSelectedImage : @"message_select"
    };
    NSDictionary * tabBarItem3Attribute = @{
        CYLTabBarItemTitle : @"订单",
        CYLTabBarItemImage : @"message_unselect",
        CYLTabBarItemSelectedImage : @"message_select"
    };
    NSDictionary * tabBarItem4Attribute = @{
        CYLTabBarItemTitle : @"我的",
        CYLTabBarItemImage : @"personalcenter_unselect",
        CYLTabBarItemSelectedImage : @"personalcenter_select"
    };
    NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute,
                                       tabBarItem2Attribute,
                                       tabBarItem3Attribute,
                                       tabBarItem4Attribute];
    
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
    selectedAttrs[NSForegroundColorAttributeName] = BLUE_LEFT;
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end
