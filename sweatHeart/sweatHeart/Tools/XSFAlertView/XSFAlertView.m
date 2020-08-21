//
//  XSFAlertView.m
//  XSF
//
//  Created by duck on 16/11/11.
//  Copyright © 2016年 Xsf Technology Co.,Ltd. All rights reserved.
//

#import "XSFAlertView.h"
#include "KGModal.h"
#import "ImageView+Loading.h"
#define POPVIEW_WIDTH   154
#define HALF_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width/2
#define HALF_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height/2



@interface XSFAlertView ()<UITextFieldDelegate>
@property (nonatomic, strong) ClickBlock        confirmBlock;
@property (nonatomic, strong) ClickBlock        closeBlock;
@property (nonatomic, strong) ClickBlock        gotoBalanceCenter;
@property (nonatomic, strong) clickTextValue    passwordBlock;
@property (nonatomic, strong) clickTextValue    moneyBlock;
@property (nonatomic, strong) UIButton*         btnConfirm;
@property (nonatomic, strong) UITextField*      tfPassword;
@property (nonatomic, strong) UITextField*      tfMoney;
@property (nonatomic, strong) NSTimer           *timer;                 //计时器
@end

@implementation XSFAlertView
+ (XSFAlertView*)sharedInstance{
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
+ (void)alertViewReset
{
    [self sharedInstance].confirmBlock  = nil;
    [[self sharedInstance].view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self sharedInstance].view.layer.masksToBounds  = NO;
    [self sharedInstance].view.layer.cornerRadius   = 0;
    [self sharedInstance].btnConfirm = nil;
    [self sharedInstance].tfPassword = nil;
    [self sharedInstance].passwordBlock = nil;
    [self sharedInstance].moneyBlock = nil;
    
    KGModal *Modal              = [KGModal sharedInstance];
    Modal.tapOutsideToDismiss   = YES;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
    [self sharedInstance].view.frame    = CGRectMake(0, 0, POPVIEW_WIDTH, POPVIEW_WIDTH);
}
+ (void)alertInit
{
    [self sharedInstance].view.frame                = CGRectMake(0, 0, POPVIEW_WIDTH, POPVIEW_WIDTH);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 5;
    [self killTimer];
}
+ (void)killTimer{
    [[self sharedInstance].timer invalidate];
    [self sharedInstance].timer = nil;
}
+ (void)beginTimer{
    [self sharedInstance].timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [[self sharedInstance].timer fire];
}
+ (void)hiddenTimer{
    [self sharedInstance].timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(hiddenHub) userInfo:nil repeats:YES];
    [[self sharedInstance].timer fire];
}


+(void)tapImage{
    if ([self sharedInstance].confirmBlock) {
        [self sharedInstance].confirmBlock();
    }
    KGModal *Modal=[KGModal sharedInstance];
    [Modal hideAnimated:YES];
}
+ (void)clickCloseBtn:(UIButton*)sender{
    KGModal *Modal=[KGModal sharedInstance];
    [Modal hideAnimated:YES];
}
+ (void)textFieldDidChange:(UITextField *)textField{
//    textField.text = [PublicTool checkTextFeild:textField];
    if(textField.keyboardType == UIKeyboardTypeASCIICapable)
    {
        if (textField.text.length == 0) {
            [self sharedInstance].btnConfirm.backgroundColor = [UIColor colorWithRGB:0xDADBE3];
            [self sharedInstance].btnConfirm.userInteractionEnabled = NO;
        }
        else{
            [self sharedInstance].btnConfirm.backgroundColor = APP_COLOR;
            [self sharedInstance].btnConfirm.userInteractionEnabled = YES;
        }
    }else if(textField.keyboardType == UIKeyboardTypeDecimalPad){
        if (textField.text.length == 0) {
            [self sharedInstance].btnConfirm.backgroundColor = [UIColor colorWithRGB:0xDADBE3];
            [self sharedInstance].btnConfirm.userInteractionEnabled = NO;
        }
        else{
            [self sharedInstance].btnConfirm.backgroundColor = APP_COLOR;
            [self sharedInstance].btnConfirm.userInteractionEnabled = YES;
        }
    }
}

+(void)clickConfirm{
    if ([self sharedInstance].passwordBlock) {
        [self sharedInstance].passwordBlock([self sharedInstance].tfPassword.text);
    }
    [self hiddenHub];
}

+(void)clickBeforeGiveBack{
    if ([self sharedInstance].confirmBlock) {
        [self sharedInstance].confirmBlock();
    }
    [self hiddenHub];
}
+(void)clickBalanceConfirm{
    if ([self sharedInstance].gotoBalanceCenter) {
        [self sharedInstance].gotoBalanceCenter();
    }
    [self hiddenHub];
}
+(void)clickMyAssetsConfirm{
    if ([self sharedInstance].moneyBlock) {
        [self sharedInstance].moneyBlock([self sharedInstance].tfMoney.text);
    }
    [self hiddenHub];
}
+(void)showMyAssetsOperation:(clickTextValue)moneyBlock{
    [self alertViewReset];
    [self alertInit];
    
    [self sharedInstance].moneyBlock             = moneyBlock;
    [self sharedInstance].view.frame                = CGRectMake(0, 0, 302, 314);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 8;
    
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectMake([self sharedInstance].view.width - 36, 24, 12, 12)];
    [btnClose setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [btnClose setImage:[UIImage imageNamed:@"popup_close_icon"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(hiddenHub) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:btnClose];
    
    UILabel* lbContent            = [UILabel new];
    lbContent.textAlignment       = NSTextAlignmentCenter;
    lbContent.numberOfLines       = 0;
    lbContent.textColor           = [UIColor darkTextColor];
    lbContent.text                = NSLocalizedString(@"请输入数额", nil);
    lbContent.font                = [UIFont systemFontOfSize:15];
    [[self sharedInstance].view addSubview:lbContent];
    lbContent.frame               = CGRectMake(25, 68, [self sharedInstance].view.width - 50, 24);
    
    [self sharedInstance].tfMoney = [[UITextField alloc] initWithFrame:CGRectMake(25, lbContent.bottom + 42, lbContent.width, 20)];
    [[self sharedInstance].tfMoney addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self sharedInstance].tfMoney.placeholder = NSLocalizedString(@"请输入数额", nil);
    [self sharedInstance].tfMoney.keyboardType = UIKeyboardTypeDecimalPad;
    [self sharedInstance].tfMoney.textAlignment = NSTextAlignmentCenter;
    [[self sharedInstance].view addSubview:[self sharedInstance].tfMoney];
    
    UILabel* lbSubContent            = [UILabel new];
    lbSubContent.textAlignment       = NSTextAlignmentLeft;
    lbSubContent.numberOfLines       = 0;
    lbSubContent.text                = NSLocalizedString(@"划拨出去部分不再享有持币分红", nil);
    lbSubContent.font                = [UIFont systemFontOfSize:12];
    lbSubContent.textColor           = [UIColor colorWithRGB:0xBBBBBB];
    [[self sharedInstance].view addSubview:lbSubContent];
    lbSubContent.frame               = CGRectMake(41,
                                                  [self sharedInstance].tfMoney.bottom + 55,
                                                  [self sharedInstance].view.width - 50,
                                                  24);
    
    UIImageView* imageTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_explain_icon"]];
    imageTag.centerY = lbSubContent.centerY;
    imageTag.left = lbSubContent.left - 17;
    [[self sharedInstance].view addSubview:imageTag];
    
    [self sharedInstance].btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(25,
                                                                                  lbSubContent.bottom + 14,
                                                                                  lbContent.width,
                                                                                  42)];
    [self sharedInstance].btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [self sharedInstance].btnConfirm.layer.masksToBounds = YES;
    [self sharedInstance].btnConfirm.layer.cornerRadius = 2;
    [self sharedInstance].btnConfirm.userInteractionEnabled = NO;
    [[self sharedInstance].btnConfirm setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
    [[self sharedInstance].btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self sharedInstance].btnConfirm.backgroundColor = [UIColor colorWithRGB:0xDADBE3];
    [[self sharedInstance].btnConfirm addTarget:self action:@selector(clickMyAssetsConfirm) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:[self sharedInstance].btnConfirm];
    
    KGModal *Modal                   = [KGModal sharedInstance];
    Modal.bNeedShadow                = YES;
    Modal.tapOutsideToDismiss        = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}
+(void)showPayPassword:(clickTextValue)passwordBlock{
    [self alertViewReset];
    [self alertInit];
    
    [self sharedInstance].passwordBlock             = passwordBlock;
    [self sharedInstance].view.frame                = CGRectMake(0, 0, 302, 234);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 8;
    
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectMake([self sharedInstance].view.width - 36, 24, 12, 12)];
    [btnClose setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [btnClose setImage:[UIImage imageNamed:@"popup_close_icon"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(hiddenHub) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:btnClose];
    
    UILabel* lbContent            = [UILabel new];
    lbContent.textAlignment       = NSTextAlignmentCenter;
    lbContent.numberOfLines       = 0;
    lbContent.text                = NSLocalizedString(@"请输入支付密码", nil);
    lbContent.font                = [UIFont systemFontOfSize:15];
    lbContent.textColor           = UIColor.blackColor;
    [[self sharedInstance].view addSubview:lbContent];
    lbContent.frame               = CGRectMake(25, 30, [self sharedInstance].view.width - 50, 24);
    
    [self sharedInstance].tfPassword = [[UITextField alloc] initWithFrame:CGRectMake(25, lbContent.bottom + 42, lbContent.width, 20)];
    [[self sharedInstance].tfPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self sharedInstance].tfPassword.placeholder = NSLocalizedString(@"请输入支付密码", nil);
    [self sharedInstance].tfPassword.textColor = UIColor.blackColor;
    [self sharedInstance].tfPassword.keyboardType = UIKeyboardTypeASCIICapable;
    [self sharedInstance].tfPassword.secureTextEntry = YES;
    [self sharedInstance].tfPassword.textAlignment = NSTextAlignmentCenter;
    [[self sharedInstance].view addSubview:[self sharedInstance].tfPassword];
    
    [self sharedInstance].btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(25, [self sharedInstance].tfPassword.bottom + 44, lbContent.width, 42)];
    [self sharedInstance].btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [self sharedInstance].btnConfirm.layer.masksToBounds = YES;
    [self sharedInstance].btnConfirm.layer.cornerRadius = 2;
    [self sharedInstance].btnConfirm.userInteractionEnabled = NO;
    [[self sharedInstance].btnConfirm setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
    [[self sharedInstance].btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self sharedInstance].btnConfirm.backgroundColor = [UIColor colorWithRGB:0xDADBE3];
    [[self sharedInstance].btnConfirm addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:[self sharedInstance].btnConfirm];
    
    KGModal *Modal=[KGModal sharedInstance];
    Modal.bNeedShadow                = YES;
    Modal.tapOutsideToDismiss        = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}
+(void)showBalanceNotEnough:(void(^)(void))balanceBlock withShowType:(NSInteger)type{
    [self alertViewReset];
    [self alertInit];
    
    [self sharedInstance].gotoBalanceCenter         = balanceBlock;
    [self sharedInstance].view.frame                = CGRectMake(0, 0, 302, 334);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 8;
    
    UIImageView* imageNotice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_s_img"]];
    imageNotice.centerX = [self sharedInstance].view.centerX;
    imageNotice.top = 56.f;
    [[self sharedInstance].view addSubview:imageNotice];
    
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectMake([self sharedInstance].view.width - 36, 24, 12, 12)];
    [btnClose setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [btnClose setImage:[UIImage imageNamed:@"popup_close_icon"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(hiddenHub) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:btnClose];
    
    UILabel* lbContent            = [UILabel new];
    lbContent.textAlignment       = NSTextAlignmentCenter;
    lbContent.numberOfLines       = 0;
    lbContent.text                = NSLocalizedString(@"您的余额不足", nil);
    lbContent.textColor           = [UIColor colorWithRGB:0x333333];
    lbContent.font                = [UIFont systemFontOfSize:18];
    [[self sharedInstance].view addSubview:lbContent];
    lbContent.frame               = CGRectMake(25, imageNotice.bottom + 40, [self sharedInstance].view.width - 50, 24);
    
    UILabel* lbSubContent            = [UILabel new];
    lbSubContent.textAlignment       = NSTextAlignmentCenter;
    lbSubContent.numberOfLines       = 0;
    lbSubContent.text                = type == 1?NSLocalizedString(@"请去充值，方可继续购买", nil):NSLocalizedString(@"积分余额不足，请使用USDT购买", nil);
    lbSubContent.textColor           = [UIColor colorWithRGB:0x777777];
    lbSubContent.font                = [UIFont systemFontOfSize:14];
    [[self sharedInstance].view addSubview:lbSubContent];
    lbSubContent.frame               = CGRectMake(25, lbContent.bottom + 12, [self sharedInstance].view.width - 50, 24);
    if (type == 1) {
        [self sharedInstance].btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(25, lbSubContent.bottom + 40, lbContent.width, 42)];
        [self sharedInstance].btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15];
        [self sharedInstance].btnConfirm.layer.masksToBounds = YES;
        [self sharedInstance].btnConfirm.layer.cornerRadius = 2;
        [[self sharedInstance].btnConfirm setTitle:NSLocalizedString(@"去充值", nil) forState:UIControlStateNormal];
        [[self sharedInstance].btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self sharedInstance].btnConfirm.backgroundColor = APP_COLOR;
        [[self sharedInstance].btnConfirm addTarget:self action:@selector(clickBalanceConfirm) forControlEvents:UIControlEventTouchUpInside];
        [[self sharedInstance].view addSubview:[self sharedInstance].btnConfirm];
    }
    
    
    KGModal *Modal                   = [KGModal sharedInstance];
    Modal.bNeedShadow                = YES;
    Modal.tapOutsideToDismiss        = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}
+(void)showBeforeGiveBackConfirm:(void(^)(void))confirmBlock{
    [self alertViewReset];
    [self alertInit];
    
    [self sharedInstance].confirmBlock         = confirmBlock;
    [self sharedInstance].view.frame                = CGRectMake(0, 0, 302, 334);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 8;
    
    UIImageView* imageNotice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_s_img"]];
    imageNotice.centerX = [self sharedInstance].view.centerX;
    imageNotice.top = 72.f;
    [[self sharedInstance].view addSubview:imageNotice];
    
    UIButton* btnClose = [[UIButton alloc] initWithFrame:CGRectMake([self sharedInstance].view.width - 36, 24, 12, 12)];
    [btnClose setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [btnClose setImage:[UIImage imageNamed:@"popup_close_icon"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(hiddenHub) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:btnClose];
    
    UILabel* lbContent            = [UILabel new];
    lbContent.textAlignment       = NSTextAlignmentCenter;
    lbContent.numberOfLines       = 0;
    lbContent.text                = NSLocalizedString(@"是否确定提前还款", nil);
    lbContent.textColor           = [UIColor colorWithRGB:0x333333];
    lbContent.font                = [UIFont systemFontOfSize:18];
    [[self sharedInstance].view addSubview:lbContent];
    lbContent.frame               = CGRectMake(25, imageNotice.bottom + 40, [self sharedInstance].view.width - 50, 24);
    
//    UILabel* lbSubContent            = [UILabel new];
//    lbSubContent.textAlignment       = NSTextAlignmentCenter;
//    lbSubContent.numberOfLines       = 0;
//    lbSubContent.text                = NSLocalizedString(@"请去充值，方可继续购买", nil);
//    lbSubContent.textColor           = [UIColor colorWithRGB:0x777777];
//    lbSubContent.font                = [UIFont systemFontOfSize:14];
//    [[self sharedInstance].view addSubview:lbSubContent];
//    lbSubContent.frame               = CGRectMake(25, lbContent.bottom + 12, [self sharedInstance].view.width - 50, 24);
    
    [self sharedInstance].btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(25, lbContent.bottom + 40 + 16, lbContent.width, 42)];
    [self sharedInstance].btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [self sharedInstance].btnConfirm.layer.masksToBounds = YES;
    [self sharedInstance].btnConfirm.layer.cornerRadius = 2;
    [[self sharedInstance].btnConfirm setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [[self sharedInstance].btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self sharedInstance].btnConfirm.backgroundColor = APP_COLOR;
    [[self sharedInstance].btnConfirm addTarget:self action:@selector(clickBeforeGiveBack) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:[self sharedInstance].btnConfirm];
    
    KGModal *Modal                   = [KGModal sharedInstance];
    Modal.bNeedShadow                = YES;
    Modal.tapOutsideToDismiss        = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}
+(void)showImageUrl:(NSString*)imageUrl withCloseBlock:(void(^)(void))closeBlock clickJumpLink:(void(^)(void))confirm{
    [self alertViewReset];
    [self alertInit];
    
    [self sharedInstance].view.frame    = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self sharedInstance].view.backgroundColor = [UIColor clearColor];
    [self sharedInstance].closeBlock        = closeBlock;
    [self sharedInstance].confirmBlock      = confirm;
    
    UIImageView* imageView    = [[UIImageView alloc] initWithFrame:CGRectMake(HALF_SCREEN_WIDTH - AUTOSIZE_HEIGHT(288)/2,[self sharedInstance].view.frame.size.height  / 2 - AUTOSIZE_HEIGHT(386)/2, AUTOSIZE_HEIGHT(288), AUTOSIZE_HEIGHT(386))];

    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer * PrivateLetterTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
    PrivateLetterTap.numberOfTouchesRequired = 1; //手指数
    PrivateLetterTap.numberOfTapsRequired = 1; //tap次数
    [imageView addGestureRecognizer:PrivateLetterTap];
    [imageView LoadImage:imageUrl PlaceholderImageName:@"img_default"];
    [[self sharedInstance].view addSubview:imageView];
    
    CGFloat closeBtnOriginY = SCREEN_HEIGHT - 41 - 73;
    if (imageView.bottom <= closeBtnOriginY) {
        closeBtnOriginY = imageView.bottom + 20;
    }
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2-20.5, closeBtnOriginY, 41, 41)];
    [closeBtn setImage:[UIImage imageNamed:@"home_popup_ic_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedInstance].view addSubview:closeBtn];
    
    KGModal *Modal=[KGModal sharedInstance];
    Modal.bNeedShadow                = NO;
    Modal.tapOutsideToDismiss = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}

+(void)showAlertView:(NSString*)title
        leftBtnTitle:(NSString*)leftTitle
       rightBtnTitle:(NSString*)rightTitle
           leftBlock:(void(^)(void))left
          rightBlock:(void(^)(void))right
{
    [self alertViewReset];
    [self alertInit];
    [self sharedInstance].closeBlock     = left;
    [self sharedInstance].confirmBlock    = right;
    
    [self sharedInstance].view.frame                = CGRectMake(0, 0, 280, 170);
    [self sharedInstance].view.backgroundColor      = [UIColor whiteColor];
    [self sharedInstance].view.layer.masksToBounds  = YES;
    [self sharedInstance].view.layer.cornerRadius   = 8;
    
    UILabel* lbContent            = [UILabel new];
    lbContent.textAlignment       = NSTextAlignmentCenter;
    lbContent.numberOfLines       = 0;
    lbContent.text                =   title;
    lbContent.font                = [UIFont systemFontOfSize:15];
    [[self sharedInstance].view addSubview:lbContent];
    lbContent.frame               = CGRectMake(25, 15, 250, [self sharedInstance].view.frame.size.height - 48 - 15);
    
    [self addTwoBtnWithLeftTitle:leftTitle selector:@selector(clickLeftBtn) RightTitle:rightTitle selector:@selector(clickRightBtn)];
    
    KGModal *Modal=[KGModal sharedInstance];
    Modal.bNeedShadow                = YES;
    Modal.tapOutsideToDismiss        = NO;
    [Modal showWithContentView:[self sharedInstance].view andAnimated:YES];
}
/**
 * 弹窗中绘制位于底部的按钮和横线
 */
+ (void)addTwoBtnWithLeftTitle:(NSString*)leftTitle selector:(SEL)actionL RightTitle:(NSString*)rightTitle selector:(SEL)actionR
{
//    [self addBtnFGLineTwo];
    UIButton* btnLeft           = [UIButton new];
    [btnLeft setTitle:leftTitle forState:UIControlStateNormal];
    [btnLeft addTarget:self action:actionL forControlEvents:UIControlEventTouchUpInside];
    btnLeft.frame           = CGRectMake(21, [self sharedInstance].view.frame.size.height - 27 - 37, 109, 37);
    btnLeft.layer.masksToBounds = YES;
    [btnLeft setTitleColor:[UIColor colorWithRGB:0x03A0ff] forState:UIControlStateNormal];
    btnLeft.layer.cornerRadius = 16.5;
    btnLeft.layer.borderColor = [[UIColor colorWithRGB:0x03A0ff] CGColor];
    btnLeft.layer.borderWidth = 1;
    [[self sharedInstance].view addSubview:btnLeft];
    
    
    UIButton* btnRight              = [UIButton new];
    [btnRight setTitle:rightTitle forState:UIControlStateNormal];
    [btnRight addTarget:self action:actionR forControlEvents:UIControlEventTouchUpInside];
    
    btnRight.frame           = CGRectMake([self sharedInstance].view.frame.size.width - 21 - 109, [self sharedInstance].view.frame.size.height - 27 - 37, 109, 37);
    btnRight.layer.masksToBounds = YES;
    btnRight.layer.cornerRadius = 16.5;
    
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnRight.backgroundColor = [UIColor colorWithRGB:0x03A0ff];
    [[self sharedInstance].view addSubview:btnRight];
}
+ (void)hiddenHub{
    KGModal *Modal=[KGModal sharedInstance];
    [self killTimer];
    [Modal hideAnimated:YES];
}
+(void)clickLeftBtn
{
    if([self sharedInstance].closeBlock)
        [self sharedInstance].closeBlock();
    KGModal *Modal=[KGModal sharedInstance];
    [Modal hideAnimated:YES];
}
+ (void)clickRightBtn
{
    if([self sharedInstance].confirmBlock)
        [self sharedInstance].confirmBlock();
    KGModal *Modal=[KGModal sharedInstance];
    [Modal hideAnimated:YES];
}
@end

