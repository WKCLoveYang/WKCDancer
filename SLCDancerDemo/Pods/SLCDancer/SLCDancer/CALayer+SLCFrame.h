//
//  CALayer+SLCFrame.h
//  SLCAnimation
//
//  Created by WeiKunChao on 2019/3/22.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (SLCFrame)

@property (nonatomic, assign) CGFloat leading; //minX
@property (nonatomic, assign) CGFloat top; //minY
@property (nonatomic, assign) CGFloat bottom; //maxY
@property (nonatomic, assign) CGFloat traing; //maxX
@property (nonatomic, assign) CGFloat width; //宽
@property (nonatomic, assign) CGFloat height; //高
@property (nonatomic, assign) CGFloat centerX; //中心X
@property (nonatomic, assign) CGFloat centerY; //中心Y


@end

