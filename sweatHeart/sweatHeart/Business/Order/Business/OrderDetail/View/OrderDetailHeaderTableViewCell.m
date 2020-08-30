//
//  OrderDetailHeaderTableViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "OrderDetailHeaderTableViewCell.h"

@implementation OrderDetailHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lbAge.layer.masksToBounds = YES;
    self.lbAge.layer.cornerRadius = 10;
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 2;
    self.imgHead.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.imgHead.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(OrderDetailUser*)model
{
    [self.imgHead LoadImage:[UserInfo shareInstance].userModel.header]; // model.header
    if ([model.sex intValue] == 1) {
        [self.imgSex setImage:[UIImage imageNamed:@"icon_female"]];
        self.lbAge.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.lbAge.size direction:IHGradientChangeDirectionLevel startColor:RED_LEFT endColor:RED_RIGHT];
        
    }else{
        [self.imgSex setImage:[UIImage imageNamed:@"icon_male"]];
        self.lbAge.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.lbAge.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
    }
    self.lbNickName.text = model.nickname;
    self.lbAge.text = [NSString stringWithFormat:@"    %@",model.age];
    [self.imgStart setImage:[UIImage imageNamed:@"待定字段"]];
    self.lbScore.text = @"待定字段";
}
- (IBAction)clickSendMsg:(id)sender {
    if (self.sendBlock) {
        self.sendBlock();
    }
}

@end
