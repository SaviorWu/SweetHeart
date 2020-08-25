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
@property (nonatomic, strong) clickStartMatching matchBlock;
@end

NS_ASSUME_NONNULL_END
