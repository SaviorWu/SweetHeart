//
//  ForgetPasswordViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/25.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCheckCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPswd;
@property (nonatomic, strong) NSTimer    *timer;
@property (nonatomic, assign)NSInteger    count;
@end

@implementation ForgetPasswordViewController
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
    self.title = @"忘记密码";
    [self addNavigationView];
    self.btnReset.layer.masksToBounds = YES;
    self.btnReset.layer.cornerRadius = 25;
}
- (IBAction)clickCheckCode:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else{
        self.count = 60;
        [self startimer];
    }
}
- (IBAction)clickReset:(id)sender {
    if (self.tfPhoneNumber.text.length == 0) {
        [self showHint:@"请输入手机号码"];
    }else if (self.tfPswd.text.length == 0) {
        [self showHint:@"请输入密码"];
    }else if (self.tfCheckCode.text.length == 0) {
        [self showHint:@"请输入验证码"];
    }else if(![PublicTool judgePassWord:self.tfPswd.text]){
        [self showHint:@"密码格式不正确"];
    }else{
        
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
