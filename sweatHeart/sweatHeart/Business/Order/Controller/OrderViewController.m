//
//  OrderViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "OrderListModel.h"
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* arrayList;
@property (nonatomic, assign) NSInteger page;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单";
    [self addNavigationView];
    [self hiddenBackBtn:YES];
    
    [self.tableView LoadCell:@"OrderTableViewCell"];
    self.page = 1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];

    self.arrayList = [[NSMutableArray alloc] init];

    [self addRefreshLoading];
    [self addRefreshFooter];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
}
- (void)loadData:(BOOL)isLoad
{
    [NetworkRequest GET:[NSString stringWithFormat:@"%@%@",@"/app/order/orderRelease/token/",[UserInfo shareInstance].userModel.token]
             parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                          @"page":@(self.page)
             } success:^(NetWorkResponseModel * _Nullable responseModel) {
        if (isLoad == YES) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        NSArray* respList = responseModel.data;
        if (respList.count == 0) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        for (NSDictionary* dic in respList) {
            OrderListModel* model = [OrderListModel modelWithJSON:dic];
            [self.arrayList addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        if (isLoad == YES) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if ([responseModel.code integerValue] == -2) {
            [self showHint:@"账号在其他设备登录"];
            [UserInfo userLogout];
        }
    }];
}
- (void)addRefreshLoading{
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrayList = [[NSMutableArray alloc] init];
        [self loadData:YES];
    }];
    self.tableView.mj_footer.hidden = YES;
}
- (void)addRefreshFooter{
    @weakify(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self loadData:NO];
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
    OrderTableViewCell *cell = [tableView reUseCell:@"OrderTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.arrayList[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderListModel* model = self.arrayList[indexPath.row];
    OrderDetailViewController* vc = [[OrderDetailViewController alloc] init];
    vc.orderID = model.id;
    [self.navigationController pushViewController:vc];
}
@end
