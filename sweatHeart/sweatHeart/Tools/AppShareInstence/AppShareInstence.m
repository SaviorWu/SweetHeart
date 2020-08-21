//
//  AppShareInstence.m
//  ALD
//
//  Created by friend on 2019/8/26.
//  Copyright © 2019 friend. All rights reserved.
//

#import "AppShareInstence.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSBundle+JTHelper.h"
@implementation AppShareInstence
+(AppShareInstence*)shareInstance{
    static AppShareInstence* sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    return sharedInstance;
}
//+ (NSString *)hmacSHA256WithSecret:(NSString *)secret content:(NSString *)content
//{
//    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [content cStringUsingEncoding:NSUTF8StringEncoding];// 有可能有中文 所以用NSUTF8StringEncoding -> NSASCIIStringEncoding
//    unsigned char cHMAC[CC_SHA512_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
//    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
//    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
//    for (int i = 0; i < HMACData.length; ++i){
//        [HMAC appendFormat:@"%02x", buffer[i]];
//    }
//
//    return HMAC;
//}
//+(NSString*)stringWithDict:(NSDictionary*)dict{
//    NSArray*keys = [dict allKeys];
//    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
//        return[obj1 compare:obj2 options:NSNumericSearch];//正序
//    }];
//    NSString*str =@"";
//    for(NSString*key in sortedArray) {
//        id value = [dict objectForKey:key];
//        if([value isKindOfClass:[NSDictionary class]]) {
//            value = [self stringWithDict:value];
//        }
//        if([str length] !=0) {
//            str = [str stringByAppendingString:@"&"];
//        }
//        str = [str stringByAppendingFormat:@"%@=%@",key,value];
//    }
//    return str;
//}
//+ (NSString*)getDateTime:(NSString*)time{
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
//    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
//    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString* currentTimeString = [dateformatter stringFromDate:date];
//    return currentTimeString;
//}
@end
