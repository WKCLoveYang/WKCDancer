//
//  SLCMainCollectionViewCell.h
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLCMainModel;

NS_ASSUME_NONNULL_BEGIN

@interface SLCMainCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SLCMainModel * model;

+ (CGSize)itemSize;

@end

NS_ASSUME_NONNULL_END
