//
//  UINavigationController+push.h
//  tabbar
//
//  Created by FriendWu on 2019/8/1.
//  Copyright © 2019 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController(pushAnimotion)
- (void)popViewController;
- (void)pushViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
