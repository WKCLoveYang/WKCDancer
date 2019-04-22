//
//  CALayer+WKCDancerProperty.m
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "CALayer+WKCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const WKCDancerPropertyDancerType = @"wkc.dancer.type";
static NSString * const WKCDancerPropertyTiming = @"wkc.dancer.timing";
static NSString * const WKCDancerPropertyOptions = @"wkc.dancer.options";
static NSString * const WKCDancerPropertyDelay = @"wkc.dancer.delay";
static NSString * const WKCDancerPropertyRepeat = @"wkc.dancer.repeat";
static NSString * const WKCDancerPropertyReverse = @"wkc.dancer.reverse";
static NSString * const WKCDancerPropertyCAAnimation = @"wkc.dancer.is.caanimation";
static NSString * const WKCDancerPropertyDuration = @"wkc.dancer.duration";
static NSString * const WKCDancerPropertyKeyParh = @"wkc.dancer.keyPath";
static NSString * const WKCDancerPropertyFrom = @"wkc.dancer.from";
static NSString * const WKCDancerPropertyTo = @"wkc.dancer.to";
static NSString * const WKCDancerPropertyFrameKeypath = @"wkc.dancer.frame.keypath";
static NSString * const WKCDancerPropertyTheDancer = @"wkc.dancer.theDancer";
static NSString * const WKCDancerPropertyTransition = @"wkc.dancer.transition";
static NSString * const WKCDancerPropertyFrameOrigin = @"wkc.dancer.frame.origin";


@implementation CALayer (WKCDancerProperty)

- (void)setWkc_dancerType:(WKCDancerType)wkc_dancerType
{
    objc_setAssociatedObject(self, &WKCDancerPropertyDancerType, @(wkc_dancerType), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCDancerType)wkc_dancerType
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyDancerType) integerValue];
}




- (void)setWkc_timing:(CAMediaTimingFunctionName)wkc_timing
{
    objc_setAssociatedObject(self, &WKCDancerPropertyTiming, wkc_timing, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CAMediaTimingFunctionName)wkc_timing
{
    return (CAMediaTimingFunctionName)objc_getAssociatedObject(self, &WKCDancerPropertyTiming);
}





- (void)setWkc_options:(UIViewAnimationOptions)wkc_options
{
  objc_setAssociatedObject(self, &WKCDancerPropertyOptions, @(wkc_options), OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewAnimationOptions)wkc_options
{
   return [objc_getAssociatedObject(self, &WKCDancerPropertyOptions) integerValue];
}





- (void)setWkc_delay:(NSTimeInterval)wkc_delay
{
   objc_setAssociatedObject(self, &WKCDancerPropertyDelay, [NSString stringWithFormat:@"%f",wkc_delay], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_delay
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyDelay) doubleValue];
}




- (void)setWkc_repeat:(NSInteger)wkc_repeat
{
    objc_setAssociatedObject(self, &WKCDancerPropertyRepeat, [NSString stringWithFormat:@"%ld", wkc_repeat], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)wkc_repeat
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyRepeat) integerValue];
}



- (void)setWkc_reverse:(BOOL)wkc_reverse
{
    objc_setAssociatedObject(self, &WKCDancerPropertyReverse, @(wkc_reverse), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_reverse
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyReverse) boolValue];
}




- (void)setWkc_isCAAnimation:(BOOL)wkc_isCAAnimation
{
    objc_setAssociatedObject(self, &WKCDancerPropertyCAAnimation, @(wkc_isCAAnimation), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)wkc_isCAAnimation
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyCAAnimation) boolValue];
}




- (void)setWkc_animateDuration:(NSTimeInterval)wkc_animateDuration
{
    objc_setAssociatedObject(self, &WKCDancerPropertyDuration, [NSString stringWithFormat:@"%f", wkc_animateDuration], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)wkc_animateDuration
{
   return [objc_getAssociatedObject(self, &WKCDancerPropertyDuration) doubleValue];
}




- (void)setWkc_keyPath:(NSString *)wkc_keyPath
{
    objc_setAssociatedObject(self, &WKCDancerPropertyKeyParh, wkc_keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)wkc_keyPath
{
    return objc_getAssociatedObject(self, &WKCDancerPropertyKeyParh);
}



- (void)setWkc_from:(id)wkc_from
{
    objc_setAssociatedObject(self, &WKCDancerPropertyFrom, wkc_from, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)wkc_from
{
    return objc_getAssociatedObject(self, &WKCDancerPropertyFrom);
}



- (void)setWkc_to:(id)wkc_to
{
   objc_setAssociatedObject(self, &WKCDancerPropertyTo, wkc_to, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)wkc_to
{
    return objc_getAssociatedObject(self, &WKCDancerPropertyTo);
}





- (void)setWkc_frameKeyPath:(NSString *)wkc_frameKeyPath
{
    objc_setAssociatedObject(self, &WKCDancerPropertyFrameKeypath, wkc_frameKeyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)wkc_frameKeyPath
{
    return objc_getAssociatedObject(self, &WKCDancerPropertyFrameKeypath);
}




- (void)setWkc_theDancer:(WKCDancer)wkc_theDancer
{
    objc_setAssociatedObject(self, &WKCDancerPropertyTheDancer, @(wkc_theDancer), OBJC_ASSOCIATION_ASSIGN);
}

- (WKCDancer)wkc_theDancer
{
   return [objc_getAssociatedObject(self, &WKCDancerPropertyTheDancer) integerValue];
}



- (void)setWkc_transitionType:(WKCDancerTransitionType)wkc_transitionType
{
   objc_setAssociatedObject(self, &WKCDancerPropertyTransition, wkc_transitionType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WKCDancerTransitionType)wkc_transitionType
{
    return objc_getAssociatedObject(self, &WKCDancerPropertyTransition);
}



- (void)setWkc_frameOrigin:(CGRect)wkc_frameOrigin
{
    objc_setAssociatedObject(self, &WKCDancerPropertyFrameOrigin, [NSValue valueWithCGRect:wkc_frameOrigin], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)wkc_frameOrigin
{
    return [objc_getAssociatedObject(self, &WKCDancerPropertyFrameOrigin) CGRectValue];
}

@end
