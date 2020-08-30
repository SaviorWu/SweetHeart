//
//  OrderDetailModel.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/30.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailUser : NSObject
@property(nonatomic, strong) NSString* gid;
@property(nonatomic, strong) NSString* sex;
@property(nonatomic, strong) NSString* nickname;
@property(nonatomic, strong) NSString* header;
@property(nonatomic, strong) NSString* age;
@end

@interface OrderDetailOrder : NSObject
@property(nonatomic, strong) NSString* game;
@property(nonatomic, strong) NSString* play_uid;
@property(nonatomic, strong) NSString* get_time;
@property(nonatomic, strong) NSString* serve_start_time;
@property(nonatomic, strong) NSString* remark;
@property(nonatomic, strong) NSString* pay_money;
@property(nonatomic, strong) NSString* serve_time;
@property(nonatomic, strong) NSString* uid;
@property(nonatomic, strong) NSString* id;
@property(nonatomic, strong) NSString* order_type;
@property(nonatomic, strong) NSString* play_price;
@property(nonatomic, strong) NSString* create_time;
@property(nonatomic, strong) NSString* statustxt;
@property(nonatomic, strong) NSString* reads;
@property(nonatomic, strong) NSString* gname;
@property(nonatomic, strong) NSString* play_time;
@property(nonatomic, strong) NSString* pay_time;
@property(nonatomic, strong) NSString* serve_end_time;
@property(nonatomic, strong) NSString* play_type;
@property(nonatomic, strong) NSString* unit;
@property(nonatomic, strong) NSString* play_unit;
@property(nonatomic, strong) NSString* play_round;
@property(nonatomic, strong) NSString* order_num;
@property(nonatomic, strong) NSString* time;
@property(nonatomic, strong) NSString* status;
@end

@interface OrderDetailModel : NSObject
@property (nonatomic, strong) OrderDetailUser* user;
@property (nonatomic, strong) OrderDetailOrder* order;
@end

NS_ASSUME_NONNULL_END
