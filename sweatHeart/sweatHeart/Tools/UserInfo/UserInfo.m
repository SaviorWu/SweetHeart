//
//  UserInfo.m
//  ALD
//
//  Created by friend on 2019/8/28.
//  Copyright © 2019 friend. All rights reserved.
//

#import "UserInfo.h"
#import "AppDelegate.h"
@implementation UserInfo
+ (UserInfo*)shareInstance{
    static UserInfo* sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
        sharedInstance.model = [[UserInfoModel alloc] init];
    });
    return sharedInstance;
}
+ (void)userLogout{
//    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//    [userdefault removeObjectForKey:@"token"];
//    [userdefault removeObjectForKey:@"ID"];
//    [AppShareInstence shareInstance].token = @"";
//    [AppShareInstence shareInstance].ID = @"";
//    [((AppDelegate *)([UIApplication sharedApplication].delegate)) showLogin];
}
@end
