/************************************************************
 
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;



@implementation NSObject (HUD)


- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (void)setJbh_window:(UIWindow *)jbh_window
{
    objc_setAssociatedObject(self, @selector(jbh_window), jbh_window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)jbh_window
{
    return objc_getAssociatedObject(self, @selector(jbh_window));
}


- (void)showHint:(NSString *)key
{
    [self showToast:key isLocal:YES delay:2];
}

- (void)showHint:(NSString *)key delay:(float)delay
{
    [self showToast:key isLocal:YES delay:delay];
}

- (void)showHint:(NSString *)key yOffset:(float)yOffset {
    //显示提示信息
    // 阻止多个提示同时出现
    /**
     修改日志，以前都是在application的window上操作太复杂，现在new一个更加简单
     */
    [self showToast:key isLocal:YES delay:2 yOffset:yOffset];
}

-(void)showHint:(NSString *)key delay:(float)delay yOffset:(float)yOffset{
    
    [self showToast:key isLocal:YES delay:delay yOffset:yOffset];
}

-(void)showApiMsg:(NSString *)message yOffset:(float)yOffset
{
    [self showToast:message isLocal:NO delay:2 yOffset:yOffset];
}

-(void)showApiMsg:(NSString *)message
{
    [self showToast:message isLocal:NO delay:2];
}

-(void)showToast:(NSString *)message isLocal:(BOOL)isLocal delay:(float)delay yOffset:(float)yOffset
{
    if (message.length == 0) {
        return;
    }
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // 需要在主线程执行的代码
    //显示提示信息
    UIWindow *view = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor clearColor];
    NSArray *windows = [[UIApplication sharedApplication] windows] ;
    UIWindow *lastWindow = windows.lastObject;
    view.windowLevel = lastWindow.windowLevel+1;
    [view makeKeyAndVisible];
    view.userInteractionEnabled = NO;
    self.jbh_window = view;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = message;
    hud.detailsLabel.font=[UIFont systemFontOfSize:14];
    hud.margin = 10.f;
    hud.label.font = [UIFont systemFontOfSize:14];
    [hud setOffset:CGPointMake(0, yOffset)];
    hud.minSize = CGSizeMake(137, 70);
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.color = [UIColor colorWithRGB:0xe0e0e0];
    [view setHUD:hud];
    [hud hideAnimated:YES afterDelay:delay];
    [self performSelector:@selector(jbh_hide) withObject:nil afterDelay:delay];
    //    });
    
}

-(void)showToast:(NSString *)message isLocal:(BOOL)isLocal delay:(float)delay
{
    [self showToast:message isLocal:isLocal delay:2 yOffset:0];
}

- (void)jbh_hide
{
    [self.jbh_window resignKeyWindow];
    self.jbh_window = nil;
    if (self.jbh_window.HUD) {
        [self.jbh_window.HUD hideAnimated:YES];
    }
    
    //    [self.win removeFromSuperview];
}


@end

@implementation UIViewController (HUD)

- (void)showHudInView:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.userInteractionEnabled = NO;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHudInView:(UIView *)view key:(NSString *)key{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.userInteractionEnabled = NO;
    HUD.label.text = key;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)showHud
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.userInteractionEnabled = NO;
    [self.view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}


- (void)showHud:(NSString *)key
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.label.text = key;
    HUD.userInteractionEnabled = NO;
    [self.view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
}

- (void)hideHud{
    if ([self HUD]) {
        [[self HUD] hideAnimated:YES];
    }
}

- (void)hideHud:(NSString *)key {
    if ([self HUD]) {
        [self HUD].label.text=key;
        [[self HUD] hideAnimated:YES afterDelay:1.0];
    }
}

- (void)hideAllHudFromSuperView:(UIView *)supView
{
    [MBProgressHUD hideAllHUDsForView:supView animated:NO];
}

- (void)hideAllHud{
    [self hideAllHudFromSuperView:self.view];
}

@end

