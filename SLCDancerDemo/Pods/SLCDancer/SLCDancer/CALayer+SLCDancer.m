//
//  CALayer+SLCDancer.m
//  SLCDancer
//
//  Created by WeiKunChao on 2019/3/22.
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


#import "CALayer+SLCDancer.h"
#import <objc/runtime.h>

#import "CALayer+SLCFrame.h"
#import "CALayer+SLCDancerProperty.h"

CABasicAnimation * slc_baseDancerCreate(NSString * keyPath,
                                           NSTimeInterval duration,
                                           NSInteger repeatCount,
                                           NSTimeInterval delay,
                                           BOOL autoreverses,
                                           CAMediaTimingFunctionName timing,
                                           id from,
                                           id to)
{
    CABasicAnimation * base = [CABasicAnimation animationWithKeyPath:keyPath];
    base.removedOnCompletion = NO;
    base.duration = duration;
    base.repeatCount = repeatCount;
    base.fillMode = kCAFillModeForwards;
    base.beginTime = CACurrentMediaTime() + delay;
    base.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    base.autoreverses = autoreverses;
    base.fromValue = from;
    base.toValue = to;
    return base;
}

CASpringAnimation * slc_springDancerCreate(NSString * keyPath,
                                              NSTimeInterval duration,
                                              NSInteger repeatCount,
                                              NSTimeInterval delay,
                                              BOOL autoreverses,
                                              CAMediaTimingFunctionName timing,
                                              id from,
                                              id to)
{
    CASpringAnimation * spring = [CASpringAnimation animationWithKeyPath:keyPath];
    spring.removedOnCompletion = NO;
    spring.duration = duration;
    spring.repeatCount = repeatCount;
    spring.fillMode = kCAFillModeForwards;
    spring.beginTime = CACurrentMediaTime() + delay;
    spring.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    spring.autoreverses = autoreverses;
    spring.fromValue = from;
    spring.toValue = to;
    spring.mass = 1.0;
    spring.stiffness = 100;
    spring.damping = 10;
    spring.initialVelocity = 10.0;
    return spring;
}

CAKeyframeAnimation * slc_keyframeDancerCreate(NSString * keyPath,
                                                  NSTimeInterval duration,
                                                  NSInteger repeatCount,
                                                  NSTimeInterval delay,
                                                  BOOL autoreverses,
                                                  CAMediaTimingFunctionName timing,
                                                  CGPathRef path)
{
    CAKeyframeAnimation * keyframe = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    keyframe.removedOnCompletion = NO;
    keyframe.duration = duration;
    keyframe.repeatCount = repeatCount;
    keyframe.fillMode = kCAFillModeForwards;
    keyframe.beginTime = CACurrentMediaTime() + delay;
    keyframe.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    keyframe.autoreverses = autoreverses;
    keyframe.path = path;
    return keyframe;
}

CATransition * slc_transitionCreate(NSTimeInterval duration,
                                    CAMediaTimingFunctionName timing,
                                    SLCDancerTransitionType type,
                                    SLCDancerTransitionDirection direction,
                                    NSInteger repeatCount,
                                    NSTimeInterval delay,
                                    BOOL autoreverses)
{
    CATransition  *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    transition.type = type;
    transition.subtype = direction;
    transition.repeatCount = repeatCount;
    transition.beginTime = CACurrentMediaTime() + delay;
    transition.autoreverses = autoreverses;
    return transition;
}


static NSString * const SLCDancerCompletionKey = @"slc.completion";


static NSString * const CADancerKeyPathPosition = @"position";
static NSString * const CADancerKeyPathPositionX = @"position.x";
static NSString * const CADancerKeyPathPositionY = @"position.y";
static NSString * const CADancerKeyPathWidth = @"bounds.size.width";
static NSString * const CADancerKeyPathHeight = @"bounds.size.height";
static NSString * const CADancerKeyPathSize = @"bounds.size";
static NSString * const CADancerKeyPathScale = @"transform.scale";
static NSString * const CADancerKeyPathScaleX = @"transform.scale.x";
static NSString * const CADancerKeyPathScaleY = @"transform.scale.y";
static NSString * const CADancerKeyPathRotationX = @"transform.rotation.x";
static NSString * const CADancerKeyPathRotationY = @"transform.rotation.y";
static NSString * const CADancerKeyPathRotationZ = @"transform.rotation.z";
static NSString * const CADancerKeyPathBackgroundColor = @"backgroundColor";
static NSString * const CADancerKeyPathOpacity = @"opacity";
static NSString * const CADancerKeyPathCornerRadius = @"cornerRadius";
static NSString * const CADancerKeyPathStrokeEnd = @"strokeEnd";
static NSString * const CADancerKeyPathContent = @"contents";
static NSString * const CADancerKeyPathBorderWidth = @"borderWidth";
static NSString * const CADancerKeyPathShadowColor = @"shadowColor";
static NSString * const CADancerKeyPathShadowOffset = @"shadowOffset";
static NSString * const CADancerKeyPathShadowOpacity = @"shadowOpacity";
static NSString * const CADancerKeyPathShadowRadius = @"shadowRadius";



static NSString * const UIViewDancerKeyFrame = @"slc.take.frame";
static NSString * const UIViewDancerKeyLeading = @"slc.take.leading";
static NSString * const UIViewDancerKeyTraing = @"slc.take.traing";
static NSString * const UIViewDancerKeyTop = @"slc.take.top";
static NSString * const UIViewDancerKeyBottom = @"slc.take.bottom";
static NSString * const UIViewDancerKeyWidth = @"slc.take.width";
static NSString * const UIViewDancerKeyHeight = @"slc.take.height";
static NSString * const UIViewDancerKeySize = @"slc.take.size";



static SLCDancerTransitionType const SLCDancerTransitionTypeFade = @"fade";
static SLCDancerTransitionType const SLCDancerTransitionTypePush = @"push";
static SLCDancerTransitionType const SLCDancerTransitionTypeReveal = @"reveal";
static SLCDancerTransitionType const SLCDancerTransitionTypeMoveIn = @"moveIn";
static SLCDancerTransitionType const SLCDancerTransitionTypeCube = @"cube";
static SLCDancerTransitionType const SLCDancerTransitionTypeSuck = @"suckEffect";
static SLCDancerTransitionType const SLCDancerTransitionTypeRipple = @"rippleEffect";
static SLCDancerTransitionType const SLCDancerTransitionTypeCurl = @"pageCurl";
static SLCDancerTransitionType const SLCDancerTransitionTypeUnCurl = @"pageUnCurl";
static SLCDancerTransitionType const SLCDancerTransitionTypeFlip = @"oglFlip";
static SLCDancerTransitionType const SLCDancerTransitionTypeHollowOpen = @"cameraIrisHollowOpen";
static SLCDancerTransitionType const SLCDancerTransitionTypeHollowClose = @"cameraIrisHollowClose";



SLCDancerTransitionDirection SLCDancerTransitionDirectionFromRight = @"fromRight";
SLCDancerTransitionDirection SLCDancerTransitionDirectionFromLeft = @"fromLeft";
SLCDancerTransitionDirection SLCDancerTransitionDirectionFromTop = @"fromTop";
SLCDancerTransitionDirection SLCDancerTransitionDirectionFromBottom = @"fromBottom";
SLCDancerTransitionDirection SLCDancerTransitionDirectionFromMiddle = @"middle";


@implementation CALayer (SLCDancer)

#pragma mark -MAKE
- (SLCDancerLayerPoint)makePosition
{
    return ^CALayer *(CGPoint point) {
        self.slc_keyPath = CADancerKeyPathPosition;
        self.slc_isCAAnimation = YES;
        self.slc_from = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY)];
        self.slc_to = [NSValue valueWithCGPoint:point];
        self.slc_theDancer = SLCDancerMakePosition;
        return self;
    };
}

- (SLCDancerLayerFloat)makeX
{
    return ^CALayer *(CGFloat x) {
        self.slc_keyPath = CADancerKeyPathPositionX;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.centerX);
        self.slc_to = @(x);
        self.slc_theDancer = SLCDancerMakeX;
        return self;
    };
}

- (SLCDancerLayerFloat)makeY
{
    return ^CALayer *(CGFloat y) {
        self.slc_keyPath = CADancerKeyPathPositionY;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.centerY);
        self.slc_to = @(y);
        self.slc_theDancer = SLCDancerMakeY;
        return self;
    };
}

- (SLCDancerLayerFloat)makeWidth
{
    return ^CALayer *(CGFloat width) {
        self.slc_keyPath = CADancerKeyPathWidth;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.width);
        self.slc_to = @(width);
        self.slc_theDancer = SLCDancerMakeWidth;
        return self;
    };
}

- (SLCDancerLayerFloat)makeHeight
{
    return ^CALayer *(CGFloat height) {
        self.slc_keyPath = CADancerKeyPathHeight;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.height);
        self.slc_to = @(height);
        self.slc_theDancer = SLCDancerMakeHeight;
        return self;
    };
}

- (SLCDancerLayerSize)makeSize
{
    return ^CALayer *(CGSize size) {
        self.slc_keyPath = CADancerKeyPathSize;
        self.slc_isCAAnimation = YES;
        self.slc_from = [NSValue valueWithCGSize:self.bounds.size];
        self.slc_to = [NSValue valueWithCGSize:size];
        self.slc_theDancer = SLCDancerMakeSize;
        return self;
    };
}

- (SLCDancerLayerFloat)makeScale
{
    return ^CALayer *(CGFloat scale) {
        self.slc_keyPath = CADancerKeyPathScale;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(1.0);
        self.slc_to = @(scale);
        self.slc_theDancer = SLCDancerMakeScale;
        return self;
    };
}

- (SLCDancerLayerFloat)makeScaleX
{
    return ^CALayer *(CGFloat scaleX) {
        self.slc_keyPath = CADancerKeyPathScaleX;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(1.0);
        self.slc_to = @(scaleX);
        self.slc_theDancer = SLCDancerMakeScaleX;
        return self;
    };
}

- (SLCDancerLayerFloat)makeScaleY
{
    return ^CALayer *(CGFloat scaleY) {
        self.slc_keyPath = CADancerKeyPathScaleY;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(1.0);
        self.slc_to = @(scaleY);
        self.slc_theDancer = SLCDancerMakeScaleY;
        return self;
    };
}

- (SLCDancerLayerFloat)makeRotationX
{
    return ^CALayer *(CGFloat retationX) {
        self.slc_keyPath = CADancerKeyPathRotationX;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(0);
        self.slc_to = @(retationX);
        self.slc_theDancer = SLCDancerMakeRotationX;
        return self;
    };
}

- (SLCDancerLayerFloat)makeRotationY
{
    return ^CALayer *(CGFloat retationY) {
        self.slc_keyPath = CADancerKeyPathRotationY;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(0);
        self.slc_to = @(retationY);
        self.slc_theDancer = SLCDancerMakeRotationY;
        return self;
    };
}

- (SLCDancerLayerFloat)makeRotationZ
{
    return ^CALayer *(CGFloat retationZ) {
        self.slc_keyPath = CADancerKeyPathRotationZ;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(0);
        self.slc_to = @(retationZ);
        self.slc_theDancer = SLCDancerMakeRotationZ;
        return self;
    };
}

- (SLCDancerLayerColor)makeBackground
{
    return ^CALayer * (UIColor * background) {
        self.slc_keyPath = CADancerKeyPathBackgroundColor;
        self.slc_isCAAnimation = YES;
        self.slc_from = (id)self.backgroundColor;
        self.slc_to = (id)background.CGColor;
        self.slc_theDancer = SLCDancerMakeBackground;
        return self;
    };
}

- (SLCDancerLayerFloat)makeOpacity
{
    return ^CALayer *(CGFloat opacity) {
        self.slc_keyPath = CADancerKeyPathOpacity;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.opacity);
        self.slc_to = @(opacity);
        self.slc_theDancer = SLCDancerMakeOpacity;
        return self;
    };
}

- (SLCDancerLayerFloat)makeCornerRadius
{
    return ^CALayer *(CGFloat corner) {
        self.slc_keyPath = CADancerKeyPathCornerRadius;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.cornerRadius);
        self.slc_to = @(corner);
        self.slc_theDancer = SLCDancerMakeCornerRadius;
        return self;
    };
}

- (SLCDancerLayerFloat)makeStrokeEnd
{
    return ^CALayer *(CGFloat stroke) {
        self.slc_keyPath = CADancerKeyPathStrokeEnd;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(0);
        self.slc_to = @(stroke);
        self.slc_theDancer = SLCDancerMakeStrokeEnd;
        return self;
    };
}

- (SLCDancerLayerContent)makeContent
{
    return ^CALayer *(id from, id to) {
        self.slc_keyPath = CADancerKeyPathContent;
        self.slc_isCAAnimation = YES;
        self.slc_from = from;
        self.slc_to = to;
        self.slc_theDancer = SLCDancerMakeContent;
        return self;
    };
}

- (SLCDancerLayerFloat)makeBorderWidth
{
    return ^CALayer *(CGFloat borderWidth) {
        self.slc_keyPath = CADancerKeyPathBorderWidth;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.borderWidth);
        self.slc_to = @(borderWidth);
        self.slc_theDancer = SLCDancerMakeBorderWidth;
        return self;
    };
}

- (SLCDancerLayerColor)makeShadowColor
{
    return ^CALayer *(UIColor * shadowColor) {
        self.slc_keyPath = CADancerKeyPathShadowColor;
        self.slc_isCAAnimation = YES;
        self.slc_from = (id)self.shadowColor;
        self.slc_to = (id)shadowColor.CGColor;
        self.slc_theDancer = SLCDancerMakeShadowColor;
        return self;
    };
}

- (SLCDancerLayerSize)makeShadowOffset
{
    return ^CALayer * (CGSize offset) {
        self.slc_keyPath = CADancerKeyPathShadowOffset;
        self.slc_isCAAnimation = YES;
        self.slc_from = [NSValue valueWithCGSize:self.shadowOffset];
        self.slc_to = [NSValue valueWithCGSize:offset];
        self.slc_theDancer = SLCDancerMakeShadowOffset;
        return self;
    };
}

- (SLCDancerLayerFloat)makeShadowOpacity
{
    return ^CALayer *(CGFloat shadowOpacity) {
        self.slc_keyPath = CADancerKeyPathShadowOpacity;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.shadowOpacity);
        self.slc_to = @(shadowOpacity);
        self.slc_theDancer = SLCDancerMakeShadowOpacity;
        return self;
    };
}

- (SLCDancerLayerFloat)makeShadowRadius
{
    return ^CALayer *(CGFloat shadowRadius) {
        self.slc_keyPath = CADancerKeyPathShadowRadius;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.shadowRadius);
        self.slc_to = @(shadowRadius);
        self.slc_theDancer = SLCDancerMakeShadowRadius;
        return self;
    };
}



#pragma mark -TAKE
- (SLCDancerLayerRect)takeFrame
{
    return ^CALayer *(CGRect frame) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyFrame;
        self.slc_to = [NSValue valueWithCGRect:frame];
        self.slc_theDancer = SLCDancerTakeFrame;
        return self;
    };
}

- (SLCDancerLayerFloat)takeLeading
{
    return ^CALayer *(CGFloat leading) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyLeading;
        self.slc_to = @(leading);
        self.slc_theDancer = SLCDancerTakeLeading;
        return self;
    };
}

- (SLCDancerLayerFloat)takeTraing
{
    return ^CALayer *(CGFloat traing) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyTraing;
        self.slc_to = @(traing);
        self.slc_theDancer = SLCDancerTakeTraing;
        return self;
    };
}

- (SLCDancerLayerFloat)takeTop
{
    return ^CALayer *(CGFloat top) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyTop;
        self.slc_to = @(top);
        self.slc_theDancer = SLCDancerTakeTop;
        return self;
    };
}

- (SLCDancerLayerFloat)takeBottom
{
    return ^CALayer *(CGFloat bottom) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyBottom;
        self.slc_to = @(bottom);
        self.slc_theDancer = SLCDancerTakeBottom;
        return self;
    };
}

- (SLCDancerLayerFloat)takeWidth
{
    return ^CALayer *(CGFloat width) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyWidth;
        self.slc_to = @(width);
        self.slc_theDancer = SLCDancerTakeWidth;
        return self;
    };
}

- (SLCDancerLayerFloat)takeHeight
{
    return ^CALayer *(CGFloat height) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyHeight;
        self.slc_to = @(height);
        self.slc_theDancer = SLCDancerTakeHeight;
        return self;
    };
}

- (SLCDancerLayerSize)takeSize
{
    return ^CALayer *(CGSize size) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeySize;
        self.slc_to = [NSValue valueWithCGSize:size];
        self.slc_theDancer = SLCDancerTakeSize;
        return self;
    };
}



#pragma mark -MOVE
- (SLCDancerLayerFloat)moveX
{
    return ^CALayer *(CGFloat relativeX) {
        self.slc_keyPath = CADancerKeyPathPositionX;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.centerX);
        self.slc_to = @(self.centerX + relativeX);
        self.slc_theDancer = SLCDancerMoveX;
        return self;
    };
}

- (SLCDancerLayerFloat)moveY
{
    return ^CALayer * (CGFloat relativeY) {
        self.slc_keyPath = CADancerKeyPathPositionY;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.centerY);
        self.slc_to = @(self.centerY + relativeY);
        self.slc_theDancer = SLCDancerMoveY;
        return self;
    };
}

- (SLCDancerLayerPoint)moveXY
{
    return ^CALayer * (CGPoint xy) {
        self.slc_keyPath = CADancerKeyPathPosition;
        self.slc_isCAAnimation = YES;
        self.slc_from = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY)];
        self.slc_to = [NSValue valueWithCGPoint:CGPointMake(self.centerX + xy.x, self.centerY + xy.y)];
        self.slc_theDancer = SLCDancerMoveXY;
        return self;
    };
}

- (SLCDancerLayerFloat)moveWidth
{
    return ^CALayer *(CGFloat width) {
        self.slc_keyPath = CADancerKeyPathWidth;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.width);
        self.slc_to = @(self.width + width);
        self.slc_theDancer = SLCDancerMoveWidth;
        return self;
    };
}

- (SLCDancerLayerFloat)moveHeight
{
    return ^CALayer *(CGFloat height) {
        self.slc_keyPath = CADancerKeyPathHeight;
        self.slc_isCAAnimation = YES;
        self.slc_from = @(self.height);
        self.slc_to = @(self.height + height);
        self.slc_theDancer = SLCDancerMoveHeight;
        return self;
    };
}

- (SLCDancerLayerSize)moveSize
{
    return ^CALayer *(CGSize size) {
        self.slc_keyPath = CADancerKeyPathSize;
        self.slc_isCAAnimation = YES;
        self.slc_from = [NSValue valueWithCGSize:CGSizeMake(self.width, self.height)];
        self.slc_to = [NSValue valueWithCGSize:CGSizeMake(self.width + size.width, self.height + size.height)];
        self.slc_theDancer = SLCDancerMoveSize;
        return self;
    };
}


#pragma mark -ADD
- (SLCDancerLayerFloat)addLeading
{
    return ^CALayer *(CGFloat leading) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyLeading;
        self.slc_to = @(leading + self.leading);
        self.slc_theDancer = SLCDancerAddLeading;
        return self;
    };
}

- (SLCDancerLayerFloat)addTraing
{
    return ^CALayer *(CGFloat traing) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyTraing;
        self.slc_to = @(traing + self.traing);
        self.slc_theDancer = SLCDancerAddTraing;
        return self;
    };
}

- (SLCDancerLayerFloat)addTop
{
    return ^CALayer *(CGFloat top) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyTop;
        self.slc_to = @(top + self.top);
        self.slc_theDancer = SLCDancerAddTop;
        return self;
    };
}

- (SLCDancerLayerFloat)addBottom
{
    return ^CALayer *(CGFloat bottom) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyBottom;
        self.slc_to = @(bottom + self.bottom);
        self.slc_theDancer = SLCDancerAddBottom;
        return self;
    };
}

- (SLCDancerLayerFloat)addWidth
{
    return ^CALayer *(CGFloat width) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyWidth;
        self.slc_to = @(width + self.width);
        self.slc_theDancer = SLCDancerAddWidth;
        return self;
    };
}

- (SLCDancerLayerFloat)addHeight
{
    return ^CALayer *(CGFloat height) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeyHeight;
        self.slc_to = @(height + self.height);
        self.slc_theDancer = SLCDancerAddHeight;
        return self;
    };
}

- (SLCDancerLayerSize)addSize
{
    return ^CALayer *(CGSize size) {
        self.slc_isCAAnimation = NO;
        self.slc_frameKeyPath = UIViewDancerKeySize;
        self.slc_to = [NSValue valueWithCGSize:CGSizeMake(size.width + self.width, size.height + self.height)];
        self.slc_theDancer = SLCDancerAddSize;
        return self;
    };
}





#pragma mark -TRANSITION
- (SLCDancerLayerTransitionDirection)transitionDir
{
    return ^CALayer *(SLCDancerTransitionDirection direction) {
        self.slc_isCAAnimation = YES;
        self.slc_to = direction;
        self.slc_dancerType = SLCDancerTypeTransition;
        self.slc_theDancer = SLCDancerTransition;
        return self;
    };
}






#pragma mark -PATH
- (SLCDancerLayerPath)path
{
    return ^CALayer *(UIBezierPath * path) {
        self.slc_isCAAnimation = YES;
        self.slc_to = path;
        self.slc_dancerType = SLCDancerTypePath;
        self.slc_theDancer = SLCDancerPath;
        self.slc_keyPath = CADancerKeyPathPosition;
        return self;
    };
}





#pragma mark -CONTENT
- (SLCDancerLayerTimeInterval)delay
{
    return ^CALayer *(NSTimeInterval delay) {
        self.slc_delay = delay;
        return self;
    };
}


- (SLCDancerLayerRepeat)repeat
{
    return ^CALayer *(NSInteger repeat) {
        self.slc_repeat = repeat;
        return self;
    };
}


- (SLCDancerLayerAutoreverses)reverses
{
    return ^CALayer *(BOOL isreverses) {
        self.slc_reverse = isreverses;
        return self;
    };
}


- (SLCDancerLayerTimeInterval)animate
{
    return ^CALayer * (NSTimeInterval duration) {
        self.slc_animateDuration = duration;
        [self slc_startDancer];
        return self;
    };
}

- (void)setCompletion:(SLCDancerCompletion)completion
{
    objc_setAssociatedObject(self, &SLCDancerCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLCDancerCompletion)completion
{
    return objc_getAssociatedObject(self, &SLCDancerCompletionKey);
}


- (CALayer *)easeInOut
{
    self.slc_timing = kCAMediaTimingFunctionEaseInEaseOut;
    self.slc_options = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (CALayer *)easeIn
{
    self.slc_timing = kCAMediaTimingFunctionEaseIn;
    self.slc_options = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (CALayer *)easeOut
{
    self.slc_timing = kCAMediaTimingFunctionEaseOut;
    self.slc_options = UIViewAnimationOptionCurveEaseOut;
    return self;
}

- (CALayer *)easeLiner
{
    self.slc_timing = kCAMediaTimingFunctionLinear;
    self.slc_options = UIViewAnimationOptionCurveLinear;
    return self;
}

- (CALayer *)spring
{
    self.slc_dancerType = SLCDancerTypeSpring;
    return self;
}







- (CALayer *)transitionFade
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeFade;
    return self;
}

- (CALayer *)transitionPush
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypePush;
    return self;
}

- (CALayer *)transitionReveal
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeReveal;
    return self;
}

- (CALayer *)transitionMoveIn
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeMoveIn;
    return self;
}

- (CALayer *)transitionCube
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeCube;
    return self;
}

- (CALayer *)transitionSuck
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeSuck;
    return self;
}

- (CALayer *)transitionRipple
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeRipple;
    return self;
}

- (CALayer *)transitionCurl
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeCurl;
    return self;
}

- (CALayer *)transitionUnCurl
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeUnCurl;
    return self;
}

- (CALayer *)transitionFlip
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeFlip;
    return self;
}

- (CALayer *)transitionHollowOpen
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeHollowOpen;
    return self;
}

- (CALayer *)transitionHollowClose
{
    self.slc_isCAAnimation = YES;
    self.slc_transitionType = SLCDancerTransitionTypeHollowClose;
    return self;
}





- (CALayer *)then
{
    self.slc_delay = self.slc_animateDuration;
    return self;
}






- (void)slc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.superlayer layoutIfNeeded]; //刷新坐标
        
        if (self.slc_isCAAnimation)
        {
            if (!self.slc_timing)
            {
                // 默认Default
                self.slc_timing = kCAMediaTimingFunctionLinear;
            }
            
            if (self.slc_dancerType == SLCDancerTypeBase)
            {
                if (!self.slc_keyPath)
                {
                    self.slc_keyPath = CADancerKeyPathPosition;
                }
                CABasicAnimation * base = slc_baseDancerCreate(self.slc_keyPath, self.slc_animateDuration, self.slc_repeat, self.slc_delay, self.slc_reverse, self.slc_timing, self.slc_from, self.slc_to);
                
                base.delegate = self;
                [self addAnimation:base forKey:nil];
            }
            else if (self.slc_dancerType == SLCDancerTypeSpring)
            {
                if (!self.slc_keyPath)
                {
                    self.slc_keyPath = CADancerKeyPathPosition;
                }
                CASpringAnimation * spring = slc_springDancerCreate(self.slc_keyPath, self.slc_animateDuration, self.slc_repeat, self.slc_delay, self.slc_reverse, self.slc_timing, self.slc_from, self.slc_to);
                spring.delegate = self;
                [self addAnimation:spring forKey:nil];
            }
            else if (self.slc_dancerType == SLCDancerTypePath)
            {
                if (!self.slc_keyPath)
                {
                    self.slc_keyPath = CADancerKeyPathPosition;
                }
                CAKeyframeAnimation * keyframe = slc_keyframeDancerCreate(self.slc_keyPath, self.slc_animateDuration, self.slc_repeat, self.slc_delay, self.slc_reverse, self.slc_timing, [(UIBezierPath *)self.slc_to CGPath]);
                keyframe.delegate = self;
                [self addAnimation:keyframe forKey:nil];
            }
            else if (self.slc_dancerType == SLCDancerTypeTransition)
            {
                if (!self.slc_transitionType)
                {
                    self.slc_transitionType = SLCDancerTransitionTypeFade;
                }
                
                CATransition * transition = slc_transitionCreate(self.slc_animateDuration, self.slc_timing, self.slc_transitionType, self.slc_to, self.slc_repeat, self.slc_delay, self.slc_reverse);
                
                transition.delegate = self;
                [self addAnimation:transition forKey:nil];
            }
            
        }
        else
        {
            self.slc_frameOrigin = self.frame; // 记录当前坐标
            
            if (!self.slc_options)
            {
                self.slc_options = UIViewAnimationOptionCurveLinear;
            }
            
            if (self.slc_reverse)
            {
                if (self.slc_options == UIViewAnimationOptionCurveEaseInOut)
                {
                    self.slc_options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else if (self.slc_options == UIViewAnimationOptionCurveEaseIn)
                {
                    self.slc_options = UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else if (self.slc_options == UIViewAnimationOptionCurveEaseOut)
                {
                    self.slc_options = UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else
                {
                    self.slc_options = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
            }
            
            if (self.slc_dancerType == SLCDancerTypeSpring)
            {
                CGFloat damping =  0.85;
                CGFloat velocity = 10.0 ;
                
                [UIView animateWithDuration:self.slc_animateDuration
                                      delay:self.slc_delay
                     usingSpringWithDamping:damping
                      initialSpringVelocity:velocity
                                    options:self.slc_options
                                 animations:^{
                                     
                                     if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyFrame])
                                     {
                                         self.frame = [(NSValue *)self.slc_to CGRectValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyLeading])
                                     {
                                         self.leading = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyTraing])
                                     {
                                         self.traing = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyTop])
                                     {
                                         self.top = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyBottom])
                                     {
                                         self.bottom = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyWidth])
                                     {
                                         self.width = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyHeight])
                                     {
                                         self.height = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeySize])
                                     {
                                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [(NSValue *)self.slc_to CGSizeValue].width, [(NSValue *)self.slc_to CGSizeValue].height);
                                     }
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     if (self.completion)
                                     {
                                         self.completion(self.slc_theDancer);
                                     }
                                 }];
            }
            else
            {
                [UIView animateWithDuration:self.slc_animateDuration
                                      delay:self.slc_delay
                                    options:self.slc_options
                                 animations:^{
                                     
                                     if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyFrame])
                                     {
                                         self.frame = [(NSValue *)self.slc_to CGRectValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyLeading])
                                     {
                                         self.leading = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyTraing])
                                     {
                                         self.traing = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyTop])
                                     {
                                         self.top = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyBottom])
                                     {
                                         self.bottom = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyWidth])
                                     {
                                         self.width = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeyHeight])
                                     {
                                         self.height = [self.slc_to floatValue];
                                     }
                                     else if ([self.slc_frameKeyPath isEqualToString:UIViewDancerKeySize])
                                     {
                                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [(NSValue *)self.slc_to CGSizeValue].width, [(NSValue *)self.slc_to CGSizeValue].height);
                                     }
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     if (self.completion)
                                     {
                                         self.completion(self.slc_theDancer);
                                     }
                                 }];
            }
            
        }
        
    });
}


- (void)removeDancers
{
    [self removeAllAnimations];
    if (!self.slc_isCAAnimation)
    {
        CALayer * superLayer = self.superlayer;
        [self removeFromSuperlayer];
        self.frame = self.slc_frameOrigin;
        [superLayer addSublayer:self];
    }
}

- (void)reloadDancers
{
    [self removeDancers];
    [self slc_startDancer];
}

#pragma mark -CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion)
    {
        self.completion(self.slc_theDancer);
    }
}

@end
