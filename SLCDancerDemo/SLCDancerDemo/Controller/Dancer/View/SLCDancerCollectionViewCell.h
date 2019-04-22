//
//  SLCDancerCollectionViewCell.h
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLCDancerCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) SLCDancer dancer;

+ (CGSize)itemSize;

+ (CGSize)itemSizePlus;

@end

NS_ASSUME_NONNULL_END
