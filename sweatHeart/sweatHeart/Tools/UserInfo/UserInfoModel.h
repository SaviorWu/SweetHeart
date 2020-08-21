//
//  UserInfoModel.h
//  ALD
//
//  Created by friend on 2019/8/28.
//  Copyright © 2019 friend. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* level;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* mcode;
@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* order_nums;
@property (nonatomic, strong) NSString* invit_code;
@property (nonatomic, strong) NSString* auth_status;
@property (nonatomic, strong) NSString* truename;
@property (nonatomic, strong) NSString* idcard;
@property (nonatomic, strong) NSString* idcard_no;
@property (nonatomic, strong) NSString* auth_fail_reason;
@property (nonatomic, strong) NSString* status; //     状态: 0冻结 1正常

@end

NS_ASSUME_NONNULL_END
