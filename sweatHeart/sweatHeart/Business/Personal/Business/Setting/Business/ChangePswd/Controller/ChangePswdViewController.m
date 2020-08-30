//
//  ChangePswdViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/28.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "ChangePswdViewController.h"
#import "ResetPaypswdViewController.h"
#import "AppDelegate.h"
@interface ChangePswdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCheckCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPswd;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckCode;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (nonatomic, strong) NSTimer    *timer;
@property (nonatomic, assign)NSInteger    count;
@end

@implementation ChangePswdViewController
- (IBAction)clickConfirm:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else if (self.tfCheckCode.text.length == 0){
        [self showHint:@"请输入验证码"];
    }else if (self.tfPswd.text.length == 0){
        [self showHint:@"请输入密码"];
    }else{
        [self showHudInView:self.view];
        [NetworkRequest GET:self.changeType == 1?@"/app/users/update_password":@"/app/users/resetPre"
                 parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                              @"mobile":self.tfPhoneNumber.text,
                              @"verify":self.tfCheckCode.text,
                              @"password":[PublicTool base64EncodeString:self.tfPswd.text]
                 } success:^(NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
            if (self.changeType != 1) {
                ResetPaypswdViewController * vc = [[ResetPaypswdViewController alloc] init];
                [self.navigationController pushViewController:vc];
            }else{
                [UserInfo userLogout];
            }
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
    if (self.changeType == 1) {
        self.title = @"修改登录密码";
        self.tfPhoneNumber.placeholder = @"请输入手机号";
        self.tfCheckCode.placeholder = @"请输入验证码";
        self.tfPhoneNumber.placeholder = @"请输入新密码";
        [self.btnConfirm setTitle:@"重置密码" forState:UIControlStateNormal];
    }
    else{
        self.title = @"修改支付密码";
        self.tfPhoneNumber.placeholder = @"请输入注册手机号";
        self.tfCheckCode.placeholder = @"请输入接收验证码";
        self.tfPhoneNumber.placeholder = @"请输入登录的密码";
        [self.btnConfirm setTitle:@"下一步" forState:UIControlStateNormal];
    }
    [self addNavigationView];
    self.btnConfirm.layer.masksToBounds = YES;
    self.btnConfirm.layer.cornerRadius = 25;
    self.btnConfirm.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnConfirm.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
}
- (IBAction)clickCheckCode:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else{
        [self showHudInView:self.view];
        [NetworkRequest GET:@"/app/userverify/sendVirefy"
                 parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                              @"mobile":self.tfPhoneNumber.text,
                              @"type":self.changeType == 1?@"resetverify":@"resetverify"
                 }
                    success:^(NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            self.count = 60;
            [self startimer];
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
-(NSTimer*)timer{
    if (!_timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(configerData) userInfo:nil repeats:YES];
    }
    return _timer;
}

//开始计时
-(void)startimer{
    [self.timer fire];
    self.btnCheckCode.userInteractionEnabled = NO;
}
//暂停并销毁
-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)configerData{
    self.count --;
    [self.btnCheckCode setTitle:[NSString stringWithFormat:@"重新获取%lds",(long)self.count] forState:UIControlStateNormal];
    if (self.count == 0) {
        [self.btnCheckCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.btnCheckCode.userInteractionEnabled = YES;
        [self stopTimer];
        self.count = 0;
    }
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
