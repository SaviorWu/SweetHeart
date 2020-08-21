//
//  ZQNetworkRequest.h
//  ZQXQBaseProject
//
//  Created by ZQXQ on 2017/10/27.
//  Copyright © 2017年 zongqingxiangqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkResponseModel.h"

#ifdef __cplusplus
#define MEONEKIT_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define MEONEKIT_EXTERN        extern __attribute__((visibility ("default")))
#endif

/**
 *  请求成功block
 */
typedef void (^successBlock)(NetWorkResponseModel * _Nullable responseModel);

/**
 *  请求失败block
 */
typedef void (^failureBlock) (NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel);

/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * _Nullable progress);


/**
 *  上传文件
 */
typedef void (^constructingBodyWithBlock)( __nullable id <AFMultipartFormData> formData);


MEONEKIT_EXTERN BOOL isSafeResponseData(id _Nullable obj);

MEONEKIT_EXTERN NSDictionary * _Nullable const API(NSDictionary * _Nullable parameter,NSString * _Nonnull methodName);

//Request
@interface NetworkRequest : NSObject

///GET
+ (void)GET:(NSString *_Nonnull)URLString
 parameters:(id _Nullable )parameters
    success:(successBlock _Nullable )successBlock
    failure:(failureBlock _Nullable)failureBlock;

///GET progress
+ (void)GET:(NSString *_Nonnull)URLString
 parameters:(id _Nullable )parameters
   progress:(progressBlock _Nullable)progressBlock
    success:(successBlock _Nullable)successBlock
    failure:(failureBlock _Nullable)failureBlock;

///POST
+ (void)POST:(NSString * _Nonnull)URLString
  parameters:(id _Nullable)parameters
     success:(successBlock _Nullable)successBlock
     failure:(failureBlock _Nullable)failureBlock;

///POST progress
+ (void)POST:(NSString * _Nonnull)URLString
  parameters:(id _Nullable)parameters
    progress:(progressBlock _Nullable)progressBlock
     success:(successBlock _Nullable)successBlock
     failure:(failureBlock _Nullable)failureBlock;

///POST progress constructingBodyWithBlock
+ (NSURLSessionDataTask *)POST:(NSString * _Nonnull)URLString
  parameters:(id _Nullable)parameters
constructingBodyWithBlock:(constructingBodyWithBlock _Nullable )block
    progress:(progressBlock _Nullable)progressBlock
     success:(successBlock _Nullable)successBlock
     failure:(failureBlock _Nullable)failureBlock;

///PUT
+ (void)PUT:(NSString * _Nonnull)URLString
 parameters:(id _Nullable)parameters
    success:(successBlock _Nullable)successBlock
    failure:(failureBlock _Nullable)failureBlock;

///DELETE
+ (void)DELETE:(NSString * _Nonnull)URLString
    parameters:(id _Nullable)parameters
       success:(successBlock _Nullable)successBlock
       failure:(failureBlock _Nullable)failureBlock;


@end
