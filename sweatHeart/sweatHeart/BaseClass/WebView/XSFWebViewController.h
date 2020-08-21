//
//  XSFWebViewController.h
//  XSF
//
//  Created by duck on 16/11/9.
//  Copyright © 2016年 Xsf Technology Co.,Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface XSFWebViewController : BaseViewController <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,NSURLConnectionDelegate,NSURLSessionDelegate>
@property (nonatomic, strong) NSString* reqURL;
@property (nonatomic, strong) NSString* htmlData;
@property (nonatomic, strong) WKWebView* webView;
@end
