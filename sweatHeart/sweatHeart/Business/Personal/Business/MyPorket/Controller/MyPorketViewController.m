//
//  MyPorketViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/29.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "MyPorketViewController.h"
#import "RechargeViewController.h"
@interface MyPorketViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnRecharge;

@end

@implementation MyPorketViewController
- (IBAction)clickRecharge:(id)sender {
    RechargeViewController* vc = [[RechargeViewController alloc] init];
    [self.navigationController pushViewController:vc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的钱包";
    [self addNavigationView];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    
    self.backView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.backView.size direction:IHGradientChangeDirectionLevel startColor:RED_LEFT endColor:RED_RIGHT];
    
    self.lbMoney.text = [NSString stringWithFormat:@"%.2f",[[UserInfo shareInstance].userModel.money floatValue]];
    self.btnRecharge.layer.masksToBounds = YES;
    self.btnRecharge.layer.cornerRadius = 15;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
