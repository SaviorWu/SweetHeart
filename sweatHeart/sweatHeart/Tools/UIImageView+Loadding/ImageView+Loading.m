//
//  ImageView+Loading.m
//  XSF
//
//  Created by duck on 16/10/28.
//  Copyright © 2016年 Xsf Technology Co.,Ltd. All rights reserved.
//

#import "ImageView+Loading.h"
#import "UIImageView+WebCache.h"
NSString *OSS_MARK_STRING = @"x-oss-process=image/resize";

@implementation UIImageView(Loading)

//- (void)LoadImage:(NSString*)url withWidth:(CGFloat)width withHeight:(CGFloat)height
//{
//
//    NSString *str_cut_type = [NSString stringWithFormat:@"%@,m_fill",OSS_MARK_STRING];
//    NSString *cut_params = @"";
//    cut_params = [NSString stringWithFormat:@"%@,w_%d,h_%d",str_cut_type,(int)width,(int)height];
//    if(url && ![url isEqualToString:@""])
//    {
//        NSRange range = [url rangeOfString:@"?"];//判断字符串是否包含
//
//        if (range.length >0)//包含
//        {
//            NSString *pre = [url substringToIndex:range.location + 1];
//
//            NSString *last = [url substringFromIndex:range.location + 1];
//
//
//            url = [NSString stringWithFormat:@"%@%@,%@", pre,cut_params,last];
//        }
//        else//不包含
//        {
//            url = [NSString stringWithFormat:@"%@?%@", url, cut_params];
//        }
//    }
//
//    UIImage *placeholderImage = [UIImage imageNamed:HOLDER_IMAGE];
//    NSURL *picUrl = [NSURL URLWithString:[Tools jointUrlPathWithUrlPath:url]];
//    self.backgroundColor    = kXSF_COLOR_240;
//    [self sd_setImageWithURL:picUrl
//            placeholderImage:placeholderImage
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if (image) {
//             self.backgroundColor = [UIColor clearColor];
//         }
//     }];
//}
- (void)LoadImage:(NSString*)url
{
    NSString *str_cut_type = [NSString stringWithFormat:@"%@,m_fill",OSS_MARK_STRING];
    NSString *cut_params = @"";
    cut_params = [NSString stringWithFormat:@"%@,w_%d,h_%d",str_cut_type,(int)self.width*2,(int)self.height*2];
    if(url && ![url isEqualToString:@""])
    {
        NSRange range = [url rangeOfString:@"?"];//判断字符串是否包含

        if (range.length >0)//包含
        {
            NSString *pre = [url substringToIndex:range.location + 1];

            NSString *last = [url substringFromIndex:range.location + 1];


            url = [NSString stringWithFormat:@"%@%@,%@", pre,cut_params,last];
        }
        else//不包含
        {
            url = [NSString stringWithFormat:@"%@?%@", url, cut_params];
        }
    }

    UIImage *placeholderImage = nil;
    NSURL *picUrl = [NSURL URLWithString:url];
    [self sd_setImageWithURL:picUrl
            placeholderImage:placeholderImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (image) {
             self.backgroundColor = [UIColor clearColor];
         }
     }];
}

- (void)LoadImage:(NSString*)url PlaceholderImageName:(NSString*)placeholderImageName{
    UIImage *placeholderImage = [UIImage imageNamed:placeholderImageName];
    NSURL *picUrl =  [NSURL URLWithString:url];
    self.backgroundColor    = [UIColor clearColor];
    [self sd_setImageWithURL:picUrl
            placeholderImage:placeholderImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (image) {
             self.backgroundColor = [UIColor clearColor];
         }
     }];
}

- (void)LoadImage:(NSString*)url successBlock:(void(^)(UIImage* retImage))successblock
{
    UIImage *placeholderImage = nil;
    NSURL *picUrl = [NSURL URLWithString:url];
    [self sd_setImageWithURL:picUrl
            placeholderImage:placeholderImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if(image != nil && ![image isKindOfClass:[NSNull class]])
         {
             if (successblock) {
                 successblock(image);
             }
         }
         else
         {
             if (successblock) {
                 UIImage* logoImage = [UIImage imageNamed:@"logo"];
                 successblock(logoImage);
             }
         }
     }];
}
//- (void)LoadImage:(NSString*)url withWidth:(CGFloat)width successBlock:(void(^)(UIImage* retImage))successblock
//{
//    NSString *str_cut_type = OSS_MARK_STRING;
//    NSString *cut_params = @"";
//    cut_params = [NSString stringWithFormat:@"%@,w_%d",str_cut_type,(int)self.width*2];
//    if(url && ![url isEqualToString:@""])
//    {
//        NSRange range = [url rangeOfString:@"?"];//判断字符串是否包含
//
//        if (range.length >0)//包含
//        {
//            NSString *pre = [url substringToIndex:range.location + 1];
//
//            NSString *last = [url substringFromIndex:range.location + 1];
//
//
//            url = [NSString stringWithFormat:@"%@%@,%@", pre,cut_params,last];
//        }
//        else//不包含
//        {
//            url = [NSString stringWithFormat:@"%@?%@", url, cut_params];
//        }
//    }
//
//    UIImage *placeholderImage = [UIImage imageNamed:HOLDER_IMAGE];
//    NSURL *picUrl = [NSURL URLWithString:[Tools jointUrlPathWithUrlPath:url]];
//    [self sd_setImageWithURL:picUrl
//            placeholderImage:placeholderImage
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if(image != nil && ![image isKindOfClass:[NSNull class]])
//         {
//             if (successblock) {
//                 successblock(image);
//             }
//         }
//         else
//         {
//             if (successblock) {
//                 UIImage* logoImage = [UIImage imageNamed:HOLDER_IMAGE];
//                 successblock(logoImage);
//             }
//         }
//     }];
//}
//
//- (void)LoadImage:(NSString*)url PlaceholderImageName:(NSString*)placeholderImageName successBlock:(void(^)(UIImage* retImage))successblock{
//    UIImage *placeholderImage = [UIImage imageNamed:placeholderImageName];
//    NSURL *picUrl = [NSURL URLWithString:[Tools jointUrlPathWithUrlPath:url]];
//    [self sd_setImageWithURL:picUrl
//            placeholderImage:placeholderImage
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if(image != nil && ![image isKindOfClass:[NSNull class]])
//         {
//             if (successblock) {
//                 successblock(image);
//             }
//         }
//         else
//         {
//             if (successblock)
//             {
//                 UIImage* logoImage = [UIImage imageNamed:HOLDER_IMAGE];
//                 successblock(logoImage);
//             }
//         }
//     }];
//}
//
- (void)LoadImage:(NSString*)url withHoderImage:(UIImage*)hoderImage successBlock:(void(^)(UIImage* retImage))successblock
{
    if (hoderImage == nil)
        hoderImage = [UIImage imageNamed:@"img_default"];

    UIImage *placeholderImage = hoderImage;
    NSURL *picUrl =  [NSURL URLWithString:url];
//    self.backgroundColor    = kXSF_COLOR_240;
    [self sd_setImageWithURL:picUrl
            placeholderImage:placeholderImage
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if(image != nil && ![image isKindOfClass:[NSNull class]])
         {
             if (successblock) {
                 successblock(image);
             }
         }
     }];
}
//- (void)LoadImage:(NSString*)url withWidth:(int)width withHeight:(int)height successBlock:(void(^)(UIImage* retImage))successblock
//{
//    UIImage *placeholderImage = [UIImage imageNamed:HOLDER_IMAGE];
//    NSURL *picUrl = [NSURL URLWithString:url];
//    [self sd_setImageWithURL:picUrl
//            placeholderImage:placeholderImage
//                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//     {
//         if(image != nil && ![image isKindOfClass:[NSNull class]])
//         {
//             if (successblock) {
//                 successblock(image);
//             }
//         }
//         else
//         {
//             if (successblock) {
//                 successblock([UIImage imageNamed:HOLDER_IMAGE]);
//             }
//         }
//     }];
//}
//
//+ (CGFloat) getRValueFromHexString: (NSString *)color
//{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return 0.0f;
//    }
//    // 判断前缀
//    if ([cString hasPrefix:@"0X"])
//    cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//    cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//    return 0.0f;
//    // 从六位数值中找到RGB对应的位数并转换
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //R、G、B
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//
//    return r/255.f;
//}
//
//+ (CGFloat) getGValueFromHexString: (NSString *)color
//{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return 0.0f;
//    }
//    // 判断前缀
//    if ([cString hasPrefix:@"0X"])
//    cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//    cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//    return 0.0f;
//    // 从六位数值中找到RGB对应的位数并转换
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //R、G、B
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//
//    return g/255.f;
//}
//
//+ (CGFloat) getBValueFromHexString: (NSString *)color
//{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return 0.0f;
//    }
//    // 判断前缀
//    if ([cString hasPrefix:@"0X"])
//    cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//    cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//    return 0.0f;
//    // 从六位数值中找到RGB对应的位数并转换
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //R、G、B
//    NSString *rString = [cString substringWithRange:range];
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//
//    return b/255.f;
//}
@end
