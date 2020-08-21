//
//  ImageView+Loading.h
//  XSF
//
//  Created by duck on 16/10/28.
//  Copyright © 2016年 Xsf Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageView(Loading)
- (void)LoadImage:(NSString*)url;
- (void)LoadImage:(NSString*)url withWidth:(CGFloat)width withHeight:(CGFloat)height;
- (void)LoadImage:(NSString*)url PlaceholderImageName:(NSString*)placeholderImageName;
- (void)LoadImage:(NSString*)url PlaceholderImageName:(NSString*)placeholderImageName successBlock:(void(^)(UIImage* retImage))successblock;
- (void)LoadImage:(NSString*)url successBlock:(void(^)(UIImage* retImage))successblock;
- (void)LoadImage:(NSString*)url withWidth:(CGFloat)width successBlock:(void(^)(UIImage* retImage))successblock;//宽适配
- (void)LoadImage:(NSString*)url withHoderImage:(UIImage*)hoderImage successBlock:(void(^)(UIImage* retImage))successblock;
- (void)LoadImage:(NSString*)url withWidth:(int)width withHeight:(int)height successBlock:(void(^)(UIImage* retImage))successblock;

+ (CGFloat) getRValueFromHexString: (NSString *)color;
+ (CGFloat) getGValueFromHexString: (NSString *)color;
+ (CGFloat) getBValueFromHexString: (NSString *)color;
@end
