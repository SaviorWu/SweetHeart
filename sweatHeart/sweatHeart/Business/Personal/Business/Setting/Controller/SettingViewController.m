//
//  SettingViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/28.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingtableViewCell.h"
#import "ChangePswdViewController.h"
#import "HelpViewController.h"
#import "LogoutTableViewCell.h"
#import "FeedBackViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
    [self addNavigationView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView LoadCell:@"SettingtableViewCell"];
    [self.tableView LoadCell:@"LogoutTableViewCell"];
    [self.tableView reloadData];
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
    if (indexPath.row == 4) {
        LogoutTableViewCell* tvCell = [tableView reUseCell:@"LogoutTableViewCell"];
        tvCell.block = ^{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"点击了确定按钮");
                [UserInfo userLogout];
            }];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }];
            [alertVc addAction:cancle];
            [alertVc addAction:confirm];
            [self presentViewController:alertVc animated:YES completion:^{
                nil;
            }];
            
        };
        cell = tvCell;
    }else{
        SettingtableViewCell *tvCell = [tableView reUseCell:@"SettingtableViewCell"];
        if (indexPath.row == 0) {
            tvCell.lbTitle.text = @"修改密码";
        }else if(indexPath.row == 1){
            tvCell.lbTitle.text = @"支付密码";
        }else if(indexPath.row == 2){
            tvCell.lbTitle.text = @"帮助";
        }else if(indexPath.row == 3){
            tvCell.lbTitle.text = @"产品反馈";
        }
        cell = tvCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0)
    {
        ChangePswdViewController* vc = [[ChangePswdViewController alloc] init];
        vc.changeType = 1;
        [self.navigationController pushViewController:vc];
    }else if(indexPath.row == 1)
    {
        ChangePswdViewController* vc = [[ChangePswdViewController alloc] init];
        vc.changeType = 2;
        [self.navigationController pushViewController:vc];
    }else if(indexPath.row == 2){
        HelpViewController * vc = [[HelpViewController alloc] init];
        [self.navigationController pushViewController:vc];
    }else{
        FeedBackViewController* vc = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:vc];
    }
}
@end
