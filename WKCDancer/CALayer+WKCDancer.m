//
//  CALayer+WKCDancer.m
//  WKCDancer
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


#import "CALayer+WKCDancer.h"
#import <objc/runtime.h>

#import "CALayer+WKCFrame.h"
#import "CALayer+WKCDancerProperty.h"

CABasicAnimation * wkc_baseDancerCreate(NSString * keyPath,
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

CASpringAnimation * wkc_springDancerCreate(NSString * keyPath,
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

CAKeyframeAnimation * wkc_keyframeDancerCreate(NSString * keyPath,
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

CATransition * wkc_transitionCreate(NSTimeInterval duration,
                                    CAMediaTimingFunctionName timing,
                                    WKCDancerTransitionType type,
                                    WKCDancerTransitionDirection direction,
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


static NSString * const WKCDancerCompletionKey = @"wkc.completion";


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



static NSString * const UIViewDancerKeyFrame = @"wkc.take.frame";
static NSString * const UIViewDancerKeyLeading = @"wkc.take.leading";
static NSString * const UIViewDancerKeyTraing = @"wkc.take.traing";
static NSString * const UIViewDancerKeyTop = @"wkc.take.top";
static NSString * const UIViewDancerKeyBottom = @"wkc.take.bottom";
static NSString * const UIViewDancerKeyWidth = @"wkc.take.width";
static NSString * const UIViewDancerKeyHeight = @"wkc.take.height";
static NSString * const UIViewDancerKeySize = @"wkc.take.size";



static WKCDancerTransitionType const WKCDancerTransitionTypeFade = @"fade";
static WKCDancerTransitionType const WKCDancerTransitionTypePush = @"push";
static WKCDancerTransitionType const WKCDancerTransitionTypeReveal = @"reveal";
static WKCDancerTransitionType const WKCDancerTransitionTypeMoveIn = @"moveIn";
static WKCDancerTransitionType const WKCDancerTransitionTypeCube = @"cube";
static WKCDancerTransitionType const WKCDancerTransitionTypeSuck = @"suckEffect";
static WKCDancerTransitionType const WKCDancerTransitionTypeRipple = @"rippleEffect";
static WKCDancerTransitionType const WKCDancerTransitionTypeCurl = @"pageCurl";
static WKCDancerTransitionType const WKCDancerTransitionTypeUnCurl = @"pageUnCurl";
static WKCDancerTransitionType const WKCDancerTransitionTypeFlip = @"oglFlip";
static WKCDancerTransitionType const WKCDancerTransitionTypeHollowOpen = @"cameraIrisHollowOpen";
static WKCDancerTransitionType const WKCDancerTransitionTypeHollowClose = @"cameraIrisHollowClose";



WKCDancerTransitionDirection WKCDancerTransitionDirectionFromRight = @"fromRight";
WKCDancerTransitionDirection WKCDancerTransitionDirectionFromLeft = @"fromLeft";
WKCDancerTransitionDirection WKCDancerTransitionDirectionFromTop = @"fromTop";
WKCDancerTransitionDirection WKCDancerTransitionDirectionFromBottom = @"fromBottom";
WKCDancerTransitionDirection WKCDancerTransitionDirectionFromMiddle = @"middle";


@implementation CALayer (WKCDancer)

#pragma mark -MAKE
- (WKCDancerLayerPoint)makePosition
{
    return ^CALayer *(CGPoint point) {
        self.wkc_keyPath = CADancerKeyPathPosition;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY)];
        self.wkc_to = [NSValue valueWithCGPoint:point];
        self.wkc_theDancer = WKCDancerMakePosition;
        return self;
    };
}

- (WKCDancerLayerFloat)makeX
{
    return ^CALayer *(CGFloat x) {
        self.wkc_keyPath = CADancerKeyPathPositionX;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.centerX);
        self.wkc_to = @(x);
        self.wkc_theDancer = WKCDancerMakeX;
        return self;
    };
}

- (WKCDancerLayerFloat)makeY
{
    return ^CALayer *(CGFloat y) {
        self.wkc_keyPath = CADancerKeyPathPositionY;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.centerY);
        self.wkc_to = @(y);
        self.wkc_theDancer = WKCDancerMakeY;
        return self;
    };
}

- (WKCDancerLayerFloat)makeWidth
{
    return ^CALayer *(CGFloat width) {
        self.wkc_keyPath = CADancerKeyPathWidth;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.width);
        self.wkc_to = @(width);
        self.wkc_theDancer = WKCDancerMakeWidth;
        return self;
    };
}

- (WKCDancerLayerFloat)makeHeight
{
    return ^CALayer *(CGFloat height) {
        self.wkc_keyPath = CADancerKeyPathHeight;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.height);
        self.wkc_to = @(height);
        self.wkc_theDancer = WKCDancerMakeHeight;
        return self;
    };
}

- (WKCDancerLayerSize)makeSize
{
    return ^CALayer *(CGSize size) {
        self.wkc_keyPath = CADancerKeyPathSize;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = [NSValue valueWithCGSize:self.bounds.size];
        self.wkc_to = [NSValue valueWithCGSize:size];
        self.wkc_theDancer = WKCDancerMakeSize;
        return self;
    };
}

- (WKCDancerLayerFloat)makeScale
{
    return ^CALayer *(CGFloat scale) {
        self.wkc_keyPath = CADancerKeyPathScale;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(1.0);
        self.wkc_to = @(scale);
        self.wkc_theDancer = WKCDancerMakeScale;
        return self;
    };
}

- (WKCDancerLayerFloat)makeScaleX
{
    return ^CALayer *(CGFloat scaleX) {
        self.wkc_keyPath = CADancerKeyPathScaleX;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(1.0);
        self.wkc_to = @(scaleX);
        self.wkc_theDancer = WKCDancerMakeScaleX;
        return self;
    };
}

- (WKCDancerLayerFloat)makeScaleY
{
    return ^CALayer *(CGFloat scaleY) {
        self.wkc_keyPath = CADancerKeyPathScaleY;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(1.0);
        self.wkc_to = @(scaleY);
        self.wkc_theDancer = WKCDancerMakeScaleY;
        return self;
    };
}

- (WKCDancerLayerFloat)makeRotationX
{
    return ^CALayer *(CGFloat retationX) {
        self.wkc_keyPath = CADancerKeyPathRotationX;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(0);
        self.wkc_to = @(retationX);
        self.wkc_theDancer = WKCDancerMakeRotationX;
        return self;
    };
}

- (WKCDancerLayerFloat)makeRotationY
{
    return ^CALayer *(CGFloat retationY) {
        self.wkc_keyPath = CADancerKeyPathRotationY;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(0);
        self.wkc_to = @(retationY);
        self.wkc_theDancer = WKCDancerMakeRotationY;
        return self;
    };
}

- (WKCDancerLayerFloat)makeRotationZ
{
    return ^CALayer *(CGFloat retationZ) {
        self.wkc_keyPath = CADancerKeyPathRotationZ;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(0);
        self.wkc_to = @(retationZ);
        self.wkc_theDancer = WKCDancerMakeRotationZ;
        return self;
    };
}

- (WKCDancerLayerColor)makeBackground
{
    return ^CALayer * (UIColor * background) {
        self.wkc_keyPath = CADancerKeyPathBackgroundColor;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = (id)self.backgroundColor;
        self.wkc_to = (id)background.CGColor;
        self.wkc_theDancer = WKCDancerMakeBackground;
        return self;
    };
}

- (WKCDancerLayerFloat)makeOpacity
{
    return ^CALayer *(CGFloat opacity) {
        self.wkc_keyPath = CADancerKeyPathOpacity;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.opacity);
        self.wkc_to = @(opacity);
        self.wkc_theDancer = WKCDancerMakeOpacity;
        return self;
    };
}

- (WKCDancerLayerFloat)makeCornerRadius
{
    return ^CALayer *(CGFloat corner) {
        self.wkc_keyPath = CADancerKeyPathCornerRadius;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.cornerRadius);
        self.wkc_to = @(corner);
        self.wkc_theDancer = WKCDancerMakeCornerRadius;
        return self;
    };
}

- (WKCDancerLayerFloat)makeStrokeEnd
{
    return ^CALayer *(CGFloat stroke) {
        self.wkc_keyPath = CADancerKeyPathStrokeEnd;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(0);
        self.wkc_to = @(stroke);
        self.wkc_theDancer = WKCDancerMakeStrokeEnd;
        return self;
    };
}

- (WKCDancerLayerContent)makeContent
{
    return ^CALayer *(id from, id to) {
        self.wkc_keyPath = CADancerKeyPathContent;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = from;
        self.wkc_to = to;
        self.wkc_theDancer = WKCDancerMakeContent;
        return self;
    };
}

- (WKCDancerLayerFloat)makeBorderWidth
{
    return ^CALayer *(CGFloat borderWidth) {
        self.wkc_keyPath = CADancerKeyPathBorderWidth;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.borderWidth);
        self.wkc_to = @(borderWidth);
        self.wkc_theDancer = WKCDancerMakeBorderWidth;
        return self;
    };
}

- (WKCDancerLayerColor)makeShadowColor
{
    return ^CALayer *(UIColor * shadowColor) {
        self.wkc_keyPath = CADancerKeyPathShadowColor;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = (id)self.shadowColor;
        self.wkc_to = (id)shadowColor.CGColor;
        self.wkc_theDancer = WKCDancerMakeShadowColor;
        return self;
    };
}

- (WKCDancerLayerSize)makeShadowOffset
{
    return ^CALayer * (CGSize offset) {
        self.wkc_keyPath = CADancerKeyPathShadowOffset;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = [NSValue valueWithCGSize:self.shadowOffset];
        self.wkc_to = [NSValue valueWithCGSize:offset];
        self.wkc_theDancer = WKCDancerMakeShadowOffset;
        return self;
    };
}

- (WKCDancerLayerFloat)makeShadowOpacity
{
    return ^CALayer *(CGFloat shadowOpacity) {
        self.wkc_keyPath = CADancerKeyPathShadowOpacity;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.shadowOpacity);
        self.wkc_to = @(shadowOpacity);
        self.wkc_theDancer = WKCDancerMakeShadowOpacity;
        return self;
    };
}

- (WKCDancerLayerFloat)makeShadowRadius
{
    return ^CALayer *(CGFloat shadowRadius) {
        self.wkc_keyPath = CADancerKeyPathShadowRadius;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.shadowRadius);
        self.wkc_to = @(shadowRadius);
        self.wkc_theDancer = WKCDancerMakeShadowRadius;
        return self;
    };
}



#pragma mark -TAKE
- (WKCDancerLayerRect)takeFrame
{
    return ^CALayer *(CGRect frame) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyFrame;
        self.wkc_to = [NSValue valueWithCGRect:frame];
        self.wkc_theDancer = WKCDancerTakeFrame;
        return self;
    };
}

- (WKCDancerLayerFloat)takeLeading
{
    return ^CALayer *(CGFloat leading) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyLeading;
        self.wkc_to = @(leading);
        self.wkc_theDancer = WKCDancerTakeLeading;
        return self;
    };
}

- (WKCDancerLayerFloat)takeTraing
{
    return ^CALayer *(CGFloat traing) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyTraing;
        self.wkc_to = @(traing);
        self.wkc_theDancer = WKCDancerTakeTraing;
        return self;
    };
}

- (WKCDancerLayerFloat)takeTop
{
    return ^CALayer *(CGFloat top) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyTop;
        self.wkc_to = @(top);
        self.wkc_theDancer = WKCDancerTakeTop;
        return self;
    };
}

- (WKCDancerLayerFloat)takeBottom
{
    return ^CALayer *(CGFloat bottom) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyBottom;
        self.wkc_to = @(bottom);
        self.wkc_theDancer = WKCDancerTakeBottom;
        return self;
    };
}

- (WKCDancerLayerFloat)takeWidth
{
    return ^CALayer *(CGFloat width) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyWidth;
        self.wkc_to = @(width);
        self.wkc_theDancer = WKCDancerTakeWidth;
        return self;
    };
}

- (WKCDancerLayerFloat)takeHeight
{
    return ^CALayer *(CGFloat height) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyHeight;
        self.wkc_to = @(height);
        self.wkc_theDancer = WKCDancerTakeHeight;
        return self;
    };
}

- (WKCDancerLayerSize)takeSize
{
    return ^CALayer *(CGSize size) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeySize;
        self.wkc_to = [NSValue valueWithCGSize:size];
        self.wkc_theDancer = WKCDancerTakeSize;
        return self;
    };
}



#pragma mark -MOVE
- (WKCDancerLayerFloat)moveX
{
    return ^CALayer *(CGFloat relativeX) {
        self.wkc_keyPath = CADancerKeyPathPositionX;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.centerX);
        self.wkc_to = @(self.centerX + relativeX);
        self.wkc_theDancer = WKCDancerMoveX;
        return self;
    };
}

- (WKCDancerLayerFloat)moveY
{
    return ^CALayer * (CGFloat relativeY) {
        self.wkc_keyPath = CADancerKeyPathPositionY;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.centerY);
        self.wkc_to = @(self.centerY + relativeY);
        self.wkc_theDancer = WKCDancerMoveY;
        return self;
    };
}

- (WKCDancerLayerPoint)moveXY
{
    return ^CALayer * (CGPoint xy) {
        self.wkc_keyPath = CADancerKeyPathPosition;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = [NSValue valueWithCGPoint:CGPointMake(self.centerX, self.centerY)];
        self.wkc_to = [NSValue valueWithCGPoint:CGPointMake(self.centerX + xy.x, self.centerY + xy.y)];
        self.wkc_theDancer = WKCDancerMoveXY;
        return self;
    };
}

- (WKCDancerLayerFloat)moveWidth
{
    return ^CALayer *(CGFloat width) {
        self.wkc_keyPath = CADancerKeyPathWidth;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.width);
        self.wkc_to = @(self.width + width);
        self.wkc_theDancer = WKCDancerMoveWidth;
        return self;
    };
}

- (WKCDancerLayerFloat)moveHeight
{
    return ^CALayer *(CGFloat height) {
        self.wkc_keyPath = CADancerKeyPathHeight;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = @(self.height);
        self.wkc_to = @(self.height + height);
        self.wkc_theDancer = WKCDancerMoveHeight;
        return self;
    };
}

- (WKCDancerLayerSize)moveSize
{
    return ^CALayer *(CGSize size) {
        self.wkc_keyPath = CADancerKeyPathSize;
        self.wkc_isCAAnimation = YES;
        self.wkc_from = [NSValue valueWithCGSize:CGSizeMake(self.width, self.height)];
        self.wkc_to = [NSValue valueWithCGSize:CGSizeMake(self.width + size.width, self.height + size.height)];
        self.wkc_theDancer = WKCDancerMoveSize;
        return self;
    };
}


#pragma mark -ADD
- (WKCDancerLayerFloat)addLeading
{
    return ^CALayer *(CGFloat leading) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyLeading;
        self.wkc_to = @(leading + self.leading);
        self.wkc_theDancer = WKCDancerAddLeading;
        return self;
    };
}

- (WKCDancerLayerFloat)addTraing
{
    return ^CALayer *(CGFloat traing) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyTraing;
        self.wkc_to = @(traing + self.traing);
        self.wkc_theDancer = WKCDancerAddTraing;
        return self;
    };
}

- (WKCDancerLayerFloat)addTop
{
    return ^CALayer *(CGFloat top) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyTop;
        self.wkc_to = @(top + self.top);
        self.wkc_theDancer = WKCDancerAddTop;
        return self;
    };
}

- (WKCDancerLayerFloat)addBottom
{
    return ^CALayer *(CGFloat bottom) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyBottom;
        self.wkc_to = @(bottom + self.bottom);
        self.wkc_theDancer = WKCDancerAddBottom;
        return self;
    };
}

- (WKCDancerLayerFloat)addWidth
{
    return ^CALayer *(CGFloat width) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyWidth;
        self.wkc_to = @(width + self.width);
        self.wkc_theDancer = WKCDancerAddWidth;
        return self;
    };
}

- (WKCDancerLayerFloat)addHeight
{
    return ^CALayer *(CGFloat height) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeyHeight;
        self.wkc_to = @(height + self.height);
        self.wkc_theDancer = WKCDancerAddHeight;
        return self;
    };
}

- (WKCDancerLayerSize)addSize
{
    return ^CALayer *(CGSize size) {
        self.wkc_isCAAnimation = NO;
        self.wkc_frameKeyPath = UIViewDancerKeySize;
        self.wkc_to = [NSValue valueWithCGSize:CGSizeMake(size.width + self.width, size.height + self.height)];
        self.wkc_theDancer = WKCDancerAddSize;
        return self;
    };
}





#pragma mark -TRANSITION
- (WKCDancerLayerTransitionDirection)transitionDir
{
    return ^CALayer *(WKCDancerTransitionDirection direction) {
        self.wkc_isCAAnimation = YES;
        self.wkc_to = direction;
        self.wkc_dancerType = WKCDancerTypeTransition;
        self.wkc_theDancer = WKCDancerTransition;
        return self;
    };
}






#pragma mark -PATH
- (WKCDancerLayerPath)path
{
    return ^CALayer *(UIBezierPath * path) {
        self.wkc_isCAAnimation = YES;
        self.wkc_to = path;
        self.wkc_dancerType = WKCDancerTypePath;
        self.wkc_theDancer = WKCDancerPath;
        self.wkc_keyPath = CADancerKeyPathPosition;
        return self;
    };
}





#pragma mark -CONTENT
- (WKCDancerLayerTimeInterval)delay
{
    return ^CALayer *(NSTimeInterval delay) {
        self.wkc_delay = delay;
        return self;
    };
}


- (WKCDancerLayerRepeat)repeat
{
    return ^CALayer *(NSInteger repeat) {
        self.wkc_repeat = repeat;
        return self;
    };
}


- (WKCDancerLayerAutoreverses)reverses
{
    return ^CALayer *(BOOL isreverses) {
        self.wkc_reverse = isreverses;
        return self;
    };
}


- (WKCDancerLayerTimeInterval)animate
{
    return ^CALayer * (NSTimeInterval duration) {
        self.wkc_animateDuration = duration;
        [self wkc_startDancer];
        return self;
    };
}

- (void)setCompletion:(WKCDancerCompletion)completion
{
    objc_setAssociatedObject(self, &WKCDancerCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKCDancerCompletion)completion
{
    return objc_getAssociatedObject(self, &WKCDancerCompletionKey);
}


- (CALayer *)easeInOut
{
    self.wkc_timing = kCAMediaTimingFunctionEaseInEaseOut;
    self.wkc_options = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (CALayer *)easeIn
{
    self.wkc_timing = kCAMediaTimingFunctionEaseIn;
    self.wkc_options = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (CALayer *)easeOut
{
    self.wkc_timing = kCAMediaTimingFunctionEaseOut;
    self.wkc_options = UIViewAnimationOptionCurveEaseOut;
    return self;
}

- (CALayer *)easeLiner
{
    self.wkc_timing = kCAMediaTimingFunctionLinear;
    self.wkc_options = UIViewAnimationOptionCurveLinear;
    return self;
}

- (CALayer *)spring
{
    self.wkc_dancerType = WKCDancerTypeSpring;
    return self;
}







- (CALayer *)transitionFade
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeFade;
    return self;
}

- (CALayer *)transitionPush
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypePush;
    return self;
}

- (CALayer *)transitionReveal
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeReveal;
    return self;
}

- (CALayer *)transitionMoveIn
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeMoveIn;
    return self;
}

- (CALayer *)transitionCube
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeCube;
    return self;
}

- (CALayer *)transitionSuck
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeSuck;
    return self;
}

- (CALayer *)transitionRipple
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeRipple;
    return self;
}

- (CALayer *)transitionCurl
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeCurl;
    return self;
}

- (CALayer *)transitionUnCurl
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeUnCurl;
    return self;
}

- (CALayer *)transitionFlip
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeFlip;
    return self;
}

- (CALayer *)transitionHollowOpen
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeHollowOpen;
    return self;
}

- (CALayer *)transitionHollowClose
{
    self.wkc_isCAAnimation = YES;
    self.wkc_transitionType = WKCDancerTransitionTypeHollowClose;
    return self;
}





- (CALayer *)then
{
    self.wkc_delay = self.wkc_animateDuration;
    return self;
}






- (void)wkc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.superlayer layoutIfNeeded]; //刷新坐标
        
        if (self.wkc_isCAAnimation)
        {
            if (!self.wkc_timing)
            {
                // 默认Default
                self.wkc_timing = kCAMediaTimingFunctionLinear;
            }
            
            if (self.wkc_dancerType == WKCDancerTypeBase)
            {
                if (!self.wkc_keyPath)
                {
                    self.wkc_keyPath = CADancerKeyPathPosition;
                }
                CABasicAnimation * base = wkc_baseDancerCreate(self.wkc_keyPath, self.wkc_animateDuration, self.wkc_repeat, self.wkc_delay, self.wkc_reverse, self.wkc_timing, self.wkc_from, self.wkc_to);
                
                base.delegate = self;
                [self addAnimation:base forKey:nil];
            }
            else if (self.wkc_dancerType == WKCDancerTypeSpring)
            {
                if (!self.wkc_keyPath)
                {
                    self.wkc_keyPath = CADancerKeyPathPosition;
                }
                CASpringAnimation * spring = wkc_springDancerCreate(self.wkc_keyPath, self.wkc_animateDuration, self.wkc_repeat, self.wkc_delay, self.wkc_reverse, self.wkc_timing, self.wkc_from, self.wkc_to);
                spring.delegate = self;
                [self addAnimation:spring forKey:nil];
            }
            else if (self.wkc_dancerType == WKCDancerTypePath)
            {
                if (!self.wkc_keyPath)
                {
                    self.wkc_keyPath = CADancerKeyPathPosition;
                }
                CAKeyframeAnimation * keyframe = wkc_keyframeDancerCreate(self.wkc_keyPath, self.wkc_animateDuration, self.wkc_repeat, self.wkc_delay, self.wkc_reverse, self.wkc_timing, [(UIBezierPath *)self.wkc_to CGPath]);
                keyframe.delegate = self;
                [self addAnimation:keyframe forKey:nil];
            }
            else if (self.wkc_dancerType == WKCDancerTypeTransition)
            {
                if (!self.wkc_transitionType)
                {
                    self.wkc_transitionType = WKCDancerTransitionTypeFade;
                }
                
                CATransition * transition = wkc_transitionCreate(self.wkc_animateDuration, self.wkc_timing, self.wkc_transitionType, self.wkc_to, self.wkc_repeat, self.wkc_delay, self.wkc_reverse);
                
                transition.delegate = self;
                [self addAnimation:transition forKey:nil];
            }
            
        }
        else
        {
            self.wkc_frameOrigin = self.frame; // 记录当前坐标
            
            if (!self.wkc_options)
            {
                self.wkc_options = UIViewAnimationOptionCurveLinear;
            }
            
            if (self.wkc_reverse)
            {
                if (self.wkc_options == UIViewAnimationOptionCurveEaseInOut)
                {
                    self.wkc_options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else if (self.wkc_options == UIViewAnimationOptionCurveEaseIn)
                {
                    self.wkc_options = UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else if (self.wkc_options == UIViewAnimationOptionCurveEaseOut)
                {
                    self.wkc_options = UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
                else
                {
                    self.wkc_options = UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
                }
            }
            
            if (self.wkc_dancerType == WKCDancerTypeSpring)
            {
                CGFloat damping =  0.85;
                CGFloat velocity = 10.0 ;
                
                [UIView animateWithDuration:self.wkc_animateDuration
                                      delay:self.wkc_delay
                     usingSpringWithDamping:damping
                      initialSpringVelocity:velocity
                                    options:self.wkc_options
                                 animations:^{
                                     
                                     if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyFrame])
                                     {
                                         self.frame = [(NSValue *)self.wkc_to CGRectValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyLeading])
                                     {
                                         self.leading = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyTraing])
                                     {
                                         self.traing = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyTop])
                                     {
                                         self.top = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyBottom])
                                     {
                                         self.bottom = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyWidth])
                                     {
                                         self.width = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyHeight])
                                     {
                                         self.height = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeySize])
                                     {
                                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [(NSValue *)self.wkc_to CGSizeValue].width, [(NSValue *)self.wkc_to CGSizeValue].height);
                                     }
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     if (self.completion)
                                     {
                                         self.completion(self.wkc_theDancer);
                                     }
                                 }];
            }
            else
            {
                [UIView animateWithDuration:self.wkc_animateDuration
                                      delay:self.wkc_delay
                                    options:self.wkc_options
                                 animations:^{
                                     
                                     if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyFrame])
                                     {
                                         self.frame = [(NSValue *)self.wkc_to CGRectValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyLeading])
                                     {
                                         self.leading = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyTraing])
                                     {
                                         self.traing = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyTop])
                                     {
                                         self.top = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyBottom])
                                     {
                                         self.bottom = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyWidth])
                                     {
                                         self.width = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeyHeight])
                                     {
                                         self.height = [self.wkc_to floatValue];
                                     }
                                     else if ([self.wkc_frameKeyPath isEqualToString:UIViewDancerKeySize])
                                     {
                                         self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [(NSValue *)self.wkc_to CGSizeValue].width, [(NSValue *)self.wkc_to CGSizeValue].height);
                                     }
                                     
                                 }
                                 completion:^(BOOL finished) {
                                     
                                     if (self.completion)
                                     {
                                         self.completion(self.wkc_theDancer);
                                     }
                                 }];
            }
            
        }
        
    });
}


- (void)removeDancers
{
    [self removeAllAnimations];
    if (!self.wkc_isCAAnimation)
    {
        CALayer * superLayer = self.superlayer;
        [self removeFromSuperlayer];
        self.frame = self.wkc_frameOrigin;
        [superLayer addSublayer:self];
    }
}

- (void)reloadDancers
{
    [self removeDancers];
    [self wkc_startDancer];
}

#pragma mark -CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.completion)
    {
        self.completion(self.wkc_theDancer);
    }
}

@end
