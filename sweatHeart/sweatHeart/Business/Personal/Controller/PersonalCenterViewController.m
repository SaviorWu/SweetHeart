//
//  PersonalCenterViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/21.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalTableViewCell.h"
#import "PersonalHeaderTableViewCell.h"
#import "PersonalModel.h"
#import "SettingViewController.h"
#import "MyPorketViewController.h"
@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView LoadCell:@"PersonalTableViewCell"];
    [self.tableView LoadCell:@"PersonalHeaderTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addRefreshLoading];
    [self loadData];
}
- (void)addRefreshLoading{
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        
        [self loadData];
    }];
    self.tableView.mj_footer.hidden = YES;
}
- (void)loadData
{
    [NetworkRequest GET:@"/app/users/personal/"
             parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                          @"uid":[UserInfo shareInstance].userModel.uid}
                success:^(NetWorkResponseModel * _Nullable responseModel) {
        [self.tableView.mj_header endRefreshing];
        PersonalModel* personModel = [PersonalModel modelWithJSON:responseModel.data];
        personModel.userdata = [UserData modelWithJSON:responseModel.data[@"userdata"]];
        personModel.newsData = [NewsData modelWithJSON:responseModel.data[@"newsData"]];
        personModel.xinyuan = [XinYuan modelWithJSON:responseModel.data[@"xinyuan"]];
        personModel.anchor = [Anchor modelWithJSON:responseModel.data[@"anchor"]];
        personModel.media = [Media modelWithJSON:responseModel.data[@"media"]];
        
        [UserInfo shareInstance].userModel.birthday = personModel.userdata.birthday;
        [UserInfo shareInstance].userModel.distance = personModel.userdata.distance;
        [UserInfo shareInstance].userModel.introduce = personModel.userdata.introduce;
        [UserInfo shareInstance].userModel.work = personModel.userdata.work;
        [UserInfo shareInstance].userModel.sex = personModel.userdata.sex;
        [UserInfo shareInstance].userModel.type = personModel.userdata.type;
        [UserInfo shareInstance].userModel.login_status = personModel.userdata.login_status;
        [UserInfo shareInstance].userModel.money = personModel.userdata.allmoney;
        [UserInfo shareInstance].userModel.interest = personModel.userdata.interest;
        [UserInfo shareInstance].userModel.nickname = personModel.userdata.nickname;
        [UserInfo shareInstance].userModel.nick_status = personModel.userdata.nick_status;
        [UserInfo shareInstance].userModel.header = personModel.userdata.header;
        
        NSLog(@"header = %@",[UserInfo shareInstance].userModel.header);
        [UserInfo shareInstance].userModel.vip = personModel.userdata.vip;
        [UserInfo shareInstance].userModel.age = personModel.userdata.age;
        [UserInfo shareInstance].userModel.introduce_status = personModel.userdata.introduce_status;
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        [self.tableView.mj_header endRefreshing];
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
    UITableViewCell* tempCell = nil;
    if (indexPath.row == 0) {
        PersonalHeaderTableViewCell* cell = [tableView reUseCell:@"PersonalHeaderTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.block = ^{
            MyPorketViewController* vc = [[MyPorketViewController alloc] init];
            [self.navigationController pushViewController:vc];
        };
        cell.lbNickName.text = [UserInfo shareInstance].userModel.nickname;
        [cell.imgHead LoadImage:[UserInfo shareInstance].userModel.header];
        cell.lbSHId.text = [NSString stringWithFormat:@"ID:%@",[UserInfo shareInstance].userModel.uid];
        tempCell = cell;
    }
    else
    {
        PersonalTableViewCell *cell = [tableView reUseCell:@"PersonalTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tempCell = cell;
    }
    
    return tempCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 1)
    {
        SettingViewController* vc = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:vc];
    }
}
@end
