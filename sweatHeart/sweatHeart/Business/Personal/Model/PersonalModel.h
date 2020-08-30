//
//  PersonalModel.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/28.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* age;
@property (nonatomic, strong) NSString* introduce_status;
@property (nonatomic, strong) NSString* header;
@property (nonatomic, strong) NSString* nick_status;
@property (nonatomic, strong) NSString* login_time;
@property (nonatomic, strong) NSString* login_status;
@property (nonatomic, strong) NSString* fans;
@property (nonatomic, strong) NSString* sex;
@property (nonatomic, strong) NSString* work;
@property (nonatomic, strong) NSString* introduce;
@property (nonatomic, strong) NSString* Alength;
@property (nonatomic, strong) NSString* vip;
@property (nonatomic, strong) NSString* audio;
@property (nonatomic, strong) NSString* nickname;
@property (nonatomic, strong) NSString* interest;
@property (nonatomic, strong) NSString* is_authen;
@property (nonatomic, strong) NSString* xaxis;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* allmoney;
@property (nonatomic, strong) NSString* yaxis;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* distance;
@property (nonatomic, strong) NSString* birthday;

@end


@interface NewsData : NSObject
@property (nonatomic, strong) NSString* media_type;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* media;

@end

@interface Anchor : NSObject
@property (nonatomic, strong) NSString* room_id;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* up_time;
@property (nonatomic, strong) NSString* reson;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* anchor_status;
@property (nonatomic, strong) NSString* pingtai;
@property (nonatomic, strong) NSString* check_time;
@end


@interface XinYuan : NSObject
@property (nonatomic, strong) NSString* create_time;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* xinyuan_status;
@property (nonatomic, strong) NSString* yuan3;
@property (nonatomic, strong) NSString* yuan2;
@property (nonatomic, strong) NSString* yuan1;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* qingmi3;
@property (nonatomic, strong) NSString* qingmi2;
@property (nonatomic, strong) NSString* status;

@end

@interface Media : NSObject

@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSString* media_status;
@property (nonatomic, strong) NSString* thumb;
@property (nonatomic, strong) NSString* id;
@end
NS_ASSUME_NONNULL_BEGIN

@interface PersonalModel : NSObject
@property (nonatomic,strong) UserData* userdata;
@property (nonatomic, strong) NewsData* newsData;
@property (nonatomic, strong) Anchor* anchor;
@property (nonatomic, strong) XinYuan* xinyuan;
@property (nonatomic, strong) Media* media;

@end

NS_ASSUME_NONNULL_END
