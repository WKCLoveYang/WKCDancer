//
//  SLCDancerViewController.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCDancerViewController.h"
#import "SLCDancerCollectionViewCell.h"

NSArray <NSNumber *>* slc_makeDataSource()
{
    return @[
             @(SLCDancerMakeSize),
             @(SLCDancerMakePosition),
             @(SLCDancerMakeX),
             @(SLCDancerMakeY),
             @(SLCDancerMakeWidth),
             @(SLCDancerMakeHeight),
             @(SLCDancerMakeScale),
             @(SLCDancerMakeScaleX),
             @(SLCDancerMakeScaleY),
             @(SLCDancerMakeRotationX),
             @(SLCDancerMakeRotationY),
             @(SLCDancerMakeRotationZ),
             @(SLCDancerMakeBackground),
             @(SLCDancerMakeOpacity),
             @(SLCDancerMakeCornerRadius),
             @(SLCDancerMakeBorderWidth)
             ];
}

NSArray <NSNumber *>* slcTakeDataSource()
{
    return @[
             @(SLCDancerTakeFrame),
             @(SLCDancerTakeLeading),
             @(SLCDancerTakeTraing),
             @(SLCDancerTakeTop),
             @(SLCDancerTakeBottom),
             @(SLCDancerTakeWidth),
             @(SLCDancerTakeHeight),
             @(SLCDancerTakeSize)
             ];
}

NSArray <NSNumber *>* slcMoveDataSource()
{
    return @[
             @(SLCDancerMoveX),
             @(SLCDancerMoveY),
             @(SLCDancerMoveXY),
             @(SLCDancerMoveWidth),
             @(SLCDancerMoveHeight),
             @(SLCDancerMoveSize)
             ];
}

NSArray <NSNumber *>* slcAddDataSource()
{
    return @[
             @(SLCDancerAddLeading),
             @(SLCDancerAddTraing),
             @(SLCDancerAddTop),
             @(SLCDancerAddBottom),
             @(SLCDancerAddWidth),
             @(SLCDancerAddHeight),
             @(SLCDancerAddSize)
             ];
}

NSArray <NSNumber *>* slcPathDataSource()
{
    return @[@(SLCDancerPath)];
}

@interface SLCDancerViewController ()
<UICollectionViewDelegateFlowLayout,
UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView * bgImageView;
@property (nonatomic, copy) NSString * mtitle;

@property (nonatomic, strong) NSArray <NSNumber *> * dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation SLCDancerViewController

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init])
    {
        _mtitle = title;
        
        if ([title isEqualToString:@"Make"])
        {
            self.dataSource = slc_makeDataSource();
        }
        else if ([title isEqualToString:@"Take"])
        {
            self.dataSource = slcTakeDataSource();
        }
        else if ([title isEqualToString:@"Move"])
        {
            self.dataSource = slcMoveDataSource();
        }
        else if ([title isEqualToString:@"Add"])
        {
            self.dataSource = slcAddDataSource();
        }
        else if ([title isEqualToString:@"Path"])
        {
            self.dataSource = slcPathDataSource();
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = _mtitle;
    
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource.count == 1 ? [SLCDancerCollectionViewCell itemSizePlus] : [SLCDancerCollectionViewCell itemSize];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLCDancerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SLCDancerCollectionViewCell class]) forIndexPath:indexPath];
    cell.dancer = self.dataSource[indexPath.row].integerValue;
    return cell;
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
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundView = nil;
        _collectionView.backgroundColor = nil;
        _collectionView.contentInset = UIEdgeInsetsMake(20, 20, 30, 20);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SLCDancerCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SLCDancerCollectionViewCell class])];
    }
    return _collectionView;
}


@end
