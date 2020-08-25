//
//  PublicTool.m
//  ALD
//
//  Created by friend on 2019/8/22.
//  Copyright © 2019 friend. All rights reserved.
//

#import "PublicTool.h"

@implementation PublicTool
+ (PublicTool*)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}
+ (BOOL)judgePassWord:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
+ (NSString*)checkTextFeild:(UITextField*)tf{
    if (tf.keyboardType == UIKeyboardTypeDefault) {
        if (tf.text.length >= 20) {
            return [tf.text substringToIndex:20];
        }
    }else if(tf.keyboardType == UIKeyboardTypeASCIICapable){
        if (tf.text.length >= 16) {
            return [tf.text substringToIndex:16];
        }
    }else if(tf.keyboardType == UIKeyboardTypeNumberPad){
//        if (tf.text.length >= 8) {
//            return [tf.text substringToIndex:8];
//        }
    }else if(tf.keyboardType == UIKeyboardTypePhonePad){
        if (tf.text.length >= 11) {
            return [tf.text substringToIndex:11];
        }
    }else if(tf.keyboardType == UIKeyboardTypeDecimalPad){
        if (tf.text.length >= 30) {
            return [tf.text substringToIndex:30];
        }
    }else if(tf.keyboardType == UIKeyboardTypeEmailAddress){
        if (tf.text.length >= 50) {
            return [tf.text substringToIndex:50];
        }
    }else{
        if (tf.text.length >= 20) {
            return [tf.text substringToIndex:20];
        }
    }
    return tf.text;
}
@end
