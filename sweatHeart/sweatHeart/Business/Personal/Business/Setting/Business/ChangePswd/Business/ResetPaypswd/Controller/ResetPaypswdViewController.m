//
//  ResetPaypswdViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/29.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "ResetPaypswdViewController.h"
#import "SettingViewController.h"
@interface ResetPaypswdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfSetPaypswd;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirnPswd;
@property (weak, nonatomic) IBOutlet UIButton *btnResetPswd;

@end

@implementation ResetPaypswdViewController
- (IBAction)clickReset:(id)sender {
    if (self.tfSetPaypswd.text.length == 0 || self.tfConfirnPswd.text.length == 0) {
        [self showHint:@"请输入密码"];
    }else if(![self.tfSetPaypswd.text isEqualToString:self.tfConfirnPswd.text]){
        [self showHint:@"两次输入密码不同"];
    }else{
        [self showHudInView:self.view];
        [NetworkRequest GET:@"/app/users/replace_pay_password"
                 parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                              @"pay_password":[PublicTool base64EncodeString:self.tfSetPaypswd.text],
                              @"pay_passwordAg":[PublicTool base64EncodeString:self.tfConfirnPswd.text]
                 } success:^(NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
            for (BaseViewController* vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[SettingViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
            [self.navigationController popViewController];
        } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
            if ([responseModel.code integerValue] == -2) {
                [self showHint:@"账号在其他设备登录"];
                [UserInfo userLogout];
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改支付密码";
    [self addNavigationView];
    self.btnResetPswd.layer.masksToBounds = YES;
    self.btnResetPswd.layer.cornerRadius = 25;
    self.btnResetPswd.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnResetPswd.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
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
