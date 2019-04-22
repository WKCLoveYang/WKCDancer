//
//  UIView+SLCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UIView+SLCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const SLCDancerViewPropertyDelay = @"slc.view.property.delay";
static NSString * const SLCDancerViewPropertyRepeat = @"slc.view.property.repeat";
static NSString * const SLCDancerViewPropertyReverse = @"slc.view.property.reverse";
static NSString * const SLCDancerViewPropertyAnimationDuration = @"slc.view.property.animateDuration";
static NSString * const SLCDancerViewPropertyFrom = @"slc.view.property.from";
static NSString * const SLCDancerViewPropertyTo = @"slc.view.property.to";
static NSString * const SLCDancerViewPropertyTheDancer = @"slc.view.property.theDancer";
static NSString * const SLCDancerViewPropertyEaseType = @"slc.view.property.easeType";
static NSString * const SLCDancerViewPropertySpring = @"slc.view.property.spring";
static NSString * const SLCDancerViewPropertyTransition = @"slc.view.property.transition";
static NSString * const SLCDancerViewPropertyOptions = @"slc.view.property.options";

@implementation UIView (SLCDancerProperty)

- (void)setSlc_view_delay:(NSTimeInterval)slc_view_delay
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyDelay, [NSString stringWithFormat:@"%f", slc_view_delay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_view_delay
{
   return [objc_getAssociatedObject(self, &SLCDancerViewPropertyDelay) doubleValue];
}





- (void)setSlc_view_repeat:(NSInteger)slc_view_repeat
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyRepeat, [NSString stringWithFormat:@"%ld", slc_view_repeat], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)slc_view_repeat
{
   return [objc_getAssociatedObject(self, &SLCDancerViewPropertyRepeat) integerValue];
}





- (void)setSlc_view_reverse:(BOOL)slc_view_reverse
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyReverse, @(slc_view_reverse), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_view_reverse
{
   return [objc_getAssociatedObject(self, &SLCDancerViewPropertyReverse) boolValue];
}





- (void)setSlc_view_animateDuration:(NSTimeInterval)slc_view_animateDuration
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyAnimationDuration, [NSString stringWithFormat:@"%f", slc_view_animateDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_view_animateDuration
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertyAnimationDuration) doubleValue];
}





- (void)setSlc_view_from:(id)slc_view_from
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyFrom, slc_view_from, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)slc_view_from
{
    return objc_getAssociatedObject(self, &SLCDancerViewPropertyFrom);
}



- (void)setSlc_view_to:(id)slc_view_to
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyTo, slc_view_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)slc_view_to
{
   return objc_getAssociatedObject(self, &SLCDancerViewPropertyTo);
}




- (void)setSlc_view_theDancer:(SLCDancer)slc_view_theDancer
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyTheDancer, @(slc_view_theDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCDancer)slc_view_theDancer
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertyTheDancer) integerValue];
}




- (void)setSlc_view_easeType:(SLCViewEaseType)slc_view_easeType
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyEaseType, @(slc_view_easeType), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCViewEaseType)slc_view_easeType
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertyEaseType) integerValue];
}





- (void)setSlc_view_spring:(BOOL)slc_view_spring
{
   objc_setAssociatedObject(self, &SLCDancerViewPropertySpring, @(slc_view_spring), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_view_spring
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertySpring) boolValue];
}




- (void)setSlc_view_transition:(BOOL)slc_view_transition
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyTransition, @(slc_view_transition), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_view_transition
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertyTransition) boolValue];
}





- (void)setSlc_view_options:(UIViewAnimationOptions)slc_view_options
{
    objc_setAssociatedObject(self, &SLCDancerViewPropertyOptions, @(slc_view_options), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_view_options
{
    return [objc_getAssociatedObject(self, &SLCDancerViewPropertyOptions) integerValue];
}

@end
