//
//  CALayer+WKCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//
//  链式方式加载动画,所需要的属性.一般情况下,不要显示单独使用此类的内容.

//Chain-loading animations, required properties. In general, don't show content that uses this class alone
//
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "WKCDancerBlock.h"

// 动画类型
typedef NS_ENUM(NSInteger, WKCDancerType) {
    WKCDancerTypeBase = 0,
    WKCDancerTypeSpring,
    WKCDancerTypePath,
    WKCDancerTypeTransition
};

@interface CALayer (WKCDancerProperty)

// MARK: 动画类型
// animation type
@property (nonatomic, assign, readwrite) WKCDancerType wkc_dancerType;

// MARK: timing类型
// timing type
@property (nonatomic, copy, readwrite) CAMediaTimingFunctionName wkc_timing;

// MARK: option类型
// option type
@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_options;

// MARK: 延时
// animation delay
@property (nonatomic, assign, readwrite) NSTimeInterval wkc_delay;

// MARK: 重复次数
// animation repeat
@property (nonatomic, assign, readwrite) NSInteger wkc_repeat;

// MARK: 是否回
// is animation back
@property (nonatomic, assign, readwrite) BOOL wkc_reverse;

// MARK: 是否是CA动画
// is CA animation
@property (nonatomic, assign, readwrite) BOOL wkc_isCAAnimation;

// MARK: 动画时间
// animation duration
@property (nonatomic, assign, readwrite) NSTimeInterval wkc_animateDuration;

// MARK: CA keyPath
// animation CA keyPath
@property (nonatomic, copy, readwrite) NSString * wkc_keyPath;

// MARK: from
// animation from
@property (nonatomic, strong, readwrite) id wkc_from;

// MARK: to
// animation to
@property (nonatomic, strong, readwrite) id wkc_to;


// MARK: frame keyPath
// animation frame keyPath
@property (nonatomic, copy, readwrite) NSString * wkc_frameKeyPath;

// MARK: dancer类型
// animation dancer type
@property (nonatomic, assign, readwrite) WKCDancer wkc_theDancer;

// MARK: transition类型
// animation transition type
@property (nonatomic, copy, readwrite) WKCDancerTransitionType wkc_transitionType;

// MARK: 记录坐标
// record frame
@property (nonatomic, assign, readwrite) CGRect wkc_frameOrigin;

@end


