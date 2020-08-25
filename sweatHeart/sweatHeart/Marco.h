//
//  Marco.h
//  ALD
//
//  Created by friend on 2019/8/13.
//  Copyright © 2019 friend. All rights reserved.
//

#ifndef Marco_h
#define Marco_h

//#define SERVER_URL @"http://49.4.25.111/"   //开发环境
#define SERVER_URL @"https://api.aldpow.com/" // 正式环境

#define API_USER_REGISTER @"api/user/register"
#define API_MOBILE_SEND @"api/mobile/send"
#define API_USER_LOGIN @"api/user/login"
#define API_INDEX_INDEX @"api/index/index"
#define API_ARTICLE_DETAIL @"api/article/detail"
#define API_ARTICLE_LIST @"api/article/list"
#define API_USER_UPDATEPAYPASSWORD @"api/user/updatePaypassword"
#define API_USER_UPDATEMOBILE @"api/user/updateMobile"
#define API_WORKORDER_SUBMIT @"api/workOrder/submit"
#define API_WORKORDER_MY @"api/workOrder/my"
#define API_BALANCE_MY @"api/balance/my"
#define API_WORKORDER_NUMBERS @"api/workOrder/numbers"
#define API_WORKORDER_DETAIL @"api/workOrder/detail"
#define API_BALANCE_TRANSFERTOUSABLE @"api/balance/transferToUsable"
#define API_BALANCE_TRANSFERINSIDE @"api/balance/transferInside"
#define API_COIN_CONFIG @"api/coin/config"
#define API_CONTRACT_LIST @"api/contract/list"
#define API_CONTRACT_MY @"api/contract/my"
#define API_CONTRACT_BUY @"api/contract/buy"
#define API_FINANCE_MY @"api/finance/my"
#define API_USER_AUTH @"api/user/auth"
#define API_USER_FINDPAYPASSWORD @"api/user/findPaypassword"
#define API_USER_UPDATEPASSWORD @"api/user/updatePassword"
#define API_USER_FINDPASSWORD @"api/user/findPassword"
#define API_USER_INFO @"api/user/info"
#define API_USER_UPLOAD @"api/user/upload"
#define API_CONFIG_COMMON @"api/config/common"
#define API_USER_INVITEDATA @"api/user/inviteData"
#define API_USER_RECOMMENDORDERNUMBSCOUNT @"api/user/recommendOrderNumsCount"
#define API_USER_RECOMMENDAWARDCOUNT @"api/user/recommendAwardCount"
#define API_USER_NODEDETAILS @"api/user/nodeDetails"
#define API_USER_SETRECOMENNDPOSITION @"api/user/setRecommendPosition"
#define API_BALANCE_DEPOSITADDRESS @"api/balance/depositAddress"
#define API_BALANCE_WITHDRAW @"api/balance/withdraw"
#define API_BALANCE_WITHDRAWLIST @"api/balance/withdrawList"
#define API_CONTRACT_EARLYPAYAPPLE @"api/contract/earlyPayApply"

#define ALD_EG @"en-us"
#define ALD_CN @"zh-cn"
#define ALD_CN_HK @"zh-hk"

#define IOS_EG @"en"
#define IOS_CN @"zh-Hans"
#define IOS_CN_HK @"zh-Hant-HK"

#define CONVENTION @"@#A@$@GRR4523a!sweMYqwe31JKV*%%"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define APP_COLOR [UIColor colorWithRGB:0xFFFFFF]
#define AUTOSIZE_HEIGHT(value) value*SCREEN_WIDTH/375.f

#define IS_IPHONE_X [self isIphoneX]

#define STATUS_BAR_HEIGHT (IS_IPHONE_X == YES?44.0f:20.0f)
#define NAVIGATION_HEIGHT 44.0f

#define CHECK_USER_STATUS if (responseModel.status == -1) {\
[UserInfo userLogout];\
return;\
}
#define PICTURE_MAX_WIDTH   1024
#define PICTURE_MAX_HEIGHT   1024
#define PICTURE_MAXSIZE_HEIGHT_WIDTH    1024*1024*8      // 处理文件大小限制1024*512
#define MAX_SIZE    1024*1024*100                    // 文件超过大小不处理划分线 20MB

#endif /* Marco_h */
