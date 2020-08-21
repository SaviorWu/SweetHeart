//
//  AppShareInstence.h
//  ALD
//
//  Created by friend on 2019/8/26.
//  Copyright © 2019 friend. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppShareInstence : NSObject
+ (AppShareInstence*)shareInstance;
//+ (NSString*)hmacSHA256WithSecret:(NSString *)secret content:(NSString *)content;
//+ (NSString*)stringWithDict:(NSDictionary*)dict;
//+ (NSString*)getDateTime:(NSString*)time;
@property (nonatomic, strong) NSString* language; //语言
@property (nonatomic, strong) NSString* token;  // 登录token
@property (nonatomic, strong) NSString* userPhone;  // 登录token
@property (nonatomic, strong) NSString* Convention; // 接口与app直接约定值
@property (nonatomic, strong) NSString* sign; // 签名
@end

NS_ASSUME_NONNULL_END
