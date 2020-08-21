//
//  UICollectionView+Cell.h
//  ALD
//
//  Created by friend on 2019/8/19.
//  Copyright © 2019 friend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(LoadCell)
- (void)LoadCell:(NSString*)cellName;
- (id)reUseCell:(NSString*)cellName forIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
