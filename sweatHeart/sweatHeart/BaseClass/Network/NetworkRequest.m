//
//  NetworkRequest.m
//  ZQXQBaseProject
//
//  Created by ZQXQ on 2017/10/27.
//  Copyright © 2017年 zongqingxiangqian. All rights reserved.
//

#import "NetworkRequest.h"
#import "HTTPSessionManager.h"

#define SUCCESSBLOCK         if (successBlock) {successBlock();}
#define FAILUREBLOCK         if (failureBlock) {failureBlock(nil);};

BOOL isSafeResponseData(id obj){
    
    if ([obj isKindOfClass:[NSString class]]) {
//        return IsNotNullOrEmptyOfNSString(obj);
    }
    
    if ([obj isKindOfClass:[NSArray class]]) {
        return [(NSArray*)obj count];
    }
    
    return (obj && (![(obj) isEqual:[NSNull null]]));
}


NSString *const encodeValue(NSString *value)
{
    NSString* encodedValue = value;
    if (value.length > 0) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    }
    return encodedValue;
}


//空格编码（+，%20）
NSString *blankEncode(NSString *str)
{
    return [str stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
}


NSString *const SortedDictionary(NSDictionary *parameter){
    
    if (![parameter isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    NSArray *allKeys = [parameter allKeys];
    NSArray *resultArray = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];

    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSString *key in resultArray) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key, parameter[key]];
        NSString *paStr = [NSString stringWithFormat:@"%@", parameter[key]];
        if (paStr.length < 1000) {
            [tempArray addObject:str];
        }else{
          [tempArray addObject: [NSString stringWithFormat:@"%@=%@",key,@""]];
        }
    }
    return [tempArray componentsJoinedByString:@"&"];
}

NSDictionary *const API(NSDictionary *parameter,NSString * _Nonnull methodName){
    
    if (nil == parameter) {
        parameter = [NSDictionary new];
    }
    ///组装
    NSMutableDictionary *bodyDic = [NSMutableDictionary new];
    ///消息体
    [bodyDic addEntriesFromDictionary:parameter];
    return bodyDic;
};


@interface NetworkRequest()

+ (BOOL)checkRequestSucceed:(NetWorkResponseModel*)responseMode;
+ (void (^)(id,id))checkRequestSucceed:(successBlock)successBlock failure:(failureBlock)failureBlock;
+ (void (^)(id,id))checkRequestFailure:(failureBlock)failureBlock;

@end


@implementation NetworkRequest
///验证登录是否有效
+ (BOOL)checkUserVaild:(id)responseObject
{
    //登录过期
    return YES;
}


///请求结果
+ (BOOL)checkRequestSucceed:(NetWorkResponseModel*)responseMode{
    if([responseMode.code integerValue] == 1)
        return YES;
    else
        return NO;
    
}

+ (void (^)(id,id))checkRequestSucceed:(successBlock)successBlock failure:(failureBlock)failureBlock{
    return ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
    
//        NSLog(@"👉URL-->%@ responseObject %@",task.currentRequest.URL,responseObject);
        
        NetWorkResponseModel *responseMode = [NetWorkResponseModel modelWithDictionary:responseObject];
        
        if ([self checkRequestSucceed:responseMode]) {
            
            if (successBlock) {
                successBlock(responseMode);
            }
            
        }else{

            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:responseMode.msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
            NSError *error = [NSError errorWithDomain:@"LC" code:[responseMode.code integerValue] userInfo:userInfo];
            if (failureBlock) {
                failureBlock(error, responseMode);
            };
        }
    };
}

///error
+ (void (^)(id,id))checkRequestFailure:(failureBlock)failureBlock {
    return ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error, nil);
        }
    };
}

+ (AFHTTPSessionManager*)httpSessionManagerWithUrl:(NSString*)URLString{
    if ([URLString hasPrefix:@"http"]) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        httpManager.requestSerializer.timeoutInterval = 15;
//        [httpManager.requestSerializer setValue:[AppShareInstence shareInstance].ID forHTTPHeaderField:@"ID"];
//        [httpManager.requestSerializer setValue:[AppShareInstence shareInstance].token forHTTPHeaderField:@"TOKEN"];
//        [httpManager.requestSerializer setValue:[AppShareInstence shareInstance].Convention forHTTPHeaderField:@"CONVENTION"];
//        [httpManager.requestSerializer setValue:[AppShareInstence shareInstance].sign forHTTPHeaderField:@"SIGN"];
//        [httpManager.requestSerializer setValue:[AppShareInstence shareInstance].language forHTTPHeaderField:@"Accept-Language"];
        return httpManager;
    }
    return [HTTPSessionManager sharedSessionManager];
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)successBlock
    failure:(failureBlock)failureBlock
{
//    [AppShareInstence shareInstance].sign = [AppShareInstence hmacSHA256WithSecret:[AppShareInstence shareInstance].token content:[AppShareInstence stringWithDict:parameters]];
    [self GET:[NSString stringWithFormat:@"%@%@",SERVER_URL,URLString] parameters:parameters progress:nil success:successBlock failure:failureBlock];
}

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
   progress:(progressBlock)progressBlock
    success:(successBlock)successBlock
    failure:(failureBlock)failureBlock
{
    [[self httpSessionManagerWithUrl:URLString] GET:URLString parameters:API(parameters,URLString) progress:progressBlock success:[self checkRequestSucceed:successBlock failure:failureBlock] failure:[self checkRequestFailure:failureBlock]];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(successBlock)successBlock
     failure:(failureBlock)failureBlock
{
//    [AppShareInstence shareInstance].sign = [AppShareInstence hmacSHA256WithSecret:[AppShareInstence shareInstance].token content:[AppShareInstence stringWithDict:parameters]];
    [self POST:[NSString stringWithFormat:@"%@%@",SERVER_URL,URLString] parameters:parameters progress:nil success:successBlock failure:failureBlock];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
    progress:(progressBlock)progressBlock
     success:(successBlock)successBlock
     failure:(failureBlock)failureBlock
{
    [self POST:URLString parameters:parameters constructingBodyWithBlock:nil progress:progressBlock success:successBlock failure:failureBlock];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
  parameters:(id)parameters
constructingBodyWithBlock:(constructingBodyWithBlock)block
    progress:(progressBlock)progressBlock
     success:(successBlock)successBlock
     failure:(failureBlock)failureBlock
{
    return [[self httpSessionManagerWithUrl:URLString] POST:URLString parameters:API(parameters,URLString)
                          constructingBodyWithBlock:block
                                           progress:progressBlock
                                            success:[self checkRequestSucceed:successBlock
                                                                      failure:failureBlock]
                                            failure:[self checkRequestFailure:failureBlock]];
}

+ (void)PUT:(NSString *)URLString
 parameters:(id)parameters
    success:(successBlock)successBlock
    failure:(failureBlock)failureBlock
{
    [[self httpSessionManagerWithUrl:URLString] PUT:URLString parameters:API(parameters,URLString)                                             success:[self checkRequestSucceed:successBlock failure:failureBlock]
                                           failure:[self checkRequestFailure:failureBlock]];
}

+ (void)DELETE:(NSString *)URLString
    parameters:(id)parameters
       success:(successBlock)successBlock
       failure:(failureBlock)failureBlock
{
    [[self httpSessionManagerWithUrl:URLString] DELETE:URLString
                                           parameters:API(parameters,URLString)
                                              success:[self checkRequestSucceed:successBlock failure:failureBlock]
                                              failure:[self checkRequestFailure:failureBlock]];
}

@end
