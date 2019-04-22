//
//  UITableView+SLCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UITableView+SLCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const SLCDancerTableViewPropertyAnimationType = @"slc.tableView.animationType";
static NSString * const SLCDancerTableViewPropertyReload = @"slc.tableView.reload";
static NSString * const SLCDancerTableViewPropertyTransition = @"slc.tableView.transition";
static NSString * const SLCDancerTableViewPropertySpring = @"slc.tableView.spring";
static NSString * const SLCDancerTableViewPropertyItemDuration = @"slc.tableView.itemDuration";
static NSString * const SLCDancerTableViewPropertyItemDelay = @"slc.tableView.itemDelay";
static NSString * const SLCDancerTableViewPropertyIndexPath = @"slc.tableView.indexPath";
static NSString * const SLCDancerTableViewPropertyTransitionTo = @"slc.tableView.transition.to";
static NSString * const SLCDancerTableViewPropertyTransitionAnimation = @"slc.tableView.transition.animation";
static NSString * const SLCDancerTableViewPropertyHeader = @"slc.tableView.header";
static NSString * const SLCDancerTableViewPropertyFooter = @"slc.tableView.footer";


@implementation UITableView (SLCDancerProperty)

- (void)setSlc_tableView_animationType:(UIViewAnimationOptions)slc_tableView_animationType
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyAnimationType, @(slc_tableView_animationType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_tableView_animationType
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyAnimationType) integerValue];
}




- (void)setSlc_tableView_reload:(SLCTableViewReloadType)slc_tableView_reload
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyReload, @(slc_tableView_reload), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCTableViewReloadType)slc_tableView_reload
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyReload) integerValue];
}





- (void)setSlc_tableView_transition:(SLCTableViewTransition)slc_tableView_transition
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyTransition, @(slc_tableView_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCTableViewTransition)slc_tableView_transition
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyTransition) integerValue];
}





- (void)setSlc_tableView_spring:(BOOL)slc_tableView_spring
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertySpring, @(slc_tableView_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_tableView_spring
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertySpring) boolValue];
}




- (void)setSlc_tableView_itemDuration:(NSTimeInterval)slc_tableView_itemDuration
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyItemDuration, [NSString stringWithFormat:@"%f", slc_tableView_itemDuration], OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)slc_tableView_itemDuration
{
   return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyItemDuration) doubleValue];
}




- (void)setSlc_tableView_itemDelay:(NSTimeInterval)slc_tableView_itemDelay
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyItemDelay, @(slc_tableView_itemDelay), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_tableView_itemDelay
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyItemDelay) doubleValue];
}



- (void)setSlc_tableView_indexPath:(NSIndexPath *)slc_tableView_indexPath
{
   objc_setAssociatedObject(self, &SLCDancerTableViewPropertyIndexPath, slc_tableView_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)slc_tableView_indexPath
{
    return objc_getAssociatedObject(self, &SLCDancerTableViewPropertyIndexPath);
}





- (void)setSlc_tableView_transition_to:(UIView *)slc_tableView_transition_to
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyTransitionTo, slc_tableView_transition_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)slc_tableView_transition_to
{
    return objc_getAssociatedObject(self, &SLCDancerTableViewPropertyTransitionTo);
}




- (void)setSlc_tableView_transitionAnimation:(UIViewAnimationOptions)slc_tableView_transitionAnimation
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyTransitionAnimation, @(slc_tableView_transitionAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_tableView_transitionAnimation
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyTransitionAnimation) integerValue];
}




- (void)setSlc_tableView_isHeaderDancer:(BOOL)slc_tableView_isHeaderDancer
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyHeader, @(slc_tableView_isHeaderDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_tableView_isHeaderDancer
{
    return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyHeader) boolValue];
}




- (void)setSlc_tableView_isFooterDancer:(BOOL)slc_tableView_isFooterDancer
{
    objc_setAssociatedObject(self, &SLCDancerTableViewPropertyFooter, @(slc_tableView_isFooterDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_tableView_isFooterDancer
{
   return [objc_getAssociatedObject(self, &SLCDancerTableViewPropertyFooter) boolValue];
}

@end
