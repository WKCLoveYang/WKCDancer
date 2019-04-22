//
//  UIView+SLCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCDancerBlock.h"

typedef NS_ENUM(NSInteger, SLCViewEaseType) {
    SLCViewEaseTypeInOut = 0,
    SLCViewEaseTypeIn,
    SLCViewEaseTypeOut,
    SLCViewEaseTypeLiner
};


@interface UIView (SLCDancerProperty)

// MARK: 延时
// animation delay
@property (nonatomic, assign, readwrite) NSTimeInterval slc_view_delay;

// MARK: 重复次数
// animation repeat
@property (nonatomic, assign, readwrite) NSInteger slc_view_repeat;

// MARK: 是否恢复
// animation reverse
@property (nonatomic, assign, readwrite) BOOL slc_view_reverse;

// MARK: 动画时间
// animation duration
@property (nonatomic, assign, readwrite) NSTimeInterval slc_view_animateDuration;

//MARK: from
// animation from
@property (nonatomic, strong, readwrite) id slc_view_from;

//MARK: to
// animation to
@property (nonatomic, strong, readwrite) id slc_view_to;

// MARK: 类型
// animation type
@property (nonatomic, assign, readwrite) SLCDancer slc_view_theDancer;

// MARK: Ease类型
// animation ease type
@property (nonatomic, assign, readwrite) SLCViewEaseType slc_view_easeType;

// MARK: 是否spring
// is spring
@property (nonatomic, assign, readwrite) BOOL slc_view_spring;

// MARK: 是否transition
// is transition
@property (nonatomic, assign, readwrite) BOOL slc_view_transition;

//MARK: options
@property (nonatomic, assign, readwrite) UIViewAnimationOptions slc_view_options;

@end

