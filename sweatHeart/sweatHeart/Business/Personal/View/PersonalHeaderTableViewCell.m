//
//  PersonalHeaderTableViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "PersonalHeaderTableViewCell.h"

@implementation PersonalHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnMyMoney.layer.masksToBounds = YES;
    self.btnMyMoney.layer.cornerRadius = 15;
    self.btnMyMoney.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnMyMoney.size direction:IHGradientChangeDirectionLevel startColor:RED_LEFT endColor:RED_RIGHT];
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 30;
    self.imgHead.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.imgHead.layer.borderWidth = 1;
}
- (IBAction)clickPorket:(id)sender {
    if (self.block) {
        self.block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
