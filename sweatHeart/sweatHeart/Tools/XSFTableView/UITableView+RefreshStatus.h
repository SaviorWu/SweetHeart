//
//  UITableViewController+refreshStatus.h
//  ALD
//
//  Created by friend on 2019/8/26.
//  Copyright © 2019 friend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(RefreshStatus)
- (void)updateTableViewRefreshStatus:(NSArray*)array isOverLoad:(BOOL)bOverLoad;
@end

NS_ASSUME_NONNULL_END
