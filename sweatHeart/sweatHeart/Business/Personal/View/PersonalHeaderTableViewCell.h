//
//  PersonalHeaderTableViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickProket) (void);
NS_ASSUME_NONNULL_BEGIN

@interface PersonalHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnMyMoney;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbSHId;
@property (nonatomic, strong) clickProket block;
@end

NS_ASSUME_NONNULL_END
