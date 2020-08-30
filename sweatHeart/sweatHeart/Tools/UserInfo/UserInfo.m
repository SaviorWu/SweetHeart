//
//  UserInfo.m
//  ALD
//
//  Created by friend on 2019/8/28.
//  Copyright © 2019 friend. All rights reserved.
//

#import "UserInfo.h"
#import "AppDelegate.h"
#import "PersonalModel.h"
@implementation UserInfo
+ (UserInfo*)shareInstance{
    static UserInfo* sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
        sharedInstance.userModel = [[UserInfoModel alloc] init];
    });
    return sharedInstance;
}

+ (void)userLogout{
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault removeObjectForKey:@"token"];
    [userdefault removeObjectForKey:@"uid"];
    [UserInfo shareInstance].userModel.token = @"";
    [UserInfo shareInstance].userModel.uid = @"";
    [((AppDelegate *)([UIApplication sharedApplication].delegate)) showLoginPage];
}
@end
