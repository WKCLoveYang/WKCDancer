//
//  CALayer+SLCDancer.h
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
//  凡是指定动画方式的,需要第一个调用. 例如makeWidth等
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
//  For the specified animation method, you need the first call. For example, makeWidth, etc.
//


#import <QuartzCore/QuartzCore.h>
#import "SLCDancerBlock.h"

/** 转场动画方向 从右侧*/
UIKIT_EXTERN SLCDancerTransitionDirection SLCDancerTransitionDirectionFromRight;
/** 转场动画方向 从左侧*/
UIKIT_EXTERN SLCDancerTransitionDirection SLCDancerTransitionDirectionFromLeft;
/** 转场动画方向 从顶端*/
UIKIT_EXTERN SLCDancerTransitionDirection SLCDancerTransitionDirectionFromTop;
/** 转场动画方向 从底部*/
UIKIT_EXTERN SLCDancerTransitionDirection SLCDancerTransitionDirectionFromBottom;
/** 转场动画方向 从中间*/
UIKIT_EXTERN SLCDancerTransitionDirection SLCDancerTransitionDirectionFromMiddle;



@interface CALayer (SLCDancer)<CAAnimationDelegate>

// MARK: MAKE 全部以中心点为依据
// Function MAKE, based on the center.
@property (nonatomic, copy, readonly) SLCDancerLayerSize makeSize;
@property (nonatomic, copy, readonly) SLCDancerLayerPoint makePosition;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeX;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeY;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeWidth;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeHeight;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeScale;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeScaleX;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeScaleY;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeRotationX;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeRotationY;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeRotationZ;
@property (nonatomic, copy, readonly) SLCDancerLayerColor makeBackground;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeOpacity;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeCornerRadius;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeStrokeEnd;
@property (nonatomic, copy, readonly) SLCDancerLayerContent makeContent;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeBorderWidth;
@property (nonatomic, copy, readonly) SLCDancerLayerColor makeShadowColor;
@property (nonatomic, copy, readonly) SLCDancerLayerSize makeShadowOffset;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeShadowOpacity;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat makeShadowRadius;




// MARK: TAKE 全部以边界点为依据 (repeat无效)
// Function TAKE, based on the boundary (parameter repeat is unavailable).
@property (nonatomic, copy, readonly) SLCDancerLayerRect takeFrame;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeLeading;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeTraing;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeTop;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeBottom;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeWidth;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat takeHeight;
@property (nonatomic, copy, readonly) SLCDancerLayerSize takeSize;





// MARK: MOVE 相对移动 (以中心点为依据)
// Function MOVE , relative movement (based on the center).
@property (nonatomic, copy, readonly) SLCDancerLayerFloat moveX;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat moveY;
@property (nonatomic, copy, readonly) SLCDancerLayerPoint moveXY;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat moveWidth;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat moveHeight;
@property (nonatomic, copy, readonly) SLCDancerLayerSize moveSize;




// MARK: ADD 相对移动(以边界为依据) (repeat无效)
// Function ADD , relative movement (based on the boundary). (parameter repeat is unavailable).
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addLeading;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addTraing;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addTop;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addBottom;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addWidth;
@property (nonatomic, copy, readonly) SLCDancerLayerFloat addHeight;
@property (nonatomic, copy, readonly) SLCDancerLayerSize addSize;




// MARK: TRANSITION 转场动画
// Transition animation
@property (nonatomic, copy, readonly) SLCDancerLayerTransitionDirection transitionDir;




// MARK: PATH 轨迹动画
// Path animation
@property (nonatomic, copy, readonly) SLCDancerLayerPath path;





// MARK: 通用属性
// Content, general propertys
@property (nonatomic, copy, readonly) SLCDancerLayerTimeInterval delay;
// 注: repeat对TAKE和ADD无效
// NOTE: repeat is unavailable for TAKE and ADD
@property (nonatomic, copy, readonly) SLCDancerLayerRepeat repeat;
@property (nonatomic, copy, readonly) SLCDancerLayerAutoreverses reverses;
@property (nonatomic, copy, readonly) SLCDancerLayerTimeInterval animate;
@property (nonatomic, copy, readwrite) SLCDancerCompletion completion;




// MARK: 动画样式
// animated style
- (CALayer *)easeInOut;
- (CALayer *)easeIn;
- (CALayer *)easeOut;
- (CALayer *)easeLiner;



// MARK: 转场动画样式 (只适用于TRANSITION, spring无效)
// Transition animation style (only for TRANSITION, spring is unavailable)
- (CALayer *)transitionFade; // 淡入淡出
- (CALayer *)transitionPush; // 推进效果
- (CALayer *)transitionReveal; // 揭开效果
- (CALayer *)transitionMoveIn; // 移入效果
- (CALayer *)transitionCube; // 方块效果
- (CALayer *)transitionSuck; // 三角效果
- (CALayer *)transitionRipple; // 水波效果
- (CALayer *)transitionCurl; // 上翻页效果
- (CALayer *)transitionUnCurl; // 下翻页效果
- (CALayer *)transitionFlip; // 上下翻转效果
- (CALayer *)transitionHollowOpen; // 镜头快门开效果
- (CALayer *)transitionHollowClose; // 镜头快门关效果




// MARK: 弹性
// bounce
- (CALayer *)spring;




// MARK: 关联动画,then以后前一个完成后才完成第二个
//Associated animation, after the previous one is completed, then the second animate.
- (CALayer *)then;




// MARK: 刷新动画 - 移除旧的重新添加一遍
// reload animations
- (void)reloadDancers;






// MARK: 移除动画
// remove animations
- (void)removeDancers;



@end

