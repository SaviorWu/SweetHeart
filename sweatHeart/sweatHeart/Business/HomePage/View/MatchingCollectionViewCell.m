//
//  MatchingCollectionViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "MatchingCollectionViewCell.h"

@implementation MatchingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 17;
}
- (IBAction)clickBtn:(id)sender {
    if (self.block) {
        self.block();
    }
}

@end
