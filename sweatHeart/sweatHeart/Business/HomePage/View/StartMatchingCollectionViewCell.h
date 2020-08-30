//
//  StartMatchingCollectionViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^clickStartMatching) (void);
@interface StartMatchingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnGirl;
@property (weak, nonatomic) IBOutlet UIButton *btnBoy;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnPause;
@property (weak, nonatomic) IBOutlet UIImageView *imageGirlBack;
@property (weak, nonatomic) IBOutlet UIImageView *imageBoyBack;
@property (nonatomic, strong) clickStartMatching matchBlock;
@property (nonatomic, strong) clickStartMatching clickGirl;
@property (nonatomic, strong) clickStartMatching clickboy;
@end

NS_ASSUME_NONNULL_END
