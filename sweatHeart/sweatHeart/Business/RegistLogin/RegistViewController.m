//
//  RegistViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/21.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "RegistViewController.h"
#import "ProtocolViewController.h"
#import "AppDelegate.h"
@interface RegistViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCheckCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPswd;
@property (weak, nonatomic) IBOutlet UITextField *tfPswdConfirm;
@property (nonatomic, strong) NSTimer    *timer;
@property (nonatomic, assign)NSInteger    count;
@end

@implementation RegistViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopTimer];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self addNavigationView];
    self.btnRegist.layer.masksToBounds = YES;
    self.btnRegist.layer.cornerRadius = 25;
    self.btnRegist.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnRegist.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
}
- (IBAction)clickLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickCheckCode:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else{
        [self showHudInView:self.view];
        [NetworkRequest GET:@"/app/userverify/sendVirefy"
                 parameters:@{@"mobile":self.tfPhoneNumber.text,
                              @"type":@"register"
                 }
                    success:^(NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            self.count = 60;
            [self startimer];
        } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
        }];
    }
}
- (IBAction)clickRegist:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else if (self.tfPswd.text.length == 0) {
        [self showHint:@"请输入密码"];
    }else if (self.tfCheckCode.text.length == 0) {
        [self showHint:@"请输入验证码"];
    }else if (self.tfPswdConfirm.text.length == 0){
        [self showHint:@"请输入确认密码"];
    }else if(![self.tfPswdConfirm.text isEqualToString:self.tfPswd.text]){
        [self showHint:@"两次输入密码不一致"];
    }else if(![PublicTool judgePassWord:self.tfPswd.text]){
        [self showHint:@"密码格式不正确"];
    }else{
        [self showHudInView:self.view];
        [NetworkRequest GET:@"/app/users/registered"
                 parameters:@{@"mobile":self.tfPhoneNumber.text,
                              @"verify":self.tfCheckCode.text,
                              @"password":[PublicTool base64EncodeString:self.tfPswd.text],
                            @"passwordAg":[PublicTool base64EncodeString:self.tfPswdConfirm.text]
                 } success:^(NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
            
            [UserInfo shareInstance].userModel = [UserInfoModel modelWithJSON:responseModel.data[@"info"]];
            [UserInfo shareInstance].userModel.token = responseModel.data[@"token"];
            
            NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
            [userdefault setObject:[UserInfo shareInstance].userModel.token forKey:@"token"];
            [userdefault setObject:[UserInfo shareInstance].userModel.uid forKey:@"uid"];
            [userdefault synchronize];
            
            [((AppDelegate *)([UIApplication sharedApplication].delegate)) showHomePage];
            
        } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
            [self hideAllHudFromSuperView:self.view];
            [self showHint:responseModel.msg];
        }];
    }
}
- (IBAction)clickProtocol:(id)sender {
    [NetworkRequest GET:@"/app/users/agreement"
             parameters:@{} success:^(NetWorkResponseModel * _Nullable responseModel) {
        ProtocolViewController* vc = [[ProtocolViewController alloc] init];
        vc.title = @"用户协议";
        vc.content = responseModel.data;
        [self.navigationController pushViewController:vc];
    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        [self showHint:responseModel.msg];
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

@end
