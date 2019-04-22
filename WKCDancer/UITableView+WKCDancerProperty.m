//
//  UITableView+WKCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UITableView+WKCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const WKCDancerTableViewPropertyAnimationType = @"wkc.tableView.animationType";
static NSString * const WKCDancerTableViewPropertyReload = @"wkc.tableView.reload";
static NSString * const WKCDancerTableViewPropertyTransition = @"wkc.tableView.transition";
static NSString * const WKCDancerTableViewPropertySpring = @"wkc.tableView.spring";
static NSString * const WKCDancerTableViewPropertyItemDuration = @"wkc.tableView.itemDuration";
static NSString * const WKCDancerTableViewPropertyItemDelay = @"wkc.tableView.itemDelay";
static NSString * const WKCDancerTableViewPropertyIndexPath = @"wkc.tableView.indexPath";
static NSString * const WKCDancerTableViewPropertyTransitionTo = @"wkc.tableView.transition.to";
static NSString * const WKCDancerTableViewPropertyTransitionAnimation = @"wkc.tableView.transition.animation";
static NSString * const WKCDancerTableViewPropertyHeader = @"wkc.tableView.header";
static NSString * const WKCDancerTableViewPropertyFooter = @"wkc.tableView.footer";


@implementation UITableView (WKCDancerProperty)

- (void)setWkc_tableView_animationType:(UIViewAnimationOptions)wkc_tableView_animationType
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyAnimationType, @(wkc_tableView_animationType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_tableView_animationType
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyAnimationType) integerValue];
}




- (void)setWkc_tableView_reload:(WKCTableViewReloadType)wkc_tableView_reload
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyReload, @(wkc_tableView_reload), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCTableViewReloadType)wkc_tableView_reload
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyReload) integerValue];
}





- (void)setWkc_tableView_transition:(WKCTableViewTransition)wkc_tableView_transition
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyTransition, @(wkc_tableView_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCTableViewTransition)wkc_tableView_transition
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyTransition) integerValue];
}





- (void)setWkc_tableView_spring:(BOOL)wkc_tableView_spring
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertySpring, @(wkc_tableView_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_tableView_spring
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertySpring) boolValue];
}




- (void)setWkc_tableView_itemDuration:(NSTimeInterval)wkc_tableView_itemDuration
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyItemDuration, [NSString stringWithFormat:@"%f", wkc_tableView_itemDuration], OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)wkc_tableView_itemDuration
{
   return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyItemDuration) doubleValue];
}




- (void)setWkc_tableView_itemDelay:(NSTimeInterval)wkc_tableView_itemDelay
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyItemDelay, @(wkc_tableView_itemDelay), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_tableView_itemDelay
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyItemDelay) doubleValue];
}



- (void)setWkc_tableView_indexPath:(NSIndexPath *)wkc_tableView_indexPath
{
   objc_setAssociatedObject(self, &WKCDancerTableViewPropertyIndexPath, wkc_tableView_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)wkc_tableView_indexPath
{
    return objc_getAssociatedObject(self, &WKCDancerTableViewPropertyIndexPath);
}





- (void)setWkc_tableView_transition_to:(UIView *)wkc_tableView_transition_to
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyTransitionTo, wkc_tableView_transition_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)wkc_tableView_transition_to
{
    return objc_getAssociatedObject(self, &WKCDancerTableViewPropertyTransitionTo);
}




- (void)setWkc_tableView_transitionAnimation:(UIViewAnimationOptions)wkc_tableView_transitionAnimation
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyTransitionAnimation, @(wkc_tableView_transitionAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_tableView_transitionAnimation
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyTransitionAnimation) integerValue];
}




- (void)setWkc_tableView_isHeaderDancer:(BOOL)wkc_tableView_isHeaderDancer
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyHeader, @(wkc_tableView_isHeaderDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_tableView_isHeaderDancer
{
    return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyHeader) boolValue];
}




- (void)setWkc_tableView_isFooterDancer:(BOOL)wkc_tableView_isFooterDancer
{
    objc_setAssociatedObject(self, &WKCDancerTableViewPropertyFooter, @(wkc_tableView_isFooterDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_tableView_isFooterDancer
{
   return [objc_getAssociatedObject(self, &WKCDancerTableViewPropertyFooter) boolValue];
}

@end
