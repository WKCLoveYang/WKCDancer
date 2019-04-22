//
//  WKCDancerBlock.h
//  WKCDancer
//
//  Created by WeiKunChao on 2019/3/22.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WKCDancerMax NSIntegerMax

typedef NS_ENUM(NSInteger, WKCDancer) {
    WKCDancerMakeSize = 0,
    WKCDancerMakePosition,
    WKCDancerMakeX,
    WKCDancerMakeY,
    WKCDancerMakeWidth,
    WKCDancerMakeHeight,
    WKCDancerMakeScale,
    WKCDancerMakeScaleX,
    WKCDancerMakeScaleY,
    WKCDancerMakeRotationX,
    WKCDancerMakeRotationY,
    WKCDancerMakeRotationZ,
    WKCDancerMakeBackground,
    WKCDancerMakeOpacity,
    WKCDancerMakeCornerRadius,
    WKCDancerMakeStrokeEnd,
    WKCDancerMakeContent,
    WKCDancerMakeBorderWidth,
    WKCDancerMakeShadowColor,
    WKCDancerMakeShadowOffset,
    WKCDancerMakeShadowOpacity,
    WKCDancerMakeShadowRadius,
    
    WKCDancerTakeFrame,
    WKCDancerTakeLeading,
    WKCDancerTakeTraing,
    WKCDancerTakeTop,
    WKCDancerTakeBottom,
    WKCDancerTakeWidth,
    WKCDancerTakeHeight,
    WKCDancerTakeSize,
    
    WKCDancerMoveX,
    WKCDancerMoveY,
    WKCDancerMoveXY,
    WKCDancerMoveWidth,
    WKCDancerMoveHeight,
    WKCDancerMoveSize,
    

    WKCDancerAddLeading,
    WKCDancerAddTraing,
    WKCDancerAddTop,
    WKCDancerAddBottom,
    WKCDancerAddWidth,
    WKCDancerAddHeight,
    WKCDancerAddSize,
    
    WKCDancerTransition,
    WKCDancerPath
};

typedef CATransitionSubtype WKCDancerTransitionDirection;
typedef CATransitionType WKCDancerTransitionType;

typedef CALayer * (^WKCDancerLayerRect)(CGRect rect);
typedef CALayer * (^WKCDancerLayerSize)(CGSize size);
typedef CALayer * (^WKCDancerLayerPoint)(CGPoint point);
typedef CALayer * (^WKCDancerLayerFloat)(CGFloat value);
typedef CALayer * (^WKCDancerLayerColor)(UIColor * color);
typedef CALayer * (^WKCDancerLayerContent)(id from, id to);

typedef CALayer * (^WKCDancerLayerPath)(UIBezierPath *path);

typedef CALayer * (^WKCDancerLayerTimeInterval)(NSTimeInterval timeInterval);
typedef CALayer * (^WKCDancerLayerRepeat)(NSInteger repeatCount);
typedef CALayer * (^WKCDancerLayerAutoreverses)(BOOL autoreverses);

typedef CALayer * (^WKCDancerLayerTransitionDirection)(WKCDancerTransitionDirection direction);



typedef UIView * (^WKCDancerViewRect)(CGRect rect);
typedef UIView * (^WKCDancerViewSize)(CGSize size);
typedef UIView * (^WKCDancerViewPoint)(CGPoint point);
typedef UIView * (^WKCDancerViewFloat)(CGFloat value);
typedef UIView * (^WKCDancerViewColor)(UIColor * color);
typedef UIView * (^WKCDancerViewContent)(id from, id to);


typedef UIView * (^WKCDancerViewPath)(UIBezierPath *path);

typedef UIView * (^WKCDancerViewTimeInterval)(NSTimeInterval timeInterval);
typedef UIView * (^WKCDancerViewRepeat)(NSInteger repeatCount);
typedef UIView * (^WKCDancerViewAutoreverses)(BOOL autoreverses);

typedef UIView * (^WKCDancerViewTransitionTo)(UIView *);




typedef UICollectionView * (^WKCDancerCollectionViewFloat)(CGFloat value);
typedef UICollectionView * (^WKCDancerCollectionViewPoint)(CGPoint point);
typedef UICollectionView * (^WKCDancerCollectionViewTimeInterval)(NSTimeInterval timeInterval);
typedef UICollectionView * (^WKCDancerCollectionViewVoid)(void);
typedef UICollectionView * (^WKCDancerCollectionViewFixed)(NSIndexPath * indexPath);
typedef UICollectionView * (^WKCDancerCollectionViewTo)(UIView * to);
typedef UICollectionView * (^WKCDancerCollectionViewBool)(BOOL isDancer);




typedef UITableView * (^WKCDancerTableViewFloat)(CGFloat value);
typedef UITableView * (^WKCDancerTableViewPoint)(CGPoint point);
typedef UITableView * (^WKCDancerTableViewTimeInterval)(NSTimeInterval timeInterval);
typedef UITableView * (^WKCDancerTableViewVoid)(void);
typedef UITableView * (^WKCDancerTableViewFixed)(NSIndexPath * indexPath);
typedef UITableView * (^WKCDancerTableViewTo)(UIView * to);
typedef UITableView * (^WKCDancerTableViewBool)(BOOL isDancer);




typedef void (^WKCDancerCompletion)(WKCDancer animation);
typedef void (^WKCDancerVoidCompletion)(void);
