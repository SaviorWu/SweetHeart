
@interface HTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedSessionManager;

+ (void)resetSessionManager;

@end
