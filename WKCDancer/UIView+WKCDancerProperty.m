//
//  UIView+WKCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIView+WKCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const WKCDancerViewPropertyDelay = @"wkc.view.property.delay";
static NSString * const WKCDancerViewPropertyRepeat = @"wkc.view.property.repeat";
static NSString * const WKCDancerViewPropertyReverse = @"wkc.view.property.reverse";
static NSString * const WKCDancerViewPropertyAnimationDuration = @"wkc.view.property.animateDuration";
static NSString * const WKCDancerViewPropertyFrom = @"wkc.view.property.from";
static NSString * const WKCDancerViewPropertyTo = @"wkc.view.property.to";
static NSString * const WKCDancerViewPropertyTheDancer = @"wkc.view.property.theDancer";
static NSString * const WKCDancerViewPropertyEaseType = @"wkc.view.property.easeType";
static NSString * const WKCDancerViewPropertySpring = @"wkc.view.property.spring";
static NSString * const WKCDancerViewPropertyTransition = @"wkc.view.property.transition";
static NSString * const WKCDancerViewPropertyOptions = @"wkc.view.property.options";

@implementation UIView (WKCDancerProperty)

- (void)setWkc_view_delay:(NSTimeInterval)wkc_view_delay
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyDelay, [NSString stringWithFormat:@"%f", wkc_view_delay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_view_delay
{
   return [objc_getAssociatedObject(self, &WKCDancerViewPropertyDelay) doubleValue];
}





- (void)setWkc_view_repeat:(NSInteger)wkc_view_repeat
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyRepeat, [NSString stringWithFormat:@"%ld", wkc_view_repeat], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)wkc_view_repeat
{
   return [objc_getAssociatedObject(self, &WKCDancerViewPropertyRepeat) integerValue];
}





- (void)setWkc_view_reverse:(BOOL)wkc_view_reverse
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyReverse, @(wkc_view_reverse), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_view_reverse
{
   return [objc_getAssociatedObject(self, &WKCDancerViewPropertyReverse) boolValue];
}





- (void)setWkc_view_animateDuration:(NSTimeInterval)wkc_view_animateDuration
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyAnimationDuration, [NSString stringWithFormat:@"%f", wkc_view_animateDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_view_animateDuration
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertyAnimationDuration) doubleValue];
}





- (void)setWkc_view_from:(id)wkc_view_from
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyFrom, wkc_view_from, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)wkc_view_from
{
    return objc_getAssociatedObject(self, &WKCDancerViewPropertyFrom);
}



- (void)setWkc_view_to:(id)wkc_view_to
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyTo, wkc_view_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)wkc_view_to
{
   return objc_getAssociatedObject(self, &WKCDancerViewPropertyTo);
}




- (void)setWkc_view_theDancer:(WKCDancer)wkc_view_theDancer
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyTheDancer, @(wkc_view_theDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCDancer)wkc_view_theDancer
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertyTheDancer) integerValue];
}




- (void)setWkc_view_easeType:(WKCViewEaseType)wkc_view_easeType
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyEaseType, @(wkc_view_easeType), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCViewEaseType)wkc_view_easeType
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertyEaseType) integerValue];
}





- (void)setWkc_view_spring:(BOOL)wkc_view_spring
{
   objc_setAssociatedObject(self, &WKCDancerViewPropertySpring, @(wkc_view_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_view_spring
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertySpring) boolValue];
}




- (void)setWkc_view_transition:(BOOL)wkc_view_transition
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyTransition, @(wkc_view_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_view_transition
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertyTransition) boolValue];
}





- (void)setWkc_view_options:(UIViewAnimationOptions)wkc_view_options
{
    objc_setAssociatedObject(self, &WKCDancerViewPropertyOptions, @(wkc_view_options), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_view_options
{
    return [objc_getAssociatedObject(self, &WKCDancerViewPropertyOptions) integerValue];
}

@end
