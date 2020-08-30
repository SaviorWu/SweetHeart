//
//  FeedBackViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/30.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tvFeedBack;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *lbTag;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title  =@"产品反馈";
    [self addNavigationView];
    self.btnSubmit.layer.masksToBounds = YES;
    self.btnSubmit.layer.cornerRadius = 25;
    self.btnSubmit.backgroundColor = [UIColor bm_colorGradientChangeWithSize:self.btnSubmit.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
    self.tvFeedBack.delegate = self;
}
- (IBAction)clickSubmit:(id)sender {
    if (self.tvFeedBack.text.length < 4) {
        [self showHint:@"留言内容太短，请再说点吧"];
        return;
    }
    [NetworkRequest GET:@"/app/news/feedback"
             parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                          @"feedback":self.tvFeedBack.text
             } success:^(NetWorkResponseModel * _Nullable responseModel) {
        [self showHint:responseModel.msg];
        self.tvFeedBack.text = @"";
    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
        [self showHint:responseModel.msg];
        self.tvFeedBack.text = @"";
        if ([responseModel.code integerValue] == -2) {
            [self showHint:@"账号在其他设备登录"];
            [UserInfo userLogout];
        }
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
        self.lbTag.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.lbTag.hidden = NO;
    }else{
        self.lbTag.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.lbTag.hidden = NO;
    }else{
        self.lbTag.hidden = YES;
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
