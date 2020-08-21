//
//  JTLanguageHelper.m
//  UKEX
//
//  Created by Playboy on 2018/10/15.
//  Copyright © 2018 funky. All rights reserved.
//

#import "JTLanguageHelper.h"

static NSString * const kUserLanguageKey = @"UserLanguageKey";
#define kUserDefaults [NSUserDefaults standardUserDefaults]
@implementation JTLanguageHelper

+ (void)setUserLanguage:(NSString *)userLanguage
{
    //跟随手机系统
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    //用户自定义
    [kUserDefaults setValue:userLanguage forKey:kUserLanguageKey];
    [kUserDefaults setValue:@[userLanguage] forKey:@"AppleLanguages"];
    [kUserDefaults synchronize];
}

+ (NSString *)userLanguage
{
    return [kUserDefaults valueForKey:kUserLanguageKey];
}

/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
    [kUserDefaults removeObjectForKey:kUserLanguageKey];
    [kUserDefaults setValue:nil forKey:@"AppleLanguages"];
    [kUserDefaults synchronize];
}

@end
