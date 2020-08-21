//
//  BaseViewController.m
//  ALD
//
//  Created by friend on 2019/8/13.
//  Copyright © 2019 friend. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong) UIButton* btnBack;
@end

@implementation BaseViewController

#pragma 翻译当前页面的所有文案为系统指定的语言,建议子类都要实现此方法
- (void)translateTextInView{
    
}
- (BOOL)isIphoneX{
    if (@available(iOS 11.0, *)) {
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        if (window.safeAreaInsets.bottom > 0.0) return YES;
        else return NO;
    }
    else return NO;
}
- (void)hiddenBackBtn:(BOOL)bHidden{
    self.btnBack.hidden = bHidden;
}
- (void)clickBack{
    [self.navigationController popViewController];
}
- (void)addNavigationView{
    self.vwNavigation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT + STATUS_BAR_HEIGHT)];
    self.vwNavigation.backgroundColor = APP_COLOR;
    
    UILabel* lbTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    lbTitle.text = self.title;
    [lbTitle sizeToFit];
    lbTitle.bottom = self.vwNavigation.bottom - 11.f;
    lbTitle.centerX = SCREEN_WIDTH/2.f;
    lbTitle.textColor = [UIColor whiteColor];
    
    self.btnBack = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, 10, 18)];
    [self.btnBack setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    [self.btnBack setImage:[UIImage imageNamed:@"nav_btn_w_back"] forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.btnBack.centerY = lbTitle.centerY;
    [self.vwNavigation addSubview:self.btnBack];
    [self.vwNavigation addSubview:lbTitle];
    [self.view addSubview:self.vwNavigation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self translateTextInView];
    NSLog(@"%@",[self className]);
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
