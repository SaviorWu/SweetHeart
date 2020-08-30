//
//  OrderDetailBodyTableViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "OrderDetailBodyTableViewCell.h"

@implementation OrderDetailBodyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(OrderDetailOrder*)model
{
    self.lbGameName.text = model.gname;
    self.lbTime.text = model.play_time;
    self.lbNumber.text = [NSString stringWithFormat:@"%@%@",model.play_unit.length == 0?@"":model.play_unit,model.unit.length == 0?@"":model.unit];
    self.lbOrderNumber.text = model.order_num;
    self.lbCost.text = [NSString stringWithFormat:@"%@币",model.pay_money.length == 0?@"":model.pay_money];
    self.lbStatus.text = model.statustxt;
}
@end
