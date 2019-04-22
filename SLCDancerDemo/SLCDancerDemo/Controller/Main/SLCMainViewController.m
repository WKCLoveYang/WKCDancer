//
//  ViewController.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCMainViewController.h"
#import "SLCMainModel.h"
#import "SLCMainCollectionViewCell.h"
#import "SLCDancerViewController.h"
#import "SLCDancerTransitionViewController.h"
#import "SLCDancerCollectionViewController.h"
#import "SLCDancerTableViewController.h"

NSArray <NSDictionary *>* slc_mainDataSource()
{
    return @[
             @{
                 @"title": @"Make",
                 @"detail": @"Function MAKE, based on the center",
                 @"bgImage": @"main_bg_make.jpg"
                 },
             @{
                 @"title": @"Take",
                 @"detail": @"Function TAKE, based on the boundary (parameter repeat is unavailable)",
                 @"bgImage": @"main_bg_take.jpg"
                 },
             @{
                 @"title": @"Move",
                 @"detail": @"Function MOVE , relative movement (based on the center)",
                 @"bgImage": @"main_bg_move.jpg"
                 },
             @{
                 @"title": @"Add",
                 @"detail": @"Function ADD , relative movement (based on the boundary). (parameter repeat is unavailable)",
                 @"bgImage": @"main_bg_add.jpg"
                 },
             @{
                 @"title": @"Path",
                 @"detail": @"Path animation",
                 @"bgImage": @"main_bg_path.jpg"
                 },
             @{
                 @"title": @"Transition",
                 @"detail": @"Transition animation",
                 @"bgImage": @"main_bg_tra.jpg"
                 },
             @{
                 @"title": @"CollectionView",
                 @"detail": @"CollectionView animation",
                 @"bgImage": @"main_bg_make.jpg"
                 },
             @{
                 @"title": @"TableView",
                 @"detail": @"TableView animation",
                 @"bgImage": @"main_bg_take.jpg"
                 }
             ];
}


@interface SLCMainViewController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <SLCMainModel *>* dataSource;
@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation SLCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"SLCDancer";
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.collectionView];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}



#pragma mark -UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLCMainCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SLCMainCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * title = self.dataSource[indexPath.row].title;
    if ([title isEqualToString:@"Transition"])
    {
        SLCDancerTransitionViewController * transitionVC = [[SLCDancerTransitionViewController alloc] init];
        [self.navigationController pushViewController:transitionVC animated:YES];
    }
    else if ([title isEqualToString:@"CollectionView"])
    {
        SLCDancerCollectionViewController * collectionVC = [[SLCDancerCollectionViewController alloc] init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
    else if ([title isEqualToString:@"TableView"])
    {
        SLCDancerTableViewController * tableVC = [[SLCDancerTableViewController alloc] init];
        [self.navigationController pushViewController:tableVC animated:YES];
    }
    else
    {
        SLCDancerViewController * dancerVC = [[SLCDancerViewController alloc] initWithTitle:title];
        [self.navigationController pushViewController:dancerVC animated:YES];
    }
    
}


- (NSArray<SLCMainModel *> *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [SLCMainModel mj_objectArrayWithKeyValuesArray:slc_mainDataSource()];
    }
    return _dataSource;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_bg"]];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.layer.masksToBounds = YES;
    }
    return _bgImageView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.itemSize = [SLCMainCollectionViewCell itemSize];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundView = nil;
        _collectionView.backgroundColor = nil;
        _collectionView.contentInset = UIEdgeInsetsMake(20, 20, 30, 20);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SLCMainCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SLCMainCollectionViewCell class])];
    }
    return _collectionView;
}

@end
