//
//  HomePageViewController.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/21.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "HomePageViewController.h"
#import "UICollectionView+Cell.h"
#import "MatchingCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "StartMatchingCollectionViewCell.h"
@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger selectIdx;
@property (nonatomic,assign) NSInteger selectSex;
@property (nonatomic,strong) NSMutableArray* arrayItems;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"快速匹配大神";
    [self addNavigationView];
    self.title = @"首页";
    [self hiddenBackBtn:YES];
    self.selectSex = 1;
    self.selectIdx = -1;
    self.arrayItems = [[NSMutableArray alloc] init];
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"close1frm_pic2j" forKey:@"image"];
        [dic setObject:@"王者荣耀" forKey:@"title"];
        [dic setObject:@(YES) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"close1frm_pic3" forKey:@"image"];
        [dic setObject:@"和平精英" forKey:@"title"];
        [dic setObject:@(YES) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"close1frm_wz" forKey:@"image"];
        [dic setObject:@"英雄联盟" forKey:@"title"];
        [dic setObject:@(YES) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"close1frm_cj" forKey:@"image"];
        [dic setObject:@"绝地求生" forKey:@"title"];
        [dic setObject:@(YES) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@"yuyinliao" forKey:@"image"];
        [dic setObject:@"语音聊天" forKey:@"title"];
        [dic setObject:@(YES) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    {
        NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
        [dic setObject:@" " forKey:@"image"];
        [dic setObject:@" " forKey:@"title"];
        [dic setObject:@(NO) forKey:@"op"];
        [self.arrayItems addObject:dic];
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView LoadCell:@"MatchingCollectionViewCell"];
    [self.collectionView LoadCell:@"StartMatchingCollectionViewCell"];
    [self.collectionView LoadCell:@"HeaderCollectionReusableView"];
    self.selectIdx = -1;

    [self.collectionView setAllowsSelection:NO];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
//    [self addRefreshLoading];
}
//- (void)addRefreshLoading{
//    @weakify(self);
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        @strongify(self);
//        [self loadData];
//    }];
//    self.collectionView.mj_footer.hidden = YES;
//}
//- (void)loadData{
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH,60};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderCollectionReusableView* view = [collectionView reUseCell:@"HeaderCollectionReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [view.imgIcon setImage:[UIImage imageNamed:@"chose1frm_pic1"]];
        view.lbTitle.text = @"选择想玩的游戏";
    }else{
        [view.imgIcon setImage:[UIImage imageNamed:@"close1frm_head"]];
        view.lbTitle.text = @"选择陪玩的性别";
    }
    return view;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0)
        return 6;
    else
        return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return CGSizeMake(SCREEN_WIDTH/3,50);
    else
        return CGSizeMake(SCREEN_WIDTH,150);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MatchingCollectionViewCell* cell = [collectionView reUseCell:@"MatchingCollectionViewCell" forIndexPath:indexPath];
        
        cell.block = ^{
            if ([self.arrayItems[indexPath.row][@"op"] boolValue] != YES) {
                return;
            }
            self.selectIdx = indexPath.row;
            [self.collectionView reloadData];
        };
        if (self.selectIdx == indexPath.row) {
            cell.lbTitle.textColor = [UIColor whiteColor];
            cell.backView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:cell.backView.size direction:IHGradientChangeDirectionLevel startColor:BLUE_LEFT endColor:BLUE_RIGHT];
        }
        else{
            cell.lbTitle.textColor = [UIColor blackColor];
            cell.backView.backgroundColor = [UIColor whiteColor];
        }
        cell.lbTitle.text = self.arrayItems[indexPath.row][@"title"];
        [cell.imgIcon setImage:[UIImage imageNamed:self.arrayItems[indexPath.row][@"image"]]];
        return cell;
    }else{
        StartMatchingCollectionViewCell* cell = [collectionView reUseCell:@"StartMatchingCollectionViewCell" forIndexPath:indexPath];
        cell.matchBlock = ^{
            if (self.selectIdx == -1) {
                [self showHint:@"请选择您想玩的游戏"];
                [self.collectionView.mj_header endRefreshing];
                return;
            }
            [NetworkRequest GET:@"/app/Yindao/kepipei"
                     parameters:@{@"token":[UserInfo shareInstance].userModel.token,
                                  @"sex":@(self.selectSex),
                                  @"game":@(self.selectIdx + 1)
                     }
                        success:^(NetWorkResponseModel * _Nullable responseModel) {
                [self.collectionView.mj_header endRefreshing];
                self.tabBarController.selectedIndex = 1;
            } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
                [self.collectionView.mj_header endRefreshing];
                if ([responseModel.code integerValue] == -2) {
                    [self showHint:@"账号在其他设备登录"];
                    [UserInfo userLogout];
                }
            }];
        };
        cell.clickboy = ^{
            self.selectSex = 2;
        };
        cell.clickGirl = ^{
            self.selectSex = 1;
        };
        return cell;
    }
}


@end
