//
//  UICollectionView+SLCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UICollectionView+SLCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const SLCDancerCollectionViewPropertyAnimationType = @"slc.collectionView.animationType";
static NSString * const SLCDancerCollectionViewPropertyReload = @"slc.collectionView.reload";
static NSString * const SLCDancerCollectionViewPropertyTransition = @"slc.collectionView.transition";
static NSString * const SLCDancerCollectionViewPropertySpring = @"slc.collectionView.spring";
static NSString * const SLCDancerCollectionViewPropertyItemDuration = @"slc.collectionView.itemDuration";
static NSString * const SLCDancerCollectionViewPropertyItemDelay = @"slc.collectionView.itemDelay";
static NSString * const SLCDancerCollectionViewPropertyIndexPath = @"slc.collectionView.indexPath";
static NSString * const SLCDancerCollectionViewPropertyTransitionTo = @"slc.collectionView.transition.to";
static NSString * const SLCDancerCollectionViewPropertyTransitionAnimation = @"slc.collectionView.transition.animation";
static NSString * const SLCDancerCollectionViewPropertyHeader = @"slc.collectionView.header";
static NSString * const SLCDancerCollectionViewPropertyFooter = @"slc.collectionView.footer";



@implementation UICollectionView (SLCDancerProperty)

- (void)setSlc_collectionView_animationType:(UIViewAnimationOptions)slc_collectionView_animationType
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyAnimationType, @(slc_collectionView_animationType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_collectionView_animationType
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyAnimationType) integerValue];
}




- (void)setSlc_collectionView_reload:(SLCCollectionReloadType)slc_collectionView_reload
{
   objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyReload, @(slc_collectionView_reload), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCCollectionReloadType)slc_collectionView_reload
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyReload) integerValue];
}




- (void)setSlc_collectionView_transition:(SLCCollectionTransition)slc_collectionView_transition
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyTransition, @(slc_collectionView_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCCollectionTransition)slc_collectionView_transition
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyTransition) integerValue];
}




- (void)setSlc_collectionView_spring:(BOOL)slc_collectionView_spring
{
  objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertySpring, @(slc_collectionView_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_collectionView_spring
{
   return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertySpring) boolValue];
}





- (void)setSlc_collectionView_itemDuration:(NSTimeInterval)slc_collectionView_itemDuration
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyItemDuration, [NSString stringWithFormat:@"%f",slc_collectionView_itemDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_collectionView_itemDuration
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyItemDuration) doubleValue];
}




- (void)setSlc_collectionView_itemDelay:(NSTimeInterval)slc_collectionView_itemDelay
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyItemDelay, [NSString stringWithFormat:@"%f",slc_collectionView_itemDelay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_collectionView_itemDelay
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyItemDelay) doubleValue];
}




- (void)setSlc_collectionView_indexPath:(NSIndexPath *)slc_collectionView_indexPath
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyIndexPath, slc_collectionView_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)slc_collectionView_indexPath
{
    return objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyIndexPath);
}




- (void)setSlc_collectionView_transition_to:(UIView *)slc_collectionView_transition_to
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyTransitionTo, slc_collectionView_transition_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)slc_collectionView_transition_to
{
   return objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyTransitionTo);
}




- (void)setSlc_collectionView_transitionAnimation:(UIViewAnimationOptions)slc_collectionView_transitionAnimation
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyTransitionAnimation, @(slc_collectionView_transitionAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_collectionView_transitionAnimation
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyTransitionAnimation) integerValue];
}



- (void)setSlc_collectionView_isHeaderDancer:(BOOL)slc_collectionView_isHeaderDancer
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyHeader, @(slc_collectionView_isHeaderDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_collectionView_isHeaderDancer
{
    return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyHeader) boolValue];
}





- (void)setSlc_collectionView_isFooterDancer:(BOOL)slc_collectionView_isFooterDancer
{
    objc_setAssociatedObject(self, &SLCDancerCollectionViewPropertyFooter, @(slc_collectionView_isFooterDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_collectionView_isFooterDancer
{
   return [objc_getAssociatedObject(self, &SLCDancerCollectionViewPropertyFooter) boolValue];
}

@end
