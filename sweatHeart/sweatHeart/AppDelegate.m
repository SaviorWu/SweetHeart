//
//  AppDelegate.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/21.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabbar.h"
#import "Marco.h"
#import "LoginViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    [UserInfo shareInstance].userModel.token = [userdefault objectForKey:@"token"];
    [UserInfo shareInstance].userModel.uid = [userdefault objectForKey:@"uid"];
    if ([UserInfo shareInstance].userModel.token.length == 0 ||
        [UserInfo shareInstance].userModel.uid.length == 0) {
        [self showLoginPage];
    }
    else{
        [self showHomePage];
    }
    
    [self configIQKeyboard];
    return YES;
}
- (void)showLoginPage
{
    LoginViewController* login = [[LoginViewController alloc] init];
    UINavigationController * loginPageNavigationController = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = loginPageNavigationController;
}
- (void)showHomePage{
    MyTabbar * TabBarControllerConfig = [[MyTabbar alloc] init];
    TabBarControllerConfig.tabBarController.delegate = self;
    self.window.rootViewController = TabBarControllerConfig.tabBarController;
}
- (void)configIQKeyboard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    keyboardManager.keyboardDistanceFromTextField = 150.0f;
    [keyboardManager.toolbarPreviousNextAllowedClasses addObject:[UIScrollView class]];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    UINavigationController* navigationViewContrller = (UINavigationController*)viewController;
//    if([navigationViewContrller.viewControllers[0] isKindOfClass:[TokenConsumptionViewController class]]){
//        [navigationViewContrller.viewControllers[0] showHint:NSLocalizedString(@"敬请期待", nil)];
//        return NO;
//    }else{
        return YES;
//    }
}

@end
