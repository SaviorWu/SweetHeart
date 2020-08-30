//
//  OrderDetailViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/26.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailHeaderTableViewCell.h"
#import "OrderDetailBodyTableViewCell.h"
#import "OrderDetailModel.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OrderDetailModel* orderDetail;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    [self addNavigationView];
    [self.tableView LoadCell:@"OrderDetailHeaderTableViewCell"];
    [self.tableView LoadCell:@"OrderDetailBodyTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRGB:0xf0f0f0];
    [self loadData];
}
- (void)loadData
{
    
    
    [NetworkRequest GET:@"/app/order/orderBuy"
             parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                          @"id":self.orderID}
                success:^(NetWorkResponseModel * _Nullable responseModel) {
        self.orderDetail = [OrderDetailModel modelWithJSON:responseModel.data];
        self.orderDetail.user = [OrderDetailUser modelWithJSON:responseModel.data[@"user"]];
        self.orderDetail.order = [OrderDetailOrder modelWithJSON:responseModel.data[@"order"]];
        [self.tableView reloadData];
    }failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        [self showHint:responseModel.msg];
        if ([responseModel.code integerValue] == -2) {
            [self showHint:@"账号在其他设备登录"];
            [UserInfo userLogout];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell* cell = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        OrderDetailHeaderTableViewCell *headerCell = [tableView reUseCell:@"OrderDetailHeaderTableViewCell"];
        headerCell.sendBlock = ^{
            NSLog(@"发送消息");
        };
        [headerCell setModel:self.orderDetail.user];
        cell = headerCell;
    }else{
        OrderDetailBodyTableViewCell *bodyCell = [tableView reUseCell:@"OrderDetailBodyTableViewCell"];
        [bodyCell setModel:self.orderDetail.order];
        cell = bodyCell;
    }
    
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
