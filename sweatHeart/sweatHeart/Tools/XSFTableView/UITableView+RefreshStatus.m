//
//  UITableViewController+refreshStatus.m
//  ALD
//
//  Created by friend on 2019/8/26.
//  Copyright © 2019 friend. All rights reserved.
//

#import "UITableView+RefreshStatus.h"

@implementation UITableView(RefreshStatus)
- (void)updateTableViewRefreshStatus:(NSArray*)array isOverLoad:(BOOL)bOverLoad{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
    if (array.count < 20) {
        self.mj_footer.hidden = YES;
    }else if(bOverLoad == YES){
        self.mj_footer.hidden = YES;
    }else{
        self.mj_footer.hidden = NO;
    }
}
@end
