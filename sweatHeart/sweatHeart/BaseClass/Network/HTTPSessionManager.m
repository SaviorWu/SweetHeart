
#import "HTTPSessionManager.h"

static dispatch_once_t onceToken;
static HTTPSessionManager *_instance= nil;

@implementation HTTPSessionManager

+(void)resetSessionManager{
    
    HTTPSessionManager *instance = [HTTPSessionManager sharedSessionManager];
    onceToken = 0;
    instance = nil;
    _instance = nil;
}

+ (instancetype)sharedSessionManager
{
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:SERVER_URL];
        
        _instance = [[HTTPSessionManager alloc] initWithBaseURL:url];
        [_instance setupJsonRequestManager:SERVER_URL];
        _instance.requestSerializer.timeoutInterval = 15;
        _instance.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    return _instance;
}


+ (AFSecurityPolicy*)customSecurityPolicy {
    
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"api.cn" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    if (certData) {
        securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    }
    
    return securityPolicy;
}


- (void)setupJsonRequestManager:(NSString *)basePath
{
    // set the request serializer to rc serializer
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // add the aceptable content types
    
    NSMutableSet *newSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [newSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    
    self.responseSerializer.acceptableContentTypes = newSet;
}
@end

