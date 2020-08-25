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
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"快速匹配大神";
    [self addNavigationView];
    self.title = @"首页";
    [self hiddenBackBtn:YES];
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
    [self addRefreshLoading];
    
    [self.collectionView.mj_header beginRefreshing];
}
- (void)addRefreshLoading{
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadData];
    }];
    self.collectionView.mj_footer.hidden = YES;
}
- (void)loadData{
    [self.collectionView.mj_header endRefreshing];
}
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH,60};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderCollectionReusableView* view = [collectionView reUseCell:@"HeaderCollectionReusableView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
//        [view.imgIcon setImage:[UIImage imageNamed:@""]];
        view.lbTitle.text = @"选择想玩的游戏";
    }else{
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
        return CGSizeMake(SCREEN_WIDTH/3,60);
    else
        return CGSizeMake(SCREEN_WIDTH,150);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MatchingCollectionViewCell* cell = [collectionView reUseCell:@"MatchingCollectionViewCell" forIndexPath:indexPath];
        cell.userInteractionEnabled = YES;
        if (self.selectIdx == indexPath.row) {
            cell.backgroundColor = [UIColor blueColor];
        }
        else{
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }else{
        StartMatchingCollectionViewCell* cell = [collectionView reUseCell:@"StartMatchingCollectionViewCell" forIndexPath:indexPath];
        cell.matchBlock = ^{
            self.tabBarController.selectedIndex = 1;
        };
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        self.selectIdx = indexPath.row;
        [self.collectionView reloadData];
    }
}

@end
