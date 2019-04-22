//
//  UICollectionView+WKCDancer.m
//  WKCDancerCollectionView
//
//  Created by WeiKunChao on 2019/3/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//
// 除transition外, 其他的动画都是反向效果. 目的是确保设置的cell的itemSize就是你的正常需求值.
// 即.如果想要放大,makeScale(0.5), 意思是从0.5倍返回到正常状态.
//
// Except for transition, other animations are reverse effects. The goal is to ensure that the itemSize of the set cell is your normal demand value.
// That is, if you want to zoom in, makeScale(0.5), which means returning from 0.5 times to the normal state.


#import "UICollectionView+WKCDancer.h"
#import <objc/runtime.h>
#import "UICollectionView+WKCDancerProperty.h"


static NSString * const WKCCollecitonViewCompletionKey = @"wkc.collection.completion";

CGAffineTransform collectionView_to;
NSInteger collectionView_totalItemsCount = 0;

@implementation UICollectionView (WKCDancer)

#pragma makr -HEADER SCALE


#pragma mark -MAKE
- (WKCDancerCollectionViewFloat)makeScale
{
    return ^ UICollectionView * (CGFloat scale) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(scale, scale);
        return self;
    };
}

- (WKCDancerCollectionViewFloat)makeScaleX
{
    return ^ UICollectionView * (CGFloat scaleX) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(scaleX, 1.0);
        return self;
    };
}

- (WKCDancerCollectionViewFloat)makeScaleY
{
    return ^ UICollectionView * (CGFloat scaleY) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(1.0, scaleY);
        return self;
    };
}

- (WKCDancerCollectionViewFloat)makeRotation
{
    return ^ UICollectionView * (CGFloat rotation) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeRotation(rotation);
        return self;
    };
}





- (WKCDancerCollectionViewFloat)moveX
{
    return ^ UICollectionView * (CGFloat x) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(x, 0);
        return self;
    };
}

- (WKCDancerCollectionViewFloat)moveY
{
    return ^ UICollectionView * (CGFloat y) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(0, y);
        return self;
    };
}

- (WKCDancerCollectionViewPoint)moveXY
{
    return ^ UICollectionView * (CGPoint xy) {
        [self wkc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(xy.x, xy.y);
        return self;
    };
}



#pragma mark -TRANSITION
- (WKCDancerCollectionViewTo)transitionTo
{
    return ^ UICollectionView * (UIView * to) {
        [self wkc_resetInitParams];
        self.wkc_collectionView_transition = WKCCollectionTransitionFrom;
        self.wkc_collectionView_transition_to = to;
        return self;
    };
}


#pragma mark -ITEMDURATION
- (WKCDancerCollectionViewTimeInterval)itemDuration
{
    return ^ UICollectionView * (NSTimeInterval duration) {
        self.wkc_collectionView_itemDuration = duration;
        return self;
    };
}

- (WKCDancerCollectionViewTimeInterval)itemDelay
{
    return ^ UICollectionView * (NSTimeInterval delay) {
        self.wkc_collectionView_itemDelay = delay;
        return self;
    };
}


- (WKCDancerCollectionViewBool)headerDancer
{
    return ^ UICollectionView * (BOOL dancer) {
        self.wkc_collectionView_isHeaderDancer = dancer;
        return self;
    };
}

- (WKCDancerCollectionViewBool)footerDancer
{
    return ^ UICollectionView * (BOOL dancer) {
        self.wkc_collectionView_isFooterDancer = dancer;
        return self;
    };
}

#pragma mark -RELOAD
- (WKCDancerCollectionViewVoid)reloadDataWithDancer
{
    return ^ UICollectionView * (void) {
        self.wkc_collectionView_reload = WKCCollectionReloadTypeVisible;
        [self wkc_startDancer];
        return self;
    };
}

- (WKCDancerCollectionViewFixed)reloadDataFixedWithDancer
{
    return ^ UICollectionView * (NSIndexPath * indexPath) {
        self.wkc_collectionView_reload = WKCCollectionReloadTypeFixed;
        self.wkc_collectionView_indexPath = indexPath;
        [self wkc_startDancer];
        return self;
    };
}


#pragma mark -ANIMATION
- (UICollectionView *)easeLiner
{
    self.wkc_collectionView_animationType = UIViewAnimationOptionCurveLinear;
    return self;
}

- (UICollectionView *)easeInOut
{
    self.wkc_collectionView_animationType = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UICollectionView *)easeIn
{
    self.wkc_collectionView_animationType = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UICollectionView *)easeOut
{
    self.wkc_collectionView_animationType = UIViewAnimationOptionCurveEaseOut;
    return self;
}


#pragma mark -TRANSITION
- (UICollectionView *)transitionFlipFromLeft
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
    return self;
}

- (UICollectionView *)transitionFromRight
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    return self;
}

- (UICollectionView *)transitionCurlUp
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCurlUp;
    return self;
}

- (UICollectionView *)transitionCurlDown
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCurlDown;
    return self;
}

- (UICollectionView *)transitionCrossDissolve
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCrossDissolve;
    return self;
}

- (UICollectionView *)transitionFlipFromTop
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromTop;
    return self;
}

- (UICollectionView *)transitionFlipFromBottom
{
    [self wkc_resetInitParams];
    self.wkc_collectionView_transition = WKCCollectionTransitionContent;
    self.wkc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromBottom;
    return self;
}


#pragma mark -SPRING
- (UICollectionView *)spring
{
    self.wkc_collectionView_spring = YES;
    return self;
}



- (void)setCompletion:(WKCDancerVoidCompletion)completion
{
    objc_setAssociatedObject(self, &WKCCollecitonViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKCDancerVoidCompletion)completion
{
    return objc_getAssociatedObject(self, &WKCCollecitonViewCompletionKey);
}



- (void)wkc_resetInitParams
{
    collectionView_to = CGAffineTransformIdentity;
    collectionView_totalItemsCount = 0;
}

- (void)wkc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (self.wkc_collectionView_reload)
        {
            case WKCCollectionReloadTypeVisible:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                NSInteger selections = self.numberOfSections;
                
                for (NSInteger indexSelection = 0; indexSelection < selections; indexSelection ++)
                {
                    UICollectionReusableView * header = [self supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexSelection]];
                    
                    UICollectionReusableView * footer = [self supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexSelection]];
                    
                    NSInteger numbers = [self numberOfItemsInSection:indexSelection];
                    
                    NSTimeInterval delay = collectionView_totalItemsCount * self.wkc_collectionView_itemDelay;
                    
                    if (header && self.wkc_collectionView_isHeaderDancer)
                    {
                        
                        switch (self.wkc_collectionView_transition)
                        {
                            case WKCCollectionTransitionNone:
                            {
                                header.transform = collectionView_to;
                                
                                if (self.wkc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         header.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                else
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         header.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                
                            }
                                break;
                                
                            case WKCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:header
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    animations:nil
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                    }];
                                });
                            }
                                break;
                                
                            case WKCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:header
                                                        toView:self.wkc_collectionView_transition_to
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                        
                                                    }];
                                });
                            }
                                break;
                                
                            default:
                                break;
                        }
                        
                        
                        collectionView_totalItemsCount ++;
                    }
                    
                    for (NSInteger indexItem = 0; indexItem < numbers; indexItem ++)
                    {
                        UICollectionViewCell * cell = [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexItem inSection:indexSelection]];
                        
                        switch (self.wkc_collectionView_transition)
                        {
                            case WKCCollectionTransitionNone:
                            {
                                cell.transform = collectionView_to;
                                
                                if (self.wkc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         cell.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                else
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         cell.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                
                            }
                                break;
                                
                            case WKCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:cell
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    animations:nil
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                    }];
                                });
                            }
                                break;
                                
                            case WKCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:cell
                                                        toView:self.wkc_collectionView_transition_to
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                        
                                                    }];
                                });
                            }
                                break;
                                
                            default:
                                break;
                        }
                        
                        collectionView_totalItemsCount ++;
                    }
                    
                    
                    if (footer && self.wkc_collectionView_isFooterDancer)
                    {
                        switch (self.wkc_collectionView_transition)
                        {
                            case WKCCollectionTransitionNone:
                            {
                                footer.transform = collectionView_to;
                                
                                if (self.wkc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         footer.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                else
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         footer.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                
                            }
                                break;
                                
                            case WKCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:footer
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    animations:nil
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                    }];
                                });
                            }
                                break;
                                
                            case WKCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:footer
                                                        toView:self.wkc_collectionView_transition_to
                                                      duration:self.wkc_collectionView_itemDuration
                                                       options:self.wkc_collectionView_transitionAnimation
                                                    completion:^(BOOL finished) {
                                                        
                                                        if (self.completion)
                                                        {
                                                            self.completion();
                                                        }
                                                        
                                                    }];
                                });
                            }
                                break;
                                
                            default:
                                break;
                        }
                        
                        collectionView_totalItemsCount ++;
                    }
                    
                }
            }
                break;
                
            default:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                UICollectionReusableView * header = [self supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:self.wkc_collectionView_indexPath];
                
                UICollectionReusableView * footer = [self supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:self.wkc_collectionView_indexPath];
                
                UICollectionViewCell * item = [self cellForItemAtIndexPath:self.wkc_collectionView_indexPath];
                
                if (self.wkc_collectionView_isHeaderDancer || self.wkc_collectionView_isFooterDancer)
                {
                    if (self.wkc_collectionView_isHeaderDancer && header)
                    {
                        switch (self.wkc_collectionView_transition)
                        {
                            case WKCCollectionTransitionNone:
                            {
                                header.transform = collectionView_to;
                                
                                if (self.wkc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         header.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                else
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         header.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                            }
                                break;
                                
                                
                            case WKCCollectionTransitionContent:
                            {
                                [UIView transitionWithView:header
                                                  duration:self.wkc_collectionView_itemDuration
                                                   options:self.wkc_collectionView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case WKCCollectionTransitionFrom:
                            {
                                [UIView transitionFromView:header
                                                    toView:self.wkc_collectionView_transition_to
                                                  duration:self.wkc_collectionView_itemDuration
                                                   options:self.wkc_collectionView_transitionAnimation
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                    
                                                }];
                            }
                                break;
                                
                            default:
                                break;
                        }
                    }
                    
                    if (self.wkc_collectionView_isFooterDancer && footer)
                    {
                        switch (self.wkc_collectionView_transition)
                        {
                            case WKCCollectionTransitionNone:
                            {
                                footer.transform = collectionView_to;
                                
                                if (self.wkc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         footer.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                                else
                                {
                                    [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                          delay:0
                                                        options:self.wkc_collectionView_animationType
                                                     animations:^{
                                                         
                                                         footer.transform = CGAffineTransformIdentity;
                                                         
                                                     }
                                                     completion:^(BOOL finished) {
                                                         
                                                         if (self.completion)
                                                         {
                                                             self.completion();
                                                         }
                                                         
                                                     }];
                                }
                            }
                                break;
                                
                                
                            case WKCCollectionTransitionContent:
                            {
                                [UIView transitionWithView:footer
                                                  duration:self.wkc_collectionView_itemDuration
                                                   options:self.wkc_collectionView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case WKCCollectionTransitionFrom:
                            {
                                [UIView transitionFromView:footer
                                                    toView:self.wkc_collectionView_transition_to
                                                  duration:self.wkc_collectionView_itemDuration
                                                   options:self.wkc_collectionView_animationType
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                    
                                                }];
                            }
                                break;
                                
                            default:
                                break;
                        }
                    }
                }
                else
                {
                    switch (self.wkc_collectionView_transition)
                    {
                        case WKCCollectionTransitionNone:
                        {
                            item.transform = collectionView_to;
                            
                            if (self.wkc_collectionView_spring)
                            {
                                [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                      delay:0
                                     usingSpringWithDamping:0.85
                                      initialSpringVelocity:10.0
                                                    options:self.wkc_collectionView_animationType
                                                 animations:^{
                                                     
                                                     item.transform = CGAffineTransformIdentity;
                                                     
                                                 }
                                                 completion:^(BOOL finished) {
                                                     
                                                     if (self.completion)
                                                     {
                                                         self.completion();
                                                     }
                                                     
                                                 }];
                            }
                            else
                            {
                                [UIView animateWithDuration:self.wkc_collectionView_itemDuration
                                                      delay:0
                                                    options:self.wkc_collectionView_animationType
                                                 animations:^{
                                                     
                                                     item.transform = CGAffineTransformIdentity;
                                                     
                                                 }
                                                 completion:^(BOOL finished) {
                                                     
                                                     if (self.completion)
                                                     {
                                                         self.completion();
                                                     }
                                                     
                                                 }];
                            }
                        }
                            break;
                            
                            
                        case WKCCollectionTransitionContent:
                        {
                            [UIView transitionWithView:item
                                              duration:self.wkc_collectionView_itemDuration
                                               options:self.wkc_collectionView_transitionAnimation
                                            animations:nil
                                            completion:^(BOOL finished) {
                                                
                                                if (self.completion)
                                                {
                                                    self.completion();
                                                }
                                            }];
                        }
                            break;
                            
                            
                        case WKCCollectionTransitionFrom:
                        {
                            [UIView transitionFromView:item
                                                toView:self.wkc_collectionView_transition_to
                                              duration:self.wkc_collectionView_itemDuration
                                               options:self.wkc_collectionView_transitionAnimation
                                            completion:^(BOOL finished) {
                                                
                                                if (self.completion)
                                                {
                                                    self.completion();
                                                }
                                                
                                            }];
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                }
                
            }
                break;
        }
        
    });
}

@end
