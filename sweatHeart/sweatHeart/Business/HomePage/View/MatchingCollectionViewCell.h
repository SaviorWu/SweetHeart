//
//  MatchingCollectionViewCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBtnBlock) (void);
NS_ASSUME_NONNULL_BEGIN

@interface MatchingCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) clickBtnBlock block;
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btnChose;
@end

NS_ASSUME_NONNULL_END
