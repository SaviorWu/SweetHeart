//
//  NSBundle+JTHelper.m
//  UKEX
//
//  Created by Playboy on 2018/10/15.
//  Copyright © 2018 funky. All rights reserved.
//

#import "NSBundle+JTHelper.h"
#import "JTLanguageHelper.h"

@interface JTBundle : NSBundle

@end

@implementation NSBundle (JTHelper)
//+ (BOOL)isChineseLanguage
//{
//    NSString *currentLanguage = [self currentLanguage];
//    if ([currentLanguage hasPrefix:@"zh-Hans"]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

+ (NSString *)currentLanguage
{
    return [JTLanguageHelper userLanguage] ? : [NSLocale preferredLanguages].firstObject;
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类UWBundle，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
        object_setClass([NSBundle mainBundle], [JTBundle class]);
    });
}

@end


@implementation JTBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    if ([JTBundle uw_mainBundle]) {
        return [[JTBundle uw_mainBundle] localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSBundle *)uw_mainBundle
{
    if ([NSBundle currentLanguage].length) {
        NSString* loadFileName = [NSBundle currentLanguage];
        if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hant-HK"]) {
            loadFileName = @"zh-HK";
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:loadFileName ofType:@"lproj"];
        if (path.length) {
            return [NSBundle bundleWithPath:path];
        }
    }
    return nil;
}
@end
