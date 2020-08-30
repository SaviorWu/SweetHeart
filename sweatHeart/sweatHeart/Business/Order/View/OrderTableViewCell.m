//
//  OrderTableViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.vBack.layer.masksToBounds = YES;
    self.vBack.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(OrderListModel*)model
{
    self.lbStatus.text = model.statustxt;
    self.lbGameTime.text = model.play_time;
    self.lbNumber.text = [NSString stringWithFormat:@"%@%@",model.play_round,model.unit];
    self.lbGameName.text = model.gname;
}
@end
