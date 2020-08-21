//
//  MZTableView+Cell.m
//  MiaoZhuan
//
//  Created by 吴友鹏 on 16/4/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "MZTableView+Cell.h"

@implementation UITableView(LoadCell)
- (void)adaptationHeight
{
    self.estimatedRowHeight = 60;
    self.rowHeight = UITableViewAutomaticDimension;
    self.tableFooterView    = [[UIView alloc] init];
}
- (void)LoadCell:(NSString*)cellName
{
    if (cellName && cellName.length != 0) {
        [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (id)reUseCell:(NSString*)cellName
{
    if (cellName && cellName.length != 0)
        return [self dequeueReusableCellWithIdentifier:cellName];
    return nil;
}
- (void)reloadCell:(NSInteger)row inSection:(NSInteger)section withAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *indexP         = [NSIndexPath indexPathForRow:row inSection:section];
    [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexP,nil] withRowAnimation:animation];
}

@end
