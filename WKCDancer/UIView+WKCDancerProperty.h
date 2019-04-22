//
//  UIView+WKCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCDancerBlock.h"

typedef NS_ENUM(NSInteger, WKCViewEaseType) {
    WKCViewEaseTypeInOut = 0,
    WKCViewEaseTypeIn,
    WKCViewEaseTypeOut,
    WKCViewEaseTypeLiner
};


@interface UIView (WKCDancerProperty)

// MARK: 延时
// animation delay
@property (nonatomic, assign, readwrite) NSTimeInterval wkc_view_delay;

// MARK: 重复次数
// animation repeat
@property (nonatomic, assign, readwrite) NSInteger wkc_view_repeat;

// MARK: 是否恢复
// animation reverse
@property (nonatomic, assign, readwrite) BOOL wkc_view_reverse;

// MARK: 动画时间
// animation duration
@property (nonatomic, assign, readwrite) NSTimeInterval wkc_view_animateDuration;

//MARK: from
// animation from
@property (nonatomic, strong, readwrite) id wkc_view_from;

//MARK: to
// animation to
@property (nonatomic, strong, readwrite) id wkc_view_to;

// MARK: 类型
// animation type
@property (nonatomic, assign, readwrite) WKCDancer wkc_view_theDancer;

// MARK: Ease类型
// animation ease type
@property (nonatomic, assign, readwrite) WKCViewEaseType wkc_view_easeType;

// MARK: 是否spring
// is spring
@property (nonatomic, assign, readwrite) BOOL wkc_view_spring;

// MARK: 是否transition
// is transition
@property (nonatomic, assign, readwrite) BOOL wkc_view_transition;

//MARK: options
@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_view_options;

@end

