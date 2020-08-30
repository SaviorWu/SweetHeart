//
//  LogoutTableViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/29.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickLogoutBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface LogoutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;
@property (nonatomic, strong) clickLogoutBlock block;
@end

NS_ASSUME_NONNULL_END
