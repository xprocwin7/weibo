//
//  XPFriendsCollectionController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "UserInfoViewController.h"
#import "XPFriendsCollectionController.h"
#import "XPUser.h"
#import "UserCell.h"
@interface XPFriendsCollectionController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *friends;
@end

@implementation XPFriendsCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建流式布局对象
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:fl];
    self.collectionView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.6];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [XPWeiboUtils requestFriendsWithCallback:^(id obj) {
        
        self.friends = obj;
        [self.collectionView reloadData];
        
    }];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kMargen, kMargen, 0, kMargen);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return (kScreenWidth-4*80)/5.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return (kScreenWidth-4*80)/5.0;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.friends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.user = self.friends[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoViewController *vc = [UserInfoViewController new];
    
    vc.user = self.friends[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
