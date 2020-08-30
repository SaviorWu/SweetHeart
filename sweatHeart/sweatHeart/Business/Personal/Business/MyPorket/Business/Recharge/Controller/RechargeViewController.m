//
//  RechargeViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/29.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()
@property (nonatomic,assign) NSInteger selectIdx;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fifthView;
@property (weak, nonatomic) IBOutlet UIView *sixthView;
@property (weak, nonatomic) IBOutlet UIButton *btnRecharge;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstContent;
@property (weak, nonatomic) IBOutlet UILabel *lbSecondTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSecondContent;
@property (weak, nonatomic) IBOutlet UILabel *lbThirdTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbThirdContent;
@property (weak, nonatomic) IBOutlet UILabel *lbFourthTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFourthContent;
@property (weak, nonatomic) IBOutlet UILabel *lbFifthTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFifthContent;
@property (weak, nonatomic) IBOutlet UILabel *lbSixthTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSixthContent;
@property (weak, nonatomic) IBOutlet UILabel *lbBalance;

@end

@implementation RechargeViewController
- (void)initViews
{
    self.selectIdx = 0;
    self.firstView.layer.masksToBounds = YES;
    self.firstView.layer.cornerRadius = 5;
    self.firstView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.firstView.layer.borderWidth = 1;
    
    self.secondView.layer.masksToBounds = YES;
    self.secondView.layer.cornerRadius = 5;
    self.secondView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.secondView.layer.borderWidth = 1;
    
    self.thirdView.layer.masksToBounds = YES;
    self.thirdView.layer.cornerRadius = 5;
    self.thirdView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.thirdView.layer.borderWidth = 1;
    
    self.fourthView.layer.masksToBounds = YES;
    self.fourthView.layer.cornerRadius = 5;
    self.fourthView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.fourthView.layer.borderWidth = 1;
    
    self.fifthView.layer.masksToBounds = YES;
    self.fifthView.layer.cornerRadius = 5;
    self.fifthView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.fifthView.layer.borderWidth = 1;
    
    self.sixthView.layer.masksToBounds = YES;
    self.sixthView.layer.cornerRadius = 5;
    self.sixthView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    self.sixthView.layer.borderWidth = 1;
    
    self.btnRecharge.layer.masksToBounds = YES;
    self.btnRecharge.layer.cornerRadius = 20;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"充值";
    [self addNavigationView];
    [self initViews];
    self.lbBalance.text = [NSString stringWithFormat:@"%.2f币",[[UserInfo shareInstance].userModel.money floatValue]];
}
- (void)selectView:(UIView*)backView withTitle:(UILabel*)lbTitle withContent:(UILabel*)lbContent
{
    backView.layer.borderColor = [[UIColor colorWithRGB:0x52A7FF] CGColor];
    backView.backgroundColor = [UIColor colorWithRGB:0xECF5FF];
    lbTitle.textColor = [UIColor colorWithRGB:0x52A7FF];
    lbContent.textColor = [UIColor colorWithRGB:0x52A7FF];
}
- (void)unSelectView:(UIView*)backView withTitle:(UILabel*)lbTitle withContent:(UILabel*)lbContent
{
    backView.layer.borderColor = [[UIColor colorWithRGB:0xe0e0e0] CGColor];
    backView.backgroundColor = [UIColor whiteColor];
    lbTitle.textColor = [UIColor blackColor];
    lbContent.textColor = [UIColor lightGrayColor];
}
- (IBAction)clickFirst:(id)sender {
    self.selectIdx = 1;
    [self selectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self unSelectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self unSelectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self unSelectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self unSelectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self unSelectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickSecond:(id)sender {
    self.selectIdx = 2;
    [self unSelectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self selectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self unSelectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self unSelectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self unSelectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self unSelectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickThrid:(id)sender {
    self.selectIdx = 3;
    [self unSelectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self unSelectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self selectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self unSelectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self unSelectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self unSelectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickFourth:(id)sender {
    self.selectIdx = 4;
    [self unSelectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self unSelectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self unSelectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self selectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self unSelectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self unSelectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickFifth:(id)sender {
    self.selectIdx = 5;
    [self unSelectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self unSelectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self unSelectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self unSelectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self selectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self unSelectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickSixth:(id)sender {
    self.selectIdx = 6;
    [self unSelectView:self.firstView withTitle:self.lbFirstTitle withContent:self.lbFirstContent];
    [self unSelectView:self.secondView withTitle:self.lbSecondTitle withContent:self.lbSecondContent];
    [self unSelectView:self.thirdView withTitle:self.lbThirdTitle withContent:self.lbThirdContent];
    [self unSelectView:self.fourthView withTitle:self.lbFourthTitle withContent:self.lbFourthContent];
    [self unSelectView:self.fifthView withTitle:self.lbFifthTitle withContent:self.lbFifthContent];
    [self selectView:self.sixthView withTitle:self.lbSixthTitle withContent:self.lbSixthContent];
}
- (IBAction)clickRecharge:(id)sender {
    if (self.selectIdx == 0) {
        [self showHint:@"请选择一个充值金额"];
        return;
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
