//
//  SLCDancerBlock.h
//  SLCDancer
//
//  Created by WeiKunChao on 2019/3/22.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SLCDancerMax NSIntegerMax

typedef NS_ENUM(NSInteger, SLCDancer) {
    SLCDancerMakeSize = 0,
    SLCDancerMakePosition,
    SLCDancerMakeX,
    SLCDancerMakeY,
    SLCDancerMakeWidth,
    SLCDancerMakeHeight,
    SLCDancerMakeScale,
    SLCDancerMakeScaleX,
    SLCDancerMakeScaleY,
    SLCDancerMakeRotationX,
    SLCDancerMakeRotationY,
    SLCDancerMakeRotationZ,
    SLCDancerMakeBackground,
    SLCDancerMakeOpacity,
    SLCDancerMakeCornerRadius,
    SLCDancerMakeStrokeEnd,
    SLCDancerMakeContent,
    SLCDancerMakeBorderWidth,
    SLCDancerMakeShadowColor,
    SLCDancerMakeShadowOffset,
    SLCDancerMakeShadowOpacity,
    SLCDancerMakeShadowRadius,
    
    SLCDancerTakeFrame,
    SLCDancerTakeLeading,
    SLCDancerTakeTraing,
    SLCDancerTakeTop,
    SLCDancerTakeBottom,
    SLCDancerTakeWidth,
    SLCDancerTakeHeight,
    SLCDancerTakeSize,
    
    SLCDancerMoveX,
    SLCDancerMoveY,
    SLCDancerMoveXY,
    SLCDancerMoveWidth,
    SLCDancerMoveHeight,
    SLCDancerMoveSize,
    

    SLCDancerAddLeading,
    SLCDancerAddTraing,
    SLCDancerAddTop,
    SLCDancerAddBottom,
    SLCDancerAddWidth,
    SLCDancerAddHeight,
    SLCDancerAddSize,
    
    SLCDancerTransition,
    SLCDancerPath
};

typedef CATransitionSubtype SLCDancerTransitionDirection;
typedef CATransitionType SLCDancerTransitionType;

typedef CALayer * (^SLCDancerLayerRect)(CGRect rect);
typedef CALayer * (^SLCDancerLayerSize)(CGSize size);
typedef CALayer * (^SLCDancerLayerPoint)(CGPoint point);
typedef CALayer * (^SLCDancerLayerFloat)(CGFloat value);
typedef CALayer * (^SLCDancerLayerColor)(UIColor * color);
typedef CALayer * (^SLCDancerLayerContent)(id from, id to);

typedef CALayer * (^SLCDancerLayerPath)(UIBezierPath *path);

typedef CALayer * (^SLCDancerLayerTimeInterval)(NSTimeInterval timeInterval);
typedef CALayer * (^SLCDancerLayerRepeat)(NSInteger repeatCount);
typedef CALayer * (^SLCDancerLayerAutoreverses)(BOOL autoreverses);

typedef CALayer * (^SLCDancerLayerTransitionDirection)(SLCDancerTransitionDirection direction);



typedef UIView * (^SLCDancerViewRect)(CGRect rect);
typedef UIView * (^SLCDancerViewSize)(CGSize size);
typedef UIView * (^SLCDancerViewPoint)(CGPoint point);
typedef UIView * (^SLCDancerViewFloat)(CGFloat value);
typedef UIView * (^SLCDancerViewColor)(UIColor * color);
typedef UIView * (^SLCDancerViewContent)(id from, id to);


typedef UIView * (^SLCDancerViewPath)(UIBezierPath *path);

typedef UIView * (^SLCDancerViewTimeInterval)(NSTimeInterval timeInterval);
typedef UIView * (^SLCDancerViewRepeat)(NSInteger repeatCount);
typedef UIView * (^SLCDancerViewAutoreverses)(BOOL autoreverses);

typedef UIView * (^SLCDancerViewTransitionTo)(UIView *);




typedef UICollectionView * (^SLCDancerCollectionViewFloat)(CGFloat value);
typedef UICollectionView * (^SLCDancerCollectionViewPoint)(CGPoint point);
typedef UICollectionView * (^SLCDancerCollectionViewTimeInterval)(NSTimeInterval timeInterval);
typedef UICollectionView * (^SLCDancerCollectionViewVoid)(void);
typedef UICollectionView * (^SLCDancerCollectionViewFixed)(NSIndexPath * indexPath);
typedef UICollectionView * (^SLCDancerCollectionViewTo)(UIView * to);
typedef UICollectionView * (^SLCDancerCollectionViewBool)(BOOL isDancer);




typedef UITableView * (^SLCDancerTableViewFloat)(CGFloat value);
typedef UITableView * (^SLCDancerTableViewPoint)(CGPoint point);
typedef UITableView * (^SLCDancerTableViewTimeInterval)(NSTimeInterval timeInterval);
typedef UITableView * (^SLCDancerTableViewVoid)(void);
typedef UITableView * (^SLCDancerTableViewFixed)(NSIndexPath * indexPath);
typedef UITableView * (^SLCDancerTableViewTo)(UIView * to);
typedef UITableView * (^SLCDancerTableViewBool)(BOOL isDancer);




typedef void (^SLCDancerCompletion)(SLCDancer animation);
typedef void (^SLCDancerVoidCompletion)(void);
