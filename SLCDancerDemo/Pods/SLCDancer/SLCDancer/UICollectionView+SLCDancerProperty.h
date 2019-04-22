//
//  UICollectionView+SLCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLCCollectionReloadType) {
    SLCCollectionReloadTypeVisible = 0,
    SLCCollectionReloadTypeFixed
};

typedef NS_ENUM(NSInteger, SLCCollectionTransition) {
    SLCCollectionTransitionNone = 0,
    SLCCollectionTransitionContent,
    SLCCollectionTransitionFrom
};


@interface UICollectionView (SLCDancerProperty)

@property (nonatomic, assign, readwrite) UIViewAnimationOptions slc_collectionView_animationType;

@property (nonatomic, assign, readwrite) SLCCollectionReloadType slc_collectionView_reload;

@property (nonatomic, assign, readwrite) SLCCollectionTransition slc_collectionView_transition;

@property (nonatomic, assign, readwrite) BOOL slc_collectionView_spring;

@property (nonatomic, assign, readwrite) NSTimeInterval slc_collectionView_itemDuration;

@property (nonatomic, assign, readwrite) NSTimeInterval slc_collectionView_itemDelay;

@property (nonatomic, strong, readwrite) NSIndexPath * slc_collectionView_indexPath;

@property (nonatomic, strong, readwrite) UIView * slc_collectionView_transition_to;

@property (nonatomic, assign, readwrite) UIViewAnimationOptions slc_collectionView_transitionAnimation;

@property (nonatomic, assign, readwrite) BOOL slc_collectionView_isHeaderDancer;

@property (nonatomic, assign, readwrite) BOOL slc_collectionView_isFooterDancer;

@end
