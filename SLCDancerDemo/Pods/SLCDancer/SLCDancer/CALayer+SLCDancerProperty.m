//
//  CALayer+SLCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "CALayer+SLCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const SLCDancerPropertyDancerType = @"slc.dancer.type";
static NSString * const SLCDancerPropertyTiming = @"slc.dancer.timing";
static NSString * const SLCDancerPropertyOptions = @"slc.dancer.options";
static NSString * const SLCDancerPropertyDelay = @"slc.dancer.delay";
static NSString * const SLCDancerPropertyRepeat = @"slc.dancer.repeat";
static NSString * const SLCDancerPropertyReverse = @"slc.dancer.reverse";
static NSString * const SLCDancerPropertyCAAnimation = @"slc.dancer.is.caanimation";
static NSString * const SLCDancerPropertyDuration = @"slc.dancer.duration";
static NSString * const SLCDancerPropertyKeyParh = @"slc.dancer.keyPath";
static NSString * const SLCDancerPropertyFrom = @"slc.dancer.from";
static NSString * const SLCDancerPropertyTo = @"slc.dancer.to";
static NSString * const SLCDancerPropertyFrameKeypath = @"slc.dancer.frame.keypath";
static NSString * const SLCDancerPropertyTheDancer = @"slc.dancer.theDancer";
static NSString * const SLCDancerPropertyTransition = @"slc.dancer.transition";
static NSString * const SLCDancerPropertyFrameOrigin = @"slc.dancer.frame.origin";


@implementation CALayer (SLCDancerProperty)

- (void)setSlc_dancerType:(SLCDancerType)slc_dancerType
{
    objc_setAssociatedObject(self, &SLCDancerPropertyDancerType, @(slc_dancerType), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCDancerType)slc_dancerType
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyDancerType) integerValue];
}




- (void)setSlc_timing:(CAMediaTimingFunctionName)slc_timing
{
    objc_setAssociatedObject(self, &SLCDancerPropertyTiming, slc_timing, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CAMediaTimingFunctionName)slc_timing
{
    return (CAMediaTimingFunctionName)objc_getAssociatedObject(self, &SLCDancerPropertyTiming);
}





- (void)setSlc_options:(UIViewAnimationOptions)slc_options
{
  objc_setAssociatedObject(self, &SLCDancerPropertyOptions, @(slc_options), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)slc_options
{
   return [objc_getAssociatedObject(self, &SLCDancerPropertyOptions) integerValue];
}





- (void)setSlc_delay:(NSTimeInterval)slc_delay
{
   objc_setAssociatedObject(self, &SLCDancerPropertyDelay, [NSString stringWithFormat:@"%f",slc_delay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_delay
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyDelay) doubleValue];
}




- (void)setSlc_repeat:(NSInteger)slc_repeat
{
    objc_setAssociatedObject(self, &SLCDancerPropertyRepeat, [NSString stringWithFormat:@"%ld", slc_repeat], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)slc_repeat
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyRepeat) integerValue];
}



- (void)setSlc_reverse:(BOOL)slc_reverse
{
    objc_setAssociatedObject(self, &SLCDancerPropertyReverse, @(slc_reverse), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_reverse
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyReverse) boolValue];
}




- (void)setSlc_isCAAnimation:(BOOL)slc_isCAAnimation
{
    objc_setAssociatedObject(self, &SLCDancerPropertyCAAnimation, @(slc_isCAAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)slc_isCAAnimation
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyCAAnimation) boolValue];
}




- (void)setSlc_animateDuration:(NSTimeInterval)slc_animateDuration
{
    objc_setAssociatedObject(self, &SLCDancerPropertyDuration, [NSString stringWithFormat:@"%f", slc_animateDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)slc_animateDuration
{
   return [objc_getAssociatedObject(self, &SLCDancerPropertyDuration) doubleValue];
}




- (void)setSlc_keyPath:(NSString *)slc_keyPath
{
    objc_setAssociatedObject(self, &SLCDancerPropertyKeyParh, slc_keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)slc_keyPath
{
    return objc_getAssociatedObject(self, &SLCDancerPropertyKeyParh);
}



- (void)setSlc_from:(id)slc_from
{
    objc_setAssociatedObject(self, &SLCDancerPropertyFrom, slc_from, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)slc_from
{
    return objc_getAssociatedObject(self, &SLCDancerPropertyFrom);
}



- (void)setSlc_to:(id)slc_to
{
   objc_setAssociatedObject(self, &SLCDancerPropertyTo, slc_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)slc_to
{
    return objc_getAssociatedObject(self, &SLCDancerPropertyTo);
}





- (void)setSlc_frameKeyPath:(NSString *)slc_frameKeyPath
{
    objc_setAssociatedObject(self, &SLCDancerPropertyFrameKeypath, slc_frameKeyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)slc_frameKeyPath
{
    return objc_getAssociatedObject(self, &SLCDancerPropertyFrameKeypath);
}




- (void)setSlc_theDancer:(SLCDancer)slc_theDancer
{
    objc_setAssociatedObject(self, &SLCDancerPropertyTheDancer, @(slc_theDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (SLCDancer)slc_theDancer
{
   return [objc_getAssociatedObject(self, &SLCDancerPropertyTheDancer) integerValue];
}



- (void)setSlc_transitionType:(SLCDancerTransitionType)slc_transitionType
{
   objc_setAssociatedObject(self, &SLCDancerPropertyTransition, slc_transitionType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SLCDancerTransitionType)slc_transitionType
{
    return objc_getAssociatedObject(self, &SLCDancerPropertyTransition);
}



- (void)setSlc_frameOrigin:(CGRect)slc_frameOrigin
{
    objc_setAssociatedObject(self, &SLCDancerPropertyFrameOrigin, [NSValue valueWithCGRect:slc_frameOrigin], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)slc_frameOrigin
{
    return [objc_getAssociatedObject(self, &SLCDancerPropertyFrameOrigin) CGRectValue];
}

@end
