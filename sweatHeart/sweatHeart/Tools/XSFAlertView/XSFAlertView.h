//
//  XSFAlertView.h
//  XSF
//
//  Created by duck on 16/11/11.
//  Copyright © 2016年 Xsf Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock) (void);
typedef void(^clickTextValue) (NSString* value);
@interface XSFAlertView : UIViewController
+ (XSFAlertView*)sharedInstance;
+(void)hiddenHub;
+(void)showMyAssetsOperation:(clickTextValue)moneyBlock;
+(void)showPayPassword:(clickTextValue)passwordBlock;
+(void)showBalanceNotEnough:(void(^)(void))balanceBlock  withShowType:(NSInteger)type;
+(void)showBeforeGiveBackConfirm:(void(^)(void))confirmBlock;
+(void)showImageUrl:(NSString*)imageUrl withCloseBlock:(void(^)(void))closeBlock clickJumpLink:(void(^)(void))confirm;
+(void)showAlertView:(NSString*)title
        leftBtnTitle:(NSString*)leftTitle
       rightBtnTitle:(NSString*)rightTitle
           leftBlock:(void(^)(void))left
          rightBlock:(void(^)(void))right;
@end
