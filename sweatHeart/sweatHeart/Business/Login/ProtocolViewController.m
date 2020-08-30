//
//  ProtocolViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/27.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tvContent;

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.title;
    [self addNavigationView];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.content  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:15.0f] } documentAttributes:nil error:nil];
    self.tvContent.attributedText = attrStr;//用于显示
    
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
