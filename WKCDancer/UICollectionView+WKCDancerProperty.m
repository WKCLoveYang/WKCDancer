//
//  UICollectionView+WKCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UICollectionView+WKCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const WKCDancerCollectionViewPropertyAnimationType = @"wkc.collectionView.animationType";
static NSString * const WKCDancerCollectionViewPropertyReload = @"wkc.collectionView.reload";
static NSString * const WKCDancerCollectionViewPropertyTransition = @"wkc.collectionView.transition";
static NSString * const WKCDancerCollectionViewPropertySpring = @"wkc.collectionView.spring";
static NSString * const WKCDancerCollectionViewPropertyItemDuration = @"wkc.collectionView.itemDuration";
static NSString * const WKCDancerCollectionViewPropertyItemDelay = @"wkc.collectionView.itemDelay";
static NSString * const WKCDancerCollectionViewPropertyIndexPath = @"wkc.collectionView.indexPath";
static NSString * const WKCDancerCollectionViewPropertyTransitionTo = @"wkc.collectionView.transition.to";
static NSString * const WKCDancerCollectionViewPropertyTransitionAnimation = @"wkc.collectionView.transition.animation";
static NSString * const WKCDancerCollectionViewPropertyHeader = @"wkc.collectionView.header";
static NSString * const WKCDancerCollectionViewPropertyFooter = @"wkc.collectionView.footer";



@implementation UICollectionView (WKCDancerProperty)

- (void)setWkc_collectionView_animationType:(UIViewAnimationOptions)wkc_collectionView_animationType
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyAnimationType, @(wkc_collectionView_animationType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_collectionView_animationType
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyAnimationType) integerValue];
}




- (void)setWkc_collectionView_reload:(WKCCollectionReloadType)wkc_collectionView_reload
{
   objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyReload, @(wkc_collectionView_reload), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCCollectionReloadType)wkc_collectionView_reload
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyReload) integerValue];
}




- (void)setWkc_collectionView_transition:(WKCCollectionTransition)wkc_collectionView_transition
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyTransition, @(wkc_collectionView_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCCollectionTransition)wkc_collectionView_transition
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyTransition) integerValue];
}




- (void)setWkc_collectionView_spring:(BOOL)wkc_collectionView_spring
{
  objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertySpring, @(wkc_collectionView_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_collectionView_spring
{
   return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertySpring) boolValue];
}





- (void)setWkc_collectionView_itemDuration:(NSTimeInterval)wkc_collectionView_itemDuration
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyItemDuration, [NSString stringWithFormat:@"%f",wkc_collectionView_itemDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_collectionView_itemDuration
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyItemDuration) doubleValue];
}




- (void)setWkc_collectionView_itemDelay:(NSTimeInterval)wkc_collectionView_itemDelay
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyItemDelay, [NSString stringWithFormat:@"%f",wkc_collectionView_itemDelay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_collectionView_itemDelay
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyItemDelay) doubleValue];
}




- (void)setWkc_collectionView_indexPath:(NSIndexPath *)wkc_collectionView_indexPath
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyIndexPath, wkc_collectionView_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)wkc_collectionView_indexPath
{
    return objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyIndexPath);
}




- (void)setWkc_collectionView_transition_to:(UIView *)wkc_collectionView_transition_to
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyTransitionTo, wkc_collectionView_transition_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)wkc_collectionView_transition_to
{
   return objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyTransitionTo);
}




- (void)setWkc_collectionView_transitionAnimation:(UIViewAnimationOptions)wkc_collectionView_transitionAnimation
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyTransitionAnimation, @(wkc_collectionView_transitionAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_collectionView_transitionAnimation
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyTransitionAnimation) integerValue];
}



- (void)setWkc_collectionView_isHeaderDancer:(BOOL)wkc_collectionView_isHeaderDancer
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyHeader, @(wkc_collectionView_isHeaderDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_collectionView_isHeaderDancer
{
    return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyHeader) boolValue];
}





- (void)setWkc_collectionView_isFooterDancer:(BOOL)wkc_collectionView_isFooterDancer
{
    objc_setAssociatedObject(self, &WKCDancerCollectionViewPropertyFooter, @(wkc_collectionView_isFooterDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_collectionView_isFooterDancer
{
   return [objc_getAssociatedObject(self, &WKCDancerCollectionViewPropertyFooter) boolValue];
}

@end
