//
//  UINavigationController+push.m
//  tabbar
//
//  Created by FriendWu on 2019/8/1.
//  Copyright © 2019 FriendWu. All rights reserved.
//

#import "UINavigationController+pushAnimotion.h"


@implementation UINavigationController(pushAnimotion)

- (void)pushViewController:(UIViewController *)viewController{
//    viewController.view.backgroundColor = [UIColor whiteColor];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.4f;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromRight;
//    [self.view.layer addAnimation:transition forKey:kCATransition];
    
    if (self.viewControllers.count > 0) {
        self.tabBarController.tabBar.hidden = YES;
//        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        self.tabBarController.tabBar.hidden = NO;
//        viewController.hidesBottomBarWhenPushed = NO;
    }
    [self pushViewController:viewController animated:YES];
}
- (void)popViewController{
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.4f;
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromLeft;
//    [self.view.layer addAnimation:transition forKey:kCATransition];
    
    [self popViewControllerAnimated:YES];
}

@end
