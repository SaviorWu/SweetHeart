//
//  OrderDetailBodyTableViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailBodyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbGameName;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbCost;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
- (void)setModel:(OrderDetailOrder*)model;
@end

NS_ASSUME_NONNULL_END
