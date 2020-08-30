//
//  LogoutTableViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/29.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "LogoutTableViewCell.h"

@implementation LogoutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnLogout.layer.masksToBounds = YES;
    self.btnLogout.layer.cornerRadius = 5;
    self.btnLogout.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.btnLogout.layer.borderWidth = 1;
}
- (IBAction)clickLogout:(id)sender {
    if (self.block) {
        self.block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
