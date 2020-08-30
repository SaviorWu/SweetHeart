//
//  HelpViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/28.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "HelpViewController.h"
#import "SettingtableViewCell.h"
#import "ProtocolViewController.h"
@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* arrayList;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帮助";
    [self addNavigationView];
    self.arrayList = [[NSMutableArray alloc] init];
    
    [self.tableView LoadCell:@"SettingtableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [NetworkRequest GET:[NSString stringWithFormat:@"%@%@",@"/app/users/help_list/token/",[UserInfo shareInstance].userModel.token]
             parameters:@{@"token":[UserInfo shareInstance].userModel.token} success:^(NetWorkResponseModel * _Nullable responseModel) {
        self.arrayList = responseModel.data;
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        [self showHint:responseModel.msg];
        [self.navigationController popViewController];
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

    SettingtableViewCell *tvCell = [tableView reUseCell:@"SettingtableViewCell"];
    tvCell.lbTitle.text = self.arrayList[indexPath.row][@"title"];
    tvCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return tvCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProtocolViewController * vc = [[ProtocolViewController alloc] init];
    vc.title = self.arrayList[indexPath.row][@"title"];
    vc.content = self.arrayList[indexPath.row][@"content"];
    [self.navigationController pushViewController:vc];
    
}
@end
