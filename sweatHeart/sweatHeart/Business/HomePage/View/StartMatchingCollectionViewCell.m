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
    
    self.imageGirlBack.layer.masksToBounds = YES;
    self.imageGirlBack.layer.cornerRadius = 12.5;
    
    self.imageBoyBack.layer.masksToBounds = YES;
    self.imageBoyBack.layer.cornerRadius = 12.5;
    self.btnStart.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnStart.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
    
    [self.btnGirl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBoy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btnGirl.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnGirl.size direction:IHGradientChangeDirectionLevel startColor:RED_LEFT endColor:RED_RIGHT];
    self.btnBoy.backgroundColor = [UIColor whiteColor];
}
- (IBAction)clickGirl:(id)sender {
//    self.btnGirl.backgroundColor = [UIColor redColor];
//    self.btnBoy.backgroundColor = [UIColor clearColor];
//
    [self.btnGirl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBoy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btnGirl.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnGirl.size direction:IHGradientChangeDirectionLevel startColor:RED_LEFT endColor:RED_RIGHT];
    self.btnBoy.backgroundColor = [UIColor whiteColor];
    if (self.clickGirl) {
        self.clickGirl();
    }
}
- (IBAction)clickBoy:(id)sender {
    self.btnBoy.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnGirl.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
    self.btnGirl.backgroundColor = [UIColor whiteColor];
    
    [self.btnBoy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnGirl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (self.clickboy) {
        self.clickboy();
    }
}
- (IBAction)clickStart:(id)sender {
    if (self.matchBlock) {
        self.matchBlock();
    }
}
- (IBAction)clickPause:(id)sender {
}

@end
