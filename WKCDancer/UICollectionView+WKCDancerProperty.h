//
//  UICollectionView+WKCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKCCollectionReloadType) {
    WKCCollectionReloadTypeVisible = 0,
    WKCCollectionReloadTypeFixed
};

typedef NS_ENUM(NSInteger, WKCCollectionTransition) {
    WKCCollectionTransitionNone = 0,
    WKCCollectionTransitionContent,
    WKCCollectionTransitionFrom
};


@interface UICollectionView (WKCDancerProperty)

@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_collectionView_animationType;

@property (nonatomic, assign, readwrite) WKCCollectionReloadType wkc_collectionView_reload;

@property (nonatomic, assign, readwrite) WKCCollectionTransition wkc_collectionView_transition;

@property (nonatomic, assign, readwrite) BOOL wkc_collectionView_spring;

@property (nonatomic, assign, readwrite) NSTimeInterval wkc_collectionView_itemDuration;

@property (nonatomic, assign, readwrite) NSTimeInterval wkc_collectionView_itemDelay;

@property (nonatomic, strong, readwrite) NSIndexPath * wkc_collectionView_indexPath;

@property (nonatomic, strong, readwrite) UIView * wkc_collectionView_transition_to;

@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_collectionView_transitionAnimation;

@property (nonatomic, assign, readwrite) BOOL wkc_collectionView_isHeaderDancer;

@property (nonatomic, assign, readwrite) BOOL wkc_collectionView_isFooterDancer;

@end
