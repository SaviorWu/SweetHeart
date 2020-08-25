//
//  StartMatchingCollectionViewCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "StartMatchingCollectionViewCell.h"

@implementation StartMatchingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnGirl.layer.masksToBounds = YES;
    self.btnGirl.layer.cornerRadius = 12.5;
    
    self.btnBoy.layer.masksToBounds = YES;
    self.btnBoy.layer.cornerRadius = 12.5;
    
    self.btnStart.layer.masksToBounds = YES;
    self.btnStart.layer.cornerRadius = 15;
    
    self.btnPause.layer.masksToBounds = YES;
    self.btnPause.layer.cornerRadius = 12.5;
    
    self.btnStart.backgroundColor = [UIColor blueColor];
}
- (IBAction)clickGirl:(id)sender {
    self.btnGirl.backgroundColor = [UIColor redColor];
    self.btnBoy.backgroundColor = [UIColor clearColor];
    
    [self.btnGirl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBoy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (IBAction)clickBoy:(id)sender {
    self.btnGirl.backgroundColor = [UIColor clearColor];
    self.btnBoy.backgroundColor = [UIColor blueColor];
    
    [self.btnBoy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnGirl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (IBAction)clickStart:(id)sender {
    if (self.matchBlock) {
        self.matchBlock();
    }
}
- (IBAction)clickPause:(id)sender {
}

@end
