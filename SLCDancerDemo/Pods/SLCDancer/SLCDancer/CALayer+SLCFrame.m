//
//  CALayer+SLCFrame.m
//  SLCAnimation
//
//  Created by WeiKunChao on 2019/3/22.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "CALayer+SLCFrame.h"

@implementation CALayer (SLCFrame)

- (CGFloat)leading
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)traing
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.frame.origin.x + CGRectGetWidth(self.bounds) / 2.0;
}

- (CGFloat)centerY
{
    return self.frame.origin.y + CGRectGetHeight(self.bounds) / 2.0;
}




- (void)setLeading:(CGFloat)leading
{
    self.frame = CGRectMake(leading, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setTop:(CGFloat)top
{
    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (void)setBottom:(CGFloat)bottom
{
    self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setTraing:(CGFloat)traing
{
    self.frame = CGRectMake(traing - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)setCenterX:(CGFloat)centerX
{
    self.frame = CGRectMake(centerX - CGRectGetWidth(self.bounds) / 2.0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setCenterY:(CGFloat)centerY
{
    self.frame = CGRectMake(self.frame.origin.y, centerY - CGRectGetHeight(self.bounds) / 2.0, self.frame.size.width, self.frame.size.height);
}


@end
