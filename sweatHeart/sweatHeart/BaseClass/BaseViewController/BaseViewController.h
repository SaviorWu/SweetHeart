//
//  BaseViewController.h
//  ALD
//
//  Created by friend on 2019/8/13.
//  Copyright © 2019 friend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HUD.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIView* vwNavigation;
- (void)hiddenBackBtn:(BOOL)bHidden;
- (void)addNavigationView;
- (BOOL)isIphoneX;
@end

NS_ASSUME_NONNULL_END
