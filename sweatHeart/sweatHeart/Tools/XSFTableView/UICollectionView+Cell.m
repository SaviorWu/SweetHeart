//
//  UICollectionView+Cell.m
//  ALD
//
//  Created by friend on 2019/8/19.
//  Copyright © 2019 friend. All rights reserved.
//

#import "UICollectionView+Cell.h"

@implementation UICollectionView(LoadCell)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)LoadCell:(NSString*)cellName
{
    if (cellName && cellName.length != 0) {
        [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:cellName];
    }
}
- (id)reUseCell:(NSString*)cellName forIndexPath:(NSIndexPath *)indexPath
{
    if (cellName && cellName.length != 0)
        return [self dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    return nil;
}
@end
