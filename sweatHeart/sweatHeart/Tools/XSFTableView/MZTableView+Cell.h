//
//  MZTableView+Cell.h
//  MiaoZhuan
//
//  Created by 吴友鹏 on 16/4/28.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableView(LoadCell)
/*!
 *  @opration    Create
 *  @author      Friend.Wu
 *
 *  @brief       调用后tableview自动计算cell高度，tableview无需实现计算cell高度的代理
 *  @参数解析：
 */
- (void)adaptationHeight;

/*!
 *  @opration    Create
 *  @author      Friend.Wu
 *
 *  @brief       加载cell
 *  @参数解析：
 */
- (void)LoadCell:(NSString*)cellName;

/*!
 *  @opration    Create
 *  @author      Friend.Wu
 *
 *  @brief       复用cell
 *  @参数解析：
 */
- (id)reUseCell:(NSString*)cellName;

- (void)reloadCell:(NSInteger)row inSection:(NSInteger)section withAnimation:(UITableViewRowAnimation)animation;
@end
