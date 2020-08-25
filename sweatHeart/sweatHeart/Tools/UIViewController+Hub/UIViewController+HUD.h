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

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
- (void)showHudInView:(UIView *)view;
- (void)showHudInView:(UIView *)view key:(NSString *)key;

//有activity，无文字
- (void)showHud;
//有activity, 有文字
- (void)showHud:(NSString *)key;
//隐藏hud
- (void)hideHud;
- (void)hideHud:(NSString *)key;
- (void)hideAllHud;
- (void)hideAllHudFromSuperView:(UIView *)supView;

@end

@interface NSObject (HUD)

//@property (nonatomic, strong) JTTimeWindow *jbh_window;

//无activity, 有文字

/**
 显示提示信息
 
 @param key 本地语言文件plist中对应的键名称（key）
 */
- (void)showHint:(NSString *)key;

/**
 显示提示信息
 
 @param key 本地语言文件plist中对应的键名称（key）
 @param delay 显示的时间
 */
- (void)showHint:(NSString *)key delay:(float)delay;
/**
 *  显示api提供的信息
 *
 *  @param message 信息内容
 */
-(void)showApiMsg:(NSString *)message;

/**
 显示非本地语言的信息
 
 @param message 提示信息内容
 @param yOffset 提示信息y轴的偏移位置
 */
-(void)showApiMsg:(NSString *)message yOffset:(float)yOffset;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)key yOffset:(float)yOffset;

- (void)showHint:(NSString *)key delay:(float)delay yOffset:(float)yOffset;

-(void)showToast:(NSString *)message isLocal:(BOOL)isLocal delay:(float)delay;

@end
