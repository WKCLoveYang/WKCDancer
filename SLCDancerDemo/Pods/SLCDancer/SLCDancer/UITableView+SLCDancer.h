//
//  UITableView+SLCDancer.h
//  SLCDancerCollectionView
//
//  Created by WeiKunChao on 2019/3/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//
// 除transition外, 其他的动画都是反向效果. 目的是确保设置的cell的itemSize就是你的正常需求值.
// 即.如果想要放大,makeScale(0.5), 意思是从0.5倍返回到正常状态.
// 注: 凡是指定动画方式的,需要第一个调用. 例如makeWidth等
//

// Except for transition, other animations are reverse effects. The goal is to ensure that the itemSize of the set cell is your normal demand value.
// That is, if you want to zoom in, makeScale(0.5), which means returning from 0.5 times to the normal state.
// NOTE: For the specified animation method, you need the first call. For example, makeWidth, etc.
//
// 

#import <UIKit/UIKit.h>
#import "SLCDancerBlock.h"

@interface UITableView (SLCDancer)

// MARK: type
@property (nonatomic, copy, readonly) SLCDancerTableViewFloat makeScale;
@property (nonatomic, copy, readonly) SLCDancerTableViewFloat makeScaleX;
@property (nonatomic, copy, readonly) SLCDancerTableViewFloat makeScaleY;
@property (nonatomic, copy, readonly) SLCDancerTableViewFloat makeRotation;


@property (nonatomic, copy, readonly) SLCDancerTableViewFloat moveX;
@property (nonatomic, copy, readonly) SLCDancerTableViewFloat moveY;
@property (nonatomic, copy, readonly) SLCDancerTableViewPoint moveXY;




// MARK: TRANSITION 转场动画
// Transition animation
// 单独transitionFlipFromLeft等,表示当前视图的变化;再调用transitionTo则表示是从当前转换到另一个.
//Individual transitionFlipFromLeft, etc., indicates the change of the current view; then calling transitionTo means that it is converted from the current to another
@property (nonatomic, copy, readonly) SLCDancerTableViewTo transitionTo;


// MARK: 单个cell动画时间
@property (nonatomic, copy, readonly) SLCDancerTableViewTimeInterval itemDuration;
// cell间隔时间, 默认0.1
@property (nonatomic, copy, readonly) SLCDancerTableViewTimeInterval itemDelay;



// MARK: 头脚是否跟随动画,默认不
@property (nonatomic, copy, readonly) SLCDancerTableViewBool headerDancer;
@property (nonatomic, copy, readonly) SLCDancerTableViewBool footerDancer;






// MAKR: 不适用系统的reloadData刷新数据,使用如下
// 刷新可视cells
@property (nonatomic, copy, readonly) SLCDancerTableViewVoid reloadDataWithDancer;
// 刷新固定cell
@property (nonatomic, copy, readonly) SLCDancerTableViewFixed reloadDataFixedWithDancer;




// MARK: 结束后的回调
@property (nonatomic, copy) SLCDancerVoidCompletion completion;



// MARK: 动画样式, TRANSITION时无效
// animated style, Transition is unavailable
- (UITableView *)easeLiner;
- (UITableView *)easeInOut;
- (UITableView *)easeIn;
- (UITableView *)easeOut;



// MARK: 转场动画样式 (只适用于TRANSITION, spring无效)
// Transition animation style (only for TRANSITION, spring is unavailable)
- (UITableView *)transitionFlipFromLeft;
- (UITableView *)transitionFromRight;
- (UITableView *)transitionCurlUp;
- (UITableView *)transitionCurlDown;
- (UITableView *)transitionCrossDissolve;
- (UITableView *)transitionFlipFromTop;
- (UITableView *)transitionFlipFromBottom;



// MARK: 是否弹性动画
- (UITableView *)spring;


@end

