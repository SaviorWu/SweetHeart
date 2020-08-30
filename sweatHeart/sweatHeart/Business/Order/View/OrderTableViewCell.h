//
//  OrderTableViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vBack;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbGameTime;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbGameName;
- (void)setModel:(OrderListModel*)model;
@end

NS_ASSUME_NONNULL_END
