//
//  PublicTool.h
//  ALD
//
//  Created by friend on 2019/8/22.
//  Copyright © 2019 friend. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicTool : NSObject
+ (PublicTool*)sharedInstance;
+ (NSString*)checkTextFeild:(UITextField*)tf;
+ (BOOL)judgePassWord:(NSString *)pass;
@end

NS_ASSUME_NONNULL_END
