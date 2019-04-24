//
//  UIView+WKCDancer.m
//  WKCDancerTest
//
//  Created by WeiKunChao on 2019/3/23.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

//  链式方式加载动画,以下功能以MARK为分类作划分.
//  本项目会长期维护更新.
//  (1)MAKE类,全部是以中心点为依据的动画.
//  (2)TAKE类,全部以边界点为依据.(此时暂时repeat参数是无效的,待后续处理).
//  (3)MOVE类,相对移动 (以中心点为依据).
//  (4)ADD类,相对移动(以边界为依据).
//  (5)通用是适用于所有类型的动画样式.
//  (6)不使用then参数,同时使用多个动画如makeWith(20).animate(1).makeHeight(20).animate(1)
//  会同时作用; 使用then参数时如makeWith(20).animate(1).then.makeHeight(20).animate(1)
//  会在动画widtha完成后再进行动画height
//  (7)TRANSITION 转场动画.
//
//  注: 如果没有特殊注释,则表示参数适用于所有类型.
//
//
//  The animation is loaded in a chained manner. The following functions are classified by MARK.
//  This project will maintain and update for a long time.
//  (1)MAKE, all based on the animation of the center point.
//  (2)TAKE, all based on the boundary point. (At this time, the temporary repeat parameter is invalid, to be processed later)
//  (3)MOVE, relative movement (based on the center point).
//  (4)ADD, relative movement (based on the boundary).
//  (5)Universal is for all types of animated styles.
//  (6)Do not use the then parameter and use multiple animations at the same time, Such as
//  makeWith(20).animate(1).makeHeight(20).animate(1), Will work at the same time.
//  When using the then parameter, Such as makeWith(20).animate(1).then.makeHeight(20).animate(1)
//  Will be animated height after the animation widtha is completed.
//  (7)Transition animation.
//
//  Note: If there are no special comments, the parameters apply to all types.
//
//

#import "UIView+WKCDancer.h"
#import "UIView+WKCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const WKCDancerViewCompletionKey = @"wkc.view.completion";

@implementation UIView (WKCDancer)

- (WKCDancerViewSize)makeSize
{
    return ^UIView *(CGSize size) {
        self.wkc_view_theDancer = WKCDancerMakeSize;
        self.wkc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}

- (WKCDancerViewPoint)makePosition
{
    return ^UIView *(CGPoint position) {
        self.wkc_view_theDancer = WKCDancerMakePosition;
        self.wkc_view_to = [NSValue valueWithCGPoint:position];
        return self;
    };
}

- (WKCDancerViewFloat)makeX
{
    return ^UIView *(CGFloat x) {
        self.wkc_view_theDancer = WKCDancerMakeX;
        self.wkc_view_to = @(x);
        return self;
    };
}

- (WKCDancerViewFloat)makeY
{
    return ^ UIView *(CGFloat y) {
        self.wkc_view_theDancer = WKCDancerMakeY;
        self.wkc_view_to = @(y);
        return self;
    };
}

- (WKCDancerViewFloat)makeWidth
{
    return ^UIView *(CGFloat width) {
        self.wkc_view_theDancer = WKCDancerMakeWidth;
        self.wkc_view_to = @(width);
        return self;
    };
}

- (WKCDancerViewFloat)makeHeight
{
    return ^UIView *(CGFloat height) {
        self.wkc_view_theDancer = WKCDancerMakeHeight;
        self.wkc_view_to = @(height);
        return self;
    };
}

- (WKCDancerViewFloat)makeScale
{
    return ^UIView * (CGFloat scale) {
        self.wkc_view_theDancer = WKCDancerMakeScale;
        self.wkc_view_to = @(scale);
        return self;
    };
}

- (WKCDancerViewFloat)makeScaleX
{
    return ^UIView * (CGFloat scaleX) {
        self.wkc_view_theDancer = WKCDancerMakeScaleX;
        self.wkc_view_to = @(scaleX);
        return self;
    };
}

- (WKCDancerViewFloat)makeScaleY
{
    return ^UIView * (CGFloat scaleY) {
        self.wkc_view_theDancer = WKCDancerMakeScaleY;
        self.wkc_view_to = @(scaleY);
        return self;
    };
}

- (WKCDancerViewFloat)makeRotationX
{
    return ^UIView * (CGFloat rotationX) {
        self.wkc_view_theDancer = WKCDancerMakeRotationX;
        self.wkc_view_to = @(rotationX);
        return self;
    };
}

- (WKCDancerViewFloat)makeRotationY
{
    return ^UIView * (CGFloat rotationY) {
        self.wkc_view_theDancer = WKCDancerMakeRotationY;
        self.wkc_view_to = @(rotationY);
        return self;
    };
}

- (WKCDancerViewFloat)makeRotationZ
{
    return ^UIView * (CGFloat rotationZ) {
        self.wkc_view_theDancer = WKCDancerMakeRotationZ;
        self.wkc_view_to = @(rotationZ);
        return self;
    };
}

- (WKCDancerViewColor)makeBackground
{
    return ^UIView * (UIColor * color) {
        self.wkc_view_theDancer = WKCDancerMakeBackground;
        self.wkc_view_to = color;
        return self;
    };
}

- (WKCDancerViewFloat)makeOpacity
{
    return ^UIView * (CGFloat opacity) {
        self.wkc_view_theDancer = WKCDancerMakeOpacity;
        self.wkc_view_to = @(opacity);
        return self;
    };
}

- (WKCDancerViewFloat)makeCornerRadius
{
    return ^UIView * (CGFloat corner) {
        self.wkc_view_theDancer = WKCDancerMakeCornerRadius;
        self.wkc_view_to = @(corner);
        return self;
    };
}

- (WKCDancerViewFloat)makeStrokeEnd
{
    return ^UIView * (CGFloat storeEnd) {
        self.wkc_view_theDancer = WKCDancerMakeStrokeEnd;
        self.wkc_view_to = @(storeEnd);
        return self;
    };
}

- (WKCDancerViewContent)makeContent
{
    return ^UIView * (id from, id to) {
        self.wkc_view_theDancer = WKCDancerMakeContent;
        self.wkc_view_from = from;
        self.wkc_view_to = to;
        return self;
    };
}

- (WKCDancerViewFloat)makeBorderWidth
{
    return ^UIView * (CGFloat borderWidth) {
        self.wkc_view_theDancer = WKCDancerMakeBorderWidth;
        self.wkc_view_to = @(borderWidth);
        return self;
    };
}

- (WKCDancerViewColor)makeShadowColor
{
    return ^UIView * (UIColor * shadowColor) {
        self.wkc_view_theDancer = WKCDancerMakeShadowColor;
        self.wkc_view_to = shadowColor;
        return self;
    };
}

- (WKCDancerViewSize)makeShadowOffset
{
    return ^UIView * (CGSize size) {
        self.wkc_view_theDancer = WKCDancerMakeShadowOffset;
        self.wkc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}

- (WKCDancerViewFloat)makeShadowOpacity
{
    return ^UIView * (CGFloat opacity) {
        self.wkc_view_theDancer = WKCDancerMakeShadowOpacity;
        self.wkc_view_to = @(opacity);
        return self;
    };
}

- (WKCDancerViewFloat)makeShadowRadius
{
    return ^UIView * (CGFloat radius) {
        self.wkc_view_theDancer = WKCDancerMakeShadowRadius;
        self.wkc_view_to = @(radius);
        return self;
    };
}




#pragma mark -TAKE
- (WKCDancerViewRect)takeFrame
{
    return ^UIView * (CGRect rect) {
        self.wkc_view_theDancer = WKCDancerTakeFrame;
        self.wkc_view_to = [NSValue valueWithCGRect:rect];
        return self;
    };
}

- (WKCDancerViewFloat)takeLeading
{
    return ^UIView * (CGFloat leading) {
        self.wkc_view_theDancer = WKCDancerTakeLeading;
        self.wkc_view_to = @(leading);
        return self;
    };
}

- (WKCDancerViewFloat)takeTraing
{
    return ^UIView * (CGFloat traing) {
        self.wkc_view_theDancer = WKCDancerTakeTraing;
        self.wkc_view_to = @(traing);
        return self;
    };
}

- (WKCDancerViewFloat)takeTop
{
    return ^UIView * (CGFloat top) {
        self.wkc_view_theDancer = WKCDancerTakeTop;
        self.wkc_view_to = @(top);
        return self;
    };
}

- (WKCDancerViewFloat)takeBottom
{
    return ^UIView * (CGFloat bottom) {
        self.wkc_view_theDancer = WKCDancerTakeBottom;
        self.wkc_view_to = @(bottom);
        return self;
    };
}

- (WKCDancerViewFloat)takeWidth
{
    return ^UIView * (CGFloat width) {
        self.wkc_view_theDancer = WKCDancerTakeWidth;
        self.wkc_view_to = @(width);
        return self;
    };
}

- (WKCDancerViewFloat)takeHeight
{
    return ^UIView * (CGFloat height) {
        self.wkc_view_theDancer = WKCDancerTakeHeight;
        self.wkc_view_to = @(height);
        return self;
    };
}

- (WKCDancerViewSize)takeSize
{
    return ^UIView * (CGSize size) {
        self.wkc_view_theDancer = WKCDancerTakeSize;
        self.wkc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}





#pragma mark -MOVE
- (WKCDancerViewFloat)moveX
{
    return ^UIView * (CGFloat x) {
        self.wkc_view_theDancer = WKCDancerMoveX;
        self.wkc_view_to = @(x);
        return self;
    };
}

- (WKCDancerViewFloat)moveY
{
    return ^UIView * (CGFloat y) {
        self.wkc_view_theDancer = WKCDancerMoveY;
        self.wkc_view_to = @(y);
        return self;
    };
}

- (WKCDancerViewPoint)moveXY
{
    return ^UIView * (CGPoint xy) {
        self.wkc_view_theDancer = WKCDancerMoveXY;
        self.wkc_view_to = [NSValue valueWithCGPoint:xy];
        return self;
    };
}

- (WKCDancerViewFloat)moveWidth
{
    return ^UIView * (CGFloat width) {
        self.wkc_view_theDancer = WKCDancerMoveWidth;
        self.wkc_view_to = @(width);
        return self;
    };
}

- (WKCDancerViewFloat)moveHeight
{
    return ^UIView * (CGFloat height) {
        self.wkc_view_theDancer = WKCDancerMoveHeight;
        self.wkc_view_to = @(height);
        return self;
    };
}

- (WKCDancerViewSize)moveSize
{
    return ^UIView * (CGSize size) {
        self.wkc_view_theDancer = WKCDancerMoveSize;
        self.wkc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}




#pragma mark - ADD
- (WKCDancerViewFloat)addLeading
{
    return ^UIView * (CGFloat leading) {
        self.wkc_view_theDancer = WKCDancerAddLeading;
        self.wkc_view_to = @(leading);
        return self;
    };
}

- (WKCDancerViewFloat)addTraing
{
    return ^UIView * (CGFloat traing) {
        self.wkc_view_theDancer = WKCDancerAddTraing;
        self.wkc_view_to = @(traing);
        return self;
    };
}

- (WKCDancerViewFloat)addTop
{
    return ^UIView * (CGFloat top) {
        self.wkc_view_theDancer = WKCDancerAddTop;
        self.wkc_view_to = @(top);
        return self;
    };
}

- (WKCDancerViewFloat)addBottom
{
    return ^UIView * (CGFloat bottom) {
        self.wkc_view_theDancer = WKCDancerAddBottom;
        self.wkc_view_to = @(bottom);
        return self;
    };
}

- (WKCDancerViewFloat)addWidth
{
    return ^UIView * (CGFloat width) {
        self.wkc_view_theDancer = WKCDancerAddWidth;
        self.wkc_view_to = @(width);
        return self;
    };
}

- (WKCDancerViewFloat)addHeight
{
    return ^UIView * (CGFloat height) {
        self.wkc_view_theDancer = WKCDancerAddHeight;
        self.wkc_view_to = @(height);
        return self;
    };
}

- (WKCDancerViewSize)addSize
{
    return ^UIView * (CGSize size) {
        self.wkc_view_theDancer = WKCDancerAddSize;
        self.wkc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}




#pragma mark -TRANSITION
- (WKCDancerViewTransitionTo)transitionTo
{
    return ^UIView * (UIView * to) {
        self.wkc_view_theDancer = WKCDancerTransition;
        self.wkc_view_to = to;
        self.wkc_view_transition = YES;
        return self;
    };
}

#pragma mark -PATH
- (WKCDancerViewPath)path
{
    return ^UIView * (UIBezierPath * path) {
        self.wkc_view_to = path;
        self.wkc_view_theDancer = WKCDancerPath;
        return self;
    };
}


#pragma mark -CONTENT
- (WKCDancerViewTimeInterval)delay
{
    return ^UIView *(NSTimeInterval delay) {
        self.wkc_view_delay = delay;
        return self;
    };
}

- (WKCDancerViewRepeat)repeat
{
    return ^UIView *(NSInteger repeat) {
        self.wkc_view_repeat = repeat;
        return self;
    };
}

- (WKCDancerViewAutoreverses)reverses
{
    return ^UIView *(BOOL reverses) {
        self.wkc_view_reverse = reverses;
        return self;
    };
}

- (WKCDancerViewTimeInterval)animate
{
    return ^UIView *(NSTimeInterval duration) {
        self.wkc_view_animateDuration = duration;
        [self wkc_startDancer];
        return self;
    };
}


- (void)setCompletion:(WKCDancerCompletion)completion
{
    objc_setAssociatedObject(self, &WKCDancerViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKCDancerCompletion)completion
{
    return objc_getAssociatedObject(self, &WKCDancerViewCompletionKey);
}




#pragma mark -动画样式
- (UIView *)easeInOut
{
    self.wkc_view_easeType = WKCViewEaseTypeInOut;
    self.wkc_view_options = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UIView *)easeIn
{
    self.wkc_view_easeType = WKCViewEaseTypeIn;
    self.wkc_view_options = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UIView *)easeOut
{
    self.wkc_view_easeType = WKCViewEaseTypeOut;
    self.wkc_view_options = UIViewAnimationOptionCurveEaseOut;
    return self;
}

- (UIView *)easeLiner
{
    self.wkc_view_easeType = WKCViewEaseTypeLiner;
    self.wkc_view_options = UIViewAnimationOptionCurveLinear;
    return self;
}



#pragma mark -TRANSITION
- (UIView *)transitionFlipFromLeft
{
    self.wkc_view_options = UIViewAnimationOptionTransitionFlipFromLeft;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionFromRight
{
    self.wkc_view_options = UIViewAnimationOptionTransitionFlipFromRight;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionCurlUp
{
    self.wkc_view_options = UIViewAnimationOptionTransitionCurlUp;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionCurlDown
{
    self.wkc_view_options = UIViewAnimationOptionTransitionCurlDown;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionCrossDissolve
{
    self.wkc_view_options = UIViewAnimationOptionTransitionCrossDissolve;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionFlipFromTop
{
    self.wkc_view_options = UIViewAnimationOptionTransitionFlipFromTop;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

- (UIView *)transitionFlipFromBottom
{
    self.wkc_view_options = UIViewAnimationOptionTransitionFlipFromBottom;
    self.wkc_view_theDancer = WKCDancerTransition;
    return self;
}

#pragma mark -SPRING
- (UIView *)spring
{
    self.wkc_view_spring = YES;
    return self;
}




#pragma mark -THEN
- (UIView *)then
{
    self.wkc_view_delay = self.wkc_view_animateDuration;
    return self;
}




#pragma mark -REMOVE
- (void)removeDancers
{
    [self.layer removeDancers];
}

- (void)reloadDancers
{
    [self.layer reloadDancers];
}



- (void)wkc_startDancer
{
    [self.superview layoutIfNeeded];
    
    switch (self.wkc_view_theDancer)
    {
        case WKCDancerMakeSize:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakePosition:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.wkc_view_to CGPointValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeX:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeY:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeWidth:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeHeight:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeScale:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScale([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeScaleX:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeScaleY:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeScaleY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeRotationX:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeRotationY:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeRotationZ:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeRotationZ([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeBackground:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBackground(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBackground(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBackground(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBackground(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBackground(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBackground(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBackground(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBackground(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeOpacity:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeOpacity([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeCornerRadius:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeCornerRadius([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeStrokeEnd:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeStrokeEnd([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeContent:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeContent(self.wkc_view_from, self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeBorderWidth:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeBorderWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeShadowColor:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowColor(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeShadowOffset:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeShadowOpacity:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowOpacity([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMakeShadowRadius:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.makeShadowRadius([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeFrame:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.wkc_view_to CGRectValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeLeading:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeLeading([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeTraing:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTraing([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeTop:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeTop([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeBottom:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeBottom([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeWidth:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeHeight:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTakeSize:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveX:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveX([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveY:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveY([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveXY:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.wkc_view_to CGPointValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveWidth:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveHeight:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerMoveSize:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddLeading:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addLeading([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddTraing:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTraing([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddTop:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addTop([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddBottom:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addBottom([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddWidth:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addWidth([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddHeight:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addHeight([self.wkc_view_to floatValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerAddSize:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeInOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeIn.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeOut.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.wkc_view_to CGSizeValue]).easeLiner.delay(self.wkc_view_delay).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        case WKCDancerTransition:
        {
            if (!self.wkc_view_options)
            {
                self.wkc_view_options = UIViewAnimationOptionTransitionNone;
            }
            if (self.wkc_view_reverse)
            {
                if (self.wkc_view_options == UIViewAnimationOptionTransitionFlipFromLeft)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromLeft;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionFlipFromRight)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromRight;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionFlipFromTop)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromTop;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionFlipFromBottom)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromBottom;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionCurlUp)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCurlUp;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionCurlDown)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCurlDown;
                }
                else if (self.wkc_view_options == UIViewAnimationOptionTransitionCrossDissolve)
                {
                    self.wkc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCrossDissolve;
                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.wkc_view_transition)
                {
                    [UIView transitionFromView:self
                                        toView:self.wkc_view_to
                                      duration:self.wkc_view_animateDuration
                                       options:self.wkc_view_options
                                    completion:^(BOOL finished) {
                                        
                                        self.wkc_view_transition = NO;
                                        
                                        if (self.completion)
                                        {
                                            self.completion(WKCDancerTransition);
                                        }
                                    }];
                }
                else
                {
                    [UIView transitionWithView:self
                                      duration:self.wkc_view_animateDuration
                                       options:self.wkc_view_options
                                    animations:nil
                                    completion:^(BOOL finished) {
                                        
                                        self.wkc_view_transition = NO;
                                        
                                        if (self.completion)
                                        {
                                            self.completion(WKCDancerTransition);
                                        }
                                        
                                    }];
                }
                
            });
            
        }
            break;
        case WKCDancerPath:
        {
            if (self.wkc_view_easeType == WKCViewEaseTypeInOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.path(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.path(self.wkc_view_to).easeInOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeIn)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.path(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.path(self.wkc_view_to).easeIn.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeOut)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.path(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.path(self.wkc_view_to).easeOut.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
            else if (self.wkc_view_easeType == WKCViewEaseTypeLiner)
            {
                if (self.wkc_view_spring)
                {
                    self.layer.path(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).spring.animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
                else
                {
                    self.layer.path(self.wkc_view_to).easeLiner.delay(self.wkc_view_delay).repeat(self.wkc_view_repeat).reverses(self.wkc_view_reverse).animate(self.wkc_view_animateDuration).completion = ^(WKCDancer animation) {
                        if (self.completion) {
                            self.completion(animation);
                        }
                    };
                }
            }
        }
            break;
        default:
            break;
    }
}

@end

