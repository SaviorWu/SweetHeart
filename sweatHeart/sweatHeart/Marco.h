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
#define SERVER_URL @"http://txcs.wx918.com" // 正式环境
#define BLUE_LEFT [UIColor colorWithRGB:0x169AFC]
#define BLUE_RIGHT [UIColor colorWithRGB:0x1BD6FF]
#define RED_LEFT [UIColor colorWithRGB:0xF56765]
#define RED_RIGHT [UIColor colorWithRGB:0xFFA1A0]
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
