//
//  OrderDetailHeaderTableViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
typedef void (^clickSendMsg)(void);
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailHeaderTableViewCell : UITableViewCell
- (void)setModel:(OrderDetailUser*)model;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbAge;
@property (weak, nonatomic) IBOutlet UIImageView *imgStart;
@property (weak, nonatomic) IBOutlet UILabel *lbScore;
@property (weak, nonatomic) IBOutlet UIImageView *imgSex;
@property(nonatomic, strong) clickSendMsg sendBlock;
@end

NS_ASSUME_NONNULL_END
