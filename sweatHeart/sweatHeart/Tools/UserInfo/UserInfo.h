//
//  UserInfo.h
//  ALD
//
//  Created by friend on 2019/8/28.
//  Copyright © 2019 friend. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "PersonalModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
+ (UserInfo*)shareInstance;
+ (void)userLogout;
@property (nonatomic, strong) UserInfoModel* userModel;
@end

NS_ASSUME_NONNULL_END
