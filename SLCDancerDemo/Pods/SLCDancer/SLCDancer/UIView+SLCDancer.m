//
//  UIView+SLCDancer.m
//  SLCDancerTest
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

#import "UIView+SLCDancer.h"
#import "UIView+SLCDancerProperty.h"
#import <objc/runtime.h>

static NSString * const SLCDancerViewCompletionKey = @"slc.view.completion";

@implementation UIView (SLCDancer)

- (SLCDancerViewSize)makeSize
{
    return ^UIView *(CGSize size) {
        self.slc_view_theDancer = SLCDancerMakeSize;
        self.slc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}

- (SLCDancerViewPoint)makePosition
{
    return ^UIView *(CGPoint position) {
        self.slc_view_theDancer = SLCDancerMakePosition;
        self.slc_view_to = [NSValue valueWithCGPoint:position];
        return self;
    };
}

- (SLCDancerViewFloat)makeX
{
    return ^UIView *(CGFloat x) {
        self.slc_view_theDancer = SLCDancerMakeX;
        self.slc_view_to = @(x);
        return self;
    };
}

- (SLCDancerViewFloat)makeY
{
    return ^ UIView *(CGFloat y) {
        self.slc_view_theDancer = SLCDancerMakeY;
        self.slc_view_to = @(y);
        return self;
    };
}

- (SLCDancerViewFloat)makeWidth
{
    return ^UIView *(CGFloat width) {
        self.slc_view_theDancer = SLCDancerMakeWidth;
        self.slc_view_to = @(width);
        return self;
    };
}

- (SLCDancerViewFloat)makeHeight
{
    return ^UIView *(CGFloat height) {
        self.slc_view_theDancer = SLCDancerMakeHeight;
        self.slc_view_to = @(height);
        return self;
    };
}

- (SLCDancerViewFloat)makeScale
{
    return ^UIView * (CGFloat scale) {
        self.slc_view_theDancer = SLCDancerMakeScale;
        self.slc_view_to = @(scale);
        return self;
    };
}

- (SLCDancerViewFloat)makeScaleX
{
    return ^UIView * (CGFloat scaleX) {
        self.slc_view_theDancer = SLCDancerMakeScaleX;
        self.slc_view_to = @(scaleX);
        return self;
    };
}

- (SLCDancerViewFloat)makeScaleY
{
    return ^UIView * (CGFloat scaleY) {
        self.slc_view_theDancer = SLCDancerMakeScaleY;
        self.slc_view_to = @(scaleY);
        return self;
    };
}

- (SLCDancerViewFloat)makeRotationX
{
    return ^UIView * (CGFloat rotationX) {
        self.slc_view_theDancer = SLCDancerMakeRotationX;
        self.slc_view_to = @(rotationX);
        return self;
    };
}

- (SLCDancerViewFloat)makeRotationY
{
    return ^UIView * (CGFloat rotationY) {
        self.slc_view_theDancer = SLCDancerMakeRotationY;
        self.slc_view_to = @(rotationY);
        return self;
    };
}

- (SLCDancerViewFloat)makeRotationZ
{
    return ^UIView * (CGFloat rotationZ) {
        self.slc_view_theDancer = SLCDancerMakeRotationZ;
        self.slc_view_to = @(rotationZ);
        return self;
    };
}

- (SLCDancerViewColor)makeBackground
{
    return ^UIView * (UIColor * color) {
        self.slc_view_theDancer = SLCDancerMakeBackground;
        self.slc_view_to = color;
        return self;
    };
}

- (SLCDancerViewFloat)makeOpacity
{
    return ^UIView * (CGFloat opacity) {
        self.slc_view_theDancer = SLCDancerMakeOpacity;
        self.slc_view_to = @(opacity);
        return self;
    };
}

- (SLCDancerViewFloat)makeCornerRadius
{
    return ^UIView * (CGFloat corner) {
        self.slc_view_theDancer = SLCDancerMakeCornerRadius;
        self.slc_view_to = @(corner);
        return self;
    };
}

- (SLCDancerViewFloat)makeStrokeEnd
{
    return ^UIView * (CGFloat storeEnd) {
        self.slc_view_theDancer = SLCDancerMakeStrokeEnd;
        self.slc_view_to = @(storeEnd);
        return self;
    };
}

- (SLCDancerViewContent)makeContent
{
    return ^UIView * (id from, id to) {
        self.slc_view_theDancer = SLCDancerMakeContent;
        self.slc_view_from = from;
        self.slc_view_to = to;
        return self;
    };
}

- (SLCDancerViewFloat)makeBorderWidth
{
    return ^UIView * (CGFloat borderWidth) {
        self.slc_view_theDancer = SLCDancerMakeBorderWidth;
        self.slc_view_to = @(borderWidth);
        return self;
    };
}

- (SLCDancerViewColor)makeShadowColor
{
    return ^UIView * (UIColor * shadowColor) {
        self.slc_view_theDancer = SLCDancerMakeShadowColor;
        self.slc_view_to = shadowColor;
        return self;
    };
}

- (SLCDancerViewSize)makeShadowOffset
{
    return ^UIView * (CGSize size) {
        self.slc_view_theDancer = SLCDancerMakeShadowOffset;
        self.slc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}

- (SLCDancerViewFloat)makeShadowOpacity
{
    return ^UIView * (CGFloat opacity) {
        self.slc_view_theDancer = SLCDancerMakeShadowOpacity;
        self.slc_view_to = @(opacity);
        return self;
    };
}

- (SLCDancerViewFloat)makeShadowRadius
{
    return ^UIView * (CGFloat radius) {
        self.slc_view_theDancer = SLCDancerMakeShadowRadius;
        self.slc_view_to = @(radius);
        return self;
    };
}




#pragma mark -TAKE
- (SLCDancerViewRect)takeFrame
{
    return ^UIView * (CGRect rect) {
        self.slc_view_theDancer = SLCDancerTakeFrame;
        self.slc_view_to = [NSValue valueWithCGRect:rect];
        return self;
    };
}

- (SLCDancerViewFloat)takeLeading
{
    return ^UIView * (CGFloat leading) {
        self.slc_view_theDancer = SLCDancerTakeLeading;
        self.slc_view_to = @(leading);
        return self;
    };
}

- (SLCDancerViewFloat)takeTraing
{
    return ^UIView * (CGFloat traing) {
        self.slc_view_theDancer = SLCDancerTakeTraing;
        self.slc_view_to = @(traing);
        return self;
    };
}

- (SLCDancerViewFloat)takeTop
{
    return ^UIView * (CGFloat top) {
        self.slc_view_theDancer = SLCDancerTakeTop;
        self.slc_view_to = @(top);
        return self;
    };
}

- (SLCDancerViewFloat)takeBottom
{
    return ^UIView * (CGFloat bottom) {
        self.slc_view_theDancer = SLCDancerTakeBottom;
        self.slc_view_to = @(bottom);
        return self;
    };
}

- (SLCDancerViewFloat)takeWidth
{
    return ^UIView * (CGFloat width) {
        self.slc_view_theDancer = SLCDancerTakeWidth;
        self.slc_view_to = @(width);
        return self;
    };
}

- (SLCDancerViewFloat)takeHeight
{
    return ^UIView * (CGFloat height) {
        self.slc_view_theDancer = SLCDancerTakeHeight;
        self.slc_view_to = @(height);
        return self;
    };
}

- (SLCDancerViewSize)takeSize
{
    return ^UIView * (CGSize size) {
        self.slc_view_theDancer = SLCDancerTakeSize;
        self.slc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}





#pragma mark -MOVE
- (SLCDancerViewFloat)moveX
{
    return ^UIView * (CGFloat x) {
        self.slc_view_theDancer = SLCDancerMoveX;
        self.slc_view_to = @(x);
        return self;
    };
}

- (SLCDancerViewFloat)moveY
{
    return ^UIView * (CGFloat y) {
        self.slc_view_theDancer = SLCDancerMoveY;
        self.slc_view_to = @(y);
        return self;
    };
}

- (SLCDancerViewPoint)moveXY
{
    return ^UIView * (CGPoint xy) {
        self.slc_view_theDancer = SLCDancerMoveXY;
        self.slc_view_to = [NSValue valueWithCGPoint:xy];
        return self;
    };
}

- (SLCDancerViewFloat)moveWidth
{
    return ^UIView * (CGFloat width) {
        self.slc_view_theDancer = SLCDancerMoveWidth;
        self.slc_view_to = @(width);
        return self;
    };
}

- (SLCDancerViewFloat)moveHeight
{
    return ^UIView * (CGFloat height) {
        self.slc_view_theDancer = SLCDancerMoveHeight;
        self.slc_view_to = @(height);
        return self;
    };
}

- (SLCDancerViewSize)moveSize
{
    return ^UIView * (CGSize size) {
        self.slc_view_theDancer = SLCDancerMoveSize;
        self.slc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}




#pragma mark - ADD
- (SLCDancerViewFloat)addLeading
{
    return ^UIView * (CGFloat leading) {
        self.slc_view_theDancer = SLCDancerAddLeading;
        self.slc_view_to = @(leading);
        return self;
    };
}

- (SLCDancerViewFloat)addTraing
{
    return ^UIView * (CGFloat traing) {
        self.slc_view_theDancer = SLCDancerAddTraing;
        self.slc_view_to = @(traing);
        return self;
    };
}

- (SLCDancerViewFloat)addTop
{
    return ^UIView * (CGFloat top) {
        self.slc_view_theDancer = SLCDancerAddTop;
        self.slc_view_to = @(top);
        return self;
    };
}

- (SLCDancerViewFloat)addBottom
{
    return ^UIView * (CGFloat bottom) {
        self.slc_view_theDancer = SLCDancerAddBottom;
        self.slc_view_to = @(bottom);
        return self;
    };
}

- (SLCDancerViewFloat)addWidth
{
    return ^UIView * (CGFloat width) {
        self.slc_view_theDancer = SLCDancerAddWidth;
        self.slc_view_to = @(width);
        return self;
    };
}

- (SLCDancerViewFloat)addHeight
{
    return ^UIView * (CGFloat height) {
        self.slc_view_theDancer = SLCDancerAddHeight;
        self.slc_view_to = @(height);
        return self;
    };
}

- (SLCDancerViewSize)addSize
{
    return ^UIView * (CGSize size) {
        self.slc_view_theDancer = SLCDancerAddSize;
        self.slc_view_to = [NSValue valueWithCGSize:size];
        return self;
    };
}




#pragma mark -TRANSITION
- (SLCDancerViewTransitionTo)transitionTo
{
    return ^UIView * (UIView * to) {
        self.slc_view_theDancer = SLCDancerTransition;
        self.slc_view_to = to;
        self.slc_view_transition = YES;
        return self;
    };
}

#pragma mark -PATH
- (SLCDancerViewPath)path
{
    return ^UIView * (UIBezierPath * path) {
        self.slc_view_to = path;
        self.slc_view_theDancer = SLCDancerPath;
        return self;
    };
}


#pragma mark -CONTENT
- (SLCDancerViewTimeInterval)delay
{
    return ^UIView *(NSTimeInterval delay) {
        self.slc_view_delay = delay;
        return self;
    };
}

- (SLCDancerViewRepeat)repeat
{
    return ^UIView *(NSInteger repeat) {
        self.slc_view_repeat = repeat;
        return self;
    };
}

- (SLCDancerViewAutoreverses)reverses
{
    return ^UIView *(BOOL reverses) {
        self.slc_view_reverse = reverses;
        return self;
    };
}

- (SLCDancerViewTimeInterval)animate
{
    return ^UIView *(NSTimeInterval duration) {
        self.slc_view_animateDuration = duration;
        [self slc_startDancer];
        return self;
    };
}


- (void)setCompletion:(SLCDancerCompletion)completion
{
    objc_setAssociatedObject(self, &SLCDancerViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLCDancerCompletion)completion
{
    return objc_getAssociatedObject(self, &SLCDancerViewCompletionKey);
}




#pragma mark -动画样式
- (UIView *)easeInOut
{
    self.slc_view_easeType = SLCViewEaseTypeInOut;
    self.slc_view_options = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UIView *)easeIn
{
    self.slc_view_easeType = SLCViewEaseTypeIn;
    self.slc_view_options = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UIView *)easeOut
{
    self.slc_view_easeType = SLCViewEaseTypeOut;
    self.slc_view_options = UIViewAnimationOptionCurveEaseOut;
    return self;
}

- (UIView *)easeLiner
{
    self.slc_view_easeType = SLCViewEaseTypeLiner;
    self.slc_view_options = UIViewAnimationOptionCurveLinear;
    return self;
}



#pragma mark -TRANSITION
- (UIView *)transitionFlipFromLeft
{
    self.slc_view_options = UIViewAnimationOptionTransitionFlipFromLeft;
    self.slc_view_theDancer = SLCDancerTransition;
    return self;
}

- (UIView *)transitionFromRight
{
    self.slc_view_options = UIViewAnimationOptionTransitionFlipFromRight;
    self.slc_view_theDancer = SLCDancerTransition;
    return self;
}

- (UIView *)transitionCurlUp
{
    self.slc_view_options = UIViewAnimationOptionTransitionCurlUp;
    self.slc_view_theDancer = SLCDancerTransition;
   return self;
}

- (UIView *)transitionCurlDown
{
    self.slc_view_options = UIViewAnimationOptionTransitionCurlDown;
    self.slc_view_theDancer = SLCDancerTransition;
   return self;
}

- (UIView *)transitionCrossDissolve
{
    self.slc_view_options = UIViewAnimationOptionTransitionCrossDissolve;
    self.slc_view_theDancer = SLCDancerTransition;
    return self;
}

- (UIView *)transitionFlipFromTop
{
    self.slc_view_options = UIViewAnimationOptionTransitionFlipFromTop;
    self.slc_view_theDancer = SLCDancerTransition;
    return self;
}

- (UIView *)transitionFlipFromBottom
{
    self.slc_view_options = UIViewAnimationOptionTransitionFlipFromBottom;
    self.slc_view_theDancer = SLCDancerTransition;
   return self;
}

#pragma mark -SPRING
- (UIView *)spring
{
    self.slc_view_spring = YES;
    return self;
}




#pragma mark -THEN
- (UIView *)then
{
    self.slc_view_delay = self.slc_view_animateDuration;
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



- (void)slc_startDancer
{
    [self.superview layoutIfNeeded];
    
    switch (self.slc_view_theDancer)
    {
        case SLCDancerMakeSize:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakePosition:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makePosition([(NSValue *)self.slc_view_to CGPointValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeX:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeY:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeWidth:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeHeight:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeScale:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScale([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeScaleX:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeScaleY:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeScaleY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeRotationX:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeRotationY:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeRotationZ:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeRotationZ([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeBackground:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBackground(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBackground(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBackground(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBackground(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBackground(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBackground(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBackground(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBackground(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeOpacity:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeOpacity([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeCornerRadius:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeCornerRadius([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeStrokeEnd:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeStrokeEnd([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeContent:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeContent(self.slc_view_from, self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeBorderWidth:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeBorderWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeShadowColor:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowColor(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeShadowOffset:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOffset([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeShadowOpacity:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowOpacity([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMakeShadowRadius:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.makeShadowRadius([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeFrame:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeFrame([(NSValue *)self.slc_view_to CGRectValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeLeading:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeLeading([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeTraing:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTraing([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeTop:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeTop([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeBottom:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeBottom([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeWidth:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeHeight:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTakeSize:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.takeSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveX:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveX([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveY:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveY([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveXY:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveXY([(NSValue *)self.slc_view_to CGPointValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveWidth:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveHeight:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerMoveSize:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.moveSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddLeading:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addLeading([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddTraing:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTraing([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddTop:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addTop([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddBottom:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addBottom([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddWidth:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addWidth([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddHeight:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addHeight([self.slc_view_to floatValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerAddSize:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeInOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeIn.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeOut.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.addSize([(NSValue *)self.slc_view_to CGSizeValue]).easeLiner.delay(self.slc_view_delay).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        case SLCDancerTransition:
        {
            if (!self.slc_view_options)
            {
                self.slc_view_options = UIViewAnimationOptionTransitionNone;
            }
            if (self.slc_view_reverse)
            {
                if (self.slc_view_options == UIViewAnimationOptionTransitionFlipFromLeft)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromLeft;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionFlipFromRight)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromRight;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionFlipFromTop)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromTop;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionFlipFromBottom)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionFlipFromBottom;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionCurlUp)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCurlUp;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionCurlDown)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCurlDown;
                }
                else if (self.slc_view_options == UIViewAnimationOptionTransitionCrossDissolve)
                {
                    self.slc_view_options = UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCrossDissolve;
                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.slc_view_transition)
                {
                    [UIView transitionFromView:self
                                        toView:self.slc_view_to
                                      duration:self.slc_view_animateDuration
                                       options:self.slc_view_options
                                    completion:^(BOOL finished) {
                                        
                                        self.slc_view_transition = NO;
                                        
                                        if (self.completion)
                                        {
                                            self.completion(SLCDancerTransition);
                                        }
                                    }];
                }
                else
                {
                    [UIView transitionWithView:self
                                      duration:self.slc_view_animateDuration
                                       options:self.slc_view_options
                                    animations:nil
                                    completion:^(BOOL finished) {
                                        
                                        self.slc_view_transition = NO;
                                        
                                        if (self.completion)
                                        {
                                            self.completion(SLCDancerTransition);
                                        }
                                        
                                    }];
                }
                
            });
            
        }
            break;
        case SLCDancerPath:
        {
            if (self.slc_view_easeType == SLCViewEaseTypeInOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.path(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.path(self.slc_view_to).easeInOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeIn)
            {
                if (self.slc_view_spring)
                {
                    self.layer.path(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.path(self.slc_view_to).easeIn.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeOut)
            {
                if (self.slc_view_spring)
                {
                    self.layer.path(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.path(self.slc_view_to).easeOut.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
            else if (self.slc_view_easeType == SLCViewEaseTypeLiner)
            {
                if (self.slc_view_spring)
                {
                    self.layer.path(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).spring.animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
                else
                {
                    self.layer.path(self.slc_view_to).easeLiner.delay(self.slc_view_delay).repeat(self.slc_view_repeat).reverses(self.slc_view_reverse).animate(self.slc_view_animateDuration).completion = self.completion ?: nil;
                }
            }
        }
            break;
        default:
            break;
    }
}

@end
