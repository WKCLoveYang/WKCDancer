//
//  UIView+WKCDancer.h
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

#import <UIKit/UIKit.h>
#import "CALayer+WKCDancer.h"


@interface UIView (WKCDancer)

// MARK: MAKE 全部以中心点为依据
// Function MAKE, based on the center.
@property (nonatomic, copy, readonly) WKCDancerViewSize makeSize;
@property (nonatomic, copy, readonly) WKCDancerViewPoint makePosition;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeX;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeY;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeWidth;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeHeight;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeScale;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeScaleX;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeScaleY;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeRotationX;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeRotationY;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeRotationZ;
@property (nonatomic, copy, readonly) WKCDancerViewColor makeBackground;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeOpacity;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeCornerRadius;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeStrokeEnd;
@property (nonatomic, copy, readonly) WKCDancerViewContent makeContent;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeBorderWidth;
@property (nonatomic, copy, readonly) WKCDancerViewColor makeShadowColor;
@property (nonatomic, copy, readonly) WKCDancerViewSize makeShadowOffset;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeShadowOpacity;
@property (nonatomic, copy, readonly) WKCDancerViewFloat makeShadowRadius;




// MARK: TAKE 全部以边界点为依据 (repeat无效)
// Function TAKE, based on the boundary (parameter repeat is unavailable).
@property (nonatomic, copy, readonly) WKCDancerViewRect takeFrame;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeLeading;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeTraing;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeTop;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeBottom;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeWidth;
@property (nonatomic, copy, readonly) WKCDancerViewFloat takeHeight;
@property (nonatomic, copy, readonly) WKCDancerViewSize takeSize;





// MARK: MOVE 相对移动 (以中心点为依据)
// Function MOVE , relative movement (based on the center).
@property (nonatomic, copy, readonly) WKCDancerViewFloat moveX;
@property (nonatomic, copy, readonly) WKCDancerViewFloat moveY;
@property (nonatomic, copy, readonly) WKCDancerViewPoint moveXY;
@property (nonatomic, copy, readonly) WKCDancerViewFloat moveWidth;
@property (nonatomic, copy, readonly) WKCDancerViewFloat moveHeight;
@property (nonatomic, copy, readonly) WKCDancerViewSize moveSize;




// MARK: ADD 相对移动(以边界为依据) (repeat无效)
// Function ADD , relative movement (based on the boundary). (parameter repeat is unavailable).
@property (nonatomic, copy, readonly) WKCDancerViewFloat addLeading;
@property (nonatomic, copy, readonly) WKCDancerViewFloat addTraing;
@property (nonatomic, copy, readonly) WKCDancerViewFloat addTop;
@property (nonatomic, copy, readonly) WKCDancerViewFloat addBottom;
@property (nonatomic, copy, readonly) WKCDancerViewFloat addWidth;
@property (nonatomic, copy, readonly) WKCDancerViewFloat addHeight;
@property (nonatomic, copy, readonly) WKCDancerViewSize addSize;




// MARK: TRANSITION 转场动画
// Transition animation
// 注: Repeat无效
// NOTE: parameter repeat is unavailable
// 单独transitionFlipFromLeft等,表示当前视图的变化;再调用transitionTo则表示是从当前转换到另一个.
//Individual transitionFlipFromLeft, etc., indicates the change of the current view; then calling transitionTo means that it is converted from the current to another
@property (nonatomic, copy, readonly) WKCDancerViewTransitionTo transitionTo;


// MARK: PATH 轨迹动画
// Path animation
@property (nonatomic, copy, readonly) WKCDancerViewPath path;





// MARK: 通用属性
// Content, general propertys
@property (nonatomic, copy, readonly) WKCDancerViewTimeInterval delay;
@property (nonatomic, copy, readonly) WKCDancerViewRepeat repeat;
@property (nonatomic, copy, readonly) WKCDancerViewAutoreverses reverses;
@property (nonatomic, copy, readonly) WKCDancerViewTimeInterval animate;
@property (nonatomic, copy, readwrite) WKCDancerCompletion completion;





// MARK: 动画样式, TRANSITION时无效
// animated style, Transition is unavailable
- (UIView *)easeInOut;
- (UIView *)easeIn;
- (UIView *)easeOut;
- (UIView *)easeLiner;





// MARK: 转场动画样式 (只适用于TRANSITION, spring无效. 其他通过layer去操作)
// Transition animation style (only for TRANSITION, spring is unavailable, Others operate through the layer)
- (UIView *)transitionFlipFromLeft;
- (UIView *)transitionFromRight;
- (UIView *)transitionCurlUp;
- (UIView *)transitionCurlDown;
- (UIView *)transitionCrossDissolve;
- (UIView *)transitionFlipFromTop;
- (UIView *)transitionFlipFromBottom;





// MARK: 弹性
// bounce
- (UIView *)spring;





// MARK: 关联动画,then以后前一个完成后才完成第二个
//Associated animation, after the previous one is completed, then the second animate.
- (UIView *)then;




// MARK: 刷新动画 - 移除旧的重新添加一遍
// reload animations
- (void)reloadDancers;



// MARK: 移除动画
// remove animations
- (void)removeDancers;




@end

