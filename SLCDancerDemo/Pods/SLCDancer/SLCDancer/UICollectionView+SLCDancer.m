//
//  UICollectionView+SLCDancer.m
//  SLCDancerCollectionView
//
//  Created by WeiKunChao on 2019/3/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//
// 除transition外, 其他的动画都是反向效果. 目的是确保设置的cell的itemSize就是你的正常需求值.
// 即.如果想要放大,makeScale(0.5), 意思是从0.5倍返回到正常状态.
//
// Except for transition, other animations are reverse effects. The goal is to ensure that the itemSize of the set cell is your normal demand value.
// That is, if you want to zoom in, makeScale(0.5), which means returning from 0.5 times to the normal state.


#import "UICollectionView+SLCDancer.h"
#import <objc/runtime.h>
#import "UICollectionView+SLCDancerProperty.h"


static NSString * const SLCCollecitonViewCompletionKey = @"slc.collection.completion";

CGAffineTransform collectionView_to;
NSInteger collectionView_totalItemsCount = 0;

@implementation UICollectionView (SLCDancer)

#pragma makr -HEADER SCALE


#pragma mark -MAKE
- (SLCDancerCollectionViewFloat)makeScale
{
    return ^ UICollectionView * (CGFloat scale) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(scale, scale);
        return self;
    };
}

- (SLCDancerCollectionViewFloat)makeScaleX
{
    return ^ UICollectionView * (CGFloat scaleX) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(scaleX, 1.0);
        return self;
    };
}

- (SLCDancerCollectionViewFloat)makeScaleY
{
    return ^ UICollectionView * (CGFloat scaleY) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeScale(1.0, scaleY);
        return self;
    };
}

- (SLCDancerCollectionViewFloat)makeRotation
{
    return ^ UICollectionView * (CGFloat rotation) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeRotation(rotation);
        return self;
    };
}





- (SLCDancerCollectionViewFloat)moveX
{
    return ^ UICollectionView * (CGFloat x) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(x, 0);
        return self;
    };
}

- (SLCDancerCollectionViewFloat)moveY
{
    return ^ UICollectionView * (CGFloat y) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(0, y);
        return self;
    };
}

- (SLCDancerCollectionViewPoint)moveXY
{
    return ^ UICollectionView * (CGPoint xy) {
        [self slc_resetInitParams];
        collectionView_to = CGAffineTransformMakeTranslation(xy.x, xy.y);
        return self;
    };
}



#pragma mark -TRANSITION
- (SLCDancerCollectionViewTo)transitionTo
{
    return ^ UICollectionView * (UIView * to) {
        [self slc_resetInitParams];
        self.slc_collectionView_transition = SLCCollectionTransitionFrom;
        self.slc_collectionView_transition_to = to;
        return self;
    };
}


#pragma mark -ITEMDURATION
- (SLCDancerCollectionViewTimeInterval)itemDuration
{
    return ^ UICollectionView * (NSTimeInterval duration) {
        self.slc_collectionView_itemDuration = duration;
        return self;
    };
}

- (SLCDancerCollectionViewTimeInterval)itemDelay
{
    return ^ UICollectionView * (NSTimeInterval delay) {
        self.slc_collectionView_itemDelay = delay;
        return self;
    };
}


- (SLCDancerCollectionViewBool)headerDancer
{
    return ^ UICollectionView * (BOOL dancer) {
        self.slc_collectionView_isHeaderDancer = dancer;
        return self;
    };
}

- (SLCDancerCollectionViewBool)footerDancer
{
    return ^ UICollectionView * (BOOL dancer) {
        self.slc_collectionView_isFooterDancer = dancer;
        return self;
    };
}

#pragma mark -RELOAD
- (SLCDancerCollectionViewVoid)reloadDataWithDancer
{
    return ^ UICollectionView * (void) {
        self.slc_collectionView_reload = SLCCollectionReloadTypeVisible;
        [self slc_startDancer];
        return self;
    };
}

- (SLCDancerCollectionViewFixed)reloadDataFixedWithDancer
{
    return ^ UICollectionView * (NSIndexPath * indexPath) {
        self.slc_collectionView_reload = SLCCollectionReloadTypeFixed;
        self.slc_collectionView_indexPath = indexPath;
        [self slc_startDancer];
        return self;
    };
}


#pragma mark -ANIMATION
- (UICollectionView *)easeLiner
{
    self.slc_collectionView_animationType = UIViewAnimationOptionCurveLinear;
    return self;
}

- (UICollectionView *)easeInOut
{
    self.slc_collectionView_animationType = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UICollectionView *)easeIn
{
    self.slc_collectionView_animationType = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UICollectionView *)easeOut
{
    self.slc_collectionView_animationType = UIViewAnimationOptionCurveEaseOut;
    return self;
}


#pragma mark -TRANSITION
- (UICollectionView *)transitionFlipFromLeft
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
    return self;
}

- (UICollectionView *)transitionFromRight
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    return self;
}

- (UICollectionView *)transitionCurlUp
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCurlUp;
    return self;
}

- (UICollectionView *)transitionCurlDown
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCurlDown;
    return self;
}

- (UICollectionView *)transitionCrossDissolve
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionCrossDissolve;
    return self;
}

- (UICollectionView *)transitionFlipFromTop
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromTop;
    return self;
}

- (UICollectionView *)transitionFlipFromBottom
{
    [self slc_resetInitParams];
    self.slc_collectionView_transition = SLCCollectionTransitionContent;
    self.slc_collectionView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromBottom;
    return self;
}


#pragma mark -SPRING
- (UICollectionView *)spring
{
    self.slc_collectionView_spring = YES;
    return self;
}



- (void)setCompletion:(SLCDancerVoidCompletion)completion
{
    objc_setAssociatedObject(self, &SLCCollecitonViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLCDancerVoidCompletion)completion
{
    return objc_getAssociatedObject(self, &SLCCollecitonViewCompletionKey);
}



- (void)slc_resetInitParams
{
    collectionView_to = CGAffineTransformIdentity;
    collectionView_totalItemsCount = 0;
}

- (void)slc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (self.slc_collectionView_reload)
        {
            case SLCCollectionReloadTypeVisible:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                NSInteger selections = self.numberOfSections;
                
                for (NSInteger indexSelection = 0; indexSelection < selections; indexSelection ++)
                {
                    UICollectionReusableView * header = [self supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexSelection]];
                    
                    UICollectionReusableView * footer = [self supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexSelection]];
                    
                    NSInteger numbers = [self numberOfItemsInSection:indexSelection];
                    
                    NSTimeInterval delay = collectionView_totalItemsCount * self.slc_collectionView_itemDelay;
                    
                    if (header && self.slc_collectionView_isHeaderDancer)
                    {
                        
                        switch (self.slc_collectionView_transition)
                        {
                            case SLCCollectionTransitionNone:
                            {
                                header.transform = collectionView_to;
                                
                                if (self.slc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_collectionView_animationType
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
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.slc_collectionView_animationType
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
                                
                            case SLCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:header
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                                
                            case SLCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:header
                                                        toView:self.slc_collectionView_transition_to
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                        
                        switch (self.slc_collectionView_transition)
                        {
                            case SLCCollectionTransitionNone:
                            {
                                cell.transform = collectionView_to;
                                
                                if (self.slc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_collectionView_animationType
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
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.slc_collectionView_animationType
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
                                
                            case SLCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:cell
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                                
                            case SLCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:cell
                                                        toView:self.slc_collectionView_transition_to
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                    
                    
                    if (footer && self.slc_collectionView_isFooterDancer)
                    {
                        switch (self.slc_collectionView_transition)
                        {
                            case SLCCollectionTransitionNone:
                            {
                                footer.transform = collectionView_to;
                                
                                if (self.slc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_collectionView_animationType
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
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:delay
                                                        options:self.slc_collectionView_animationType
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
                                
                            case SLCCollectionTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:footer
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                                
                            case SLCCollectionTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:footer
                                                        toView:self.slc_collectionView_transition_to
                                                      duration:self.slc_collectionView_itemDuration
                                                       options:self.slc_collectionView_transitionAnimation
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
                
                UICollectionReusableView * header = [self supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:self.slc_collectionView_indexPath];
                
                UICollectionReusableView * footer = [self supplementaryViewForElementKind:UICollectionElementKindSectionFooter atIndexPath:self.slc_collectionView_indexPath];
                
                UICollectionViewCell * item = [self cellForItemAtIndexPath:self.slc_collectionView_indexPath];
                
                if (self.slc_collectionView_isHeaderDancer || self.slc_collectionView_isFooterDancer)
                {
                    if (self.slc_collectionView_isHeaderDancer && header)
                    {
                        switch (self.slc_collectionView_transition)
                        {
                            case SLCCollectionTransitionNone:
                            {
                                header.transform = collectionView_to;
                                
                                if (self.slc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_collectionView_animationType
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
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:0
                                                        options:self.slc_collectionView_animationType
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
                                
                                
                            case SLCCollectionTransitionContent:
                            {
                                [UIView transitionWithView:header
                                                  duration:self.slc_collectionView_itemDuration
                                                   options:self.slc_collectionView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case SLCCollectionTransitionFrom:
                            {
                                [UIView transitionFromView:header
                                                    toView:self.slc_collectionView_transition_to
                                                  duration:self.slc_collectionView_itemDuration
                                                   options:self.slc_collectionView_transitionAnimation
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
                    
                    if (self.slc_collectionView_isFooterDancer && footer)
                    {
                        switch (self.slc_collectionView_transition)
                        {
                            case SLCCollectionTransitionNone:
                            {
                                footer.transform = collectionView_to;
                                
                                if (self.slc_collectionView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_collectionView_animationType
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
                                    [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                          delay:0
                                                        options:self.slc_collectionView_animationType
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
                                
                                
                            case SLCCollectionTransitionContent:
                            {
                                [UIView transitionWithView:footer
                                                  duration:self.slc_collectionView_itemDuration
                                                   options:self.slc_collectionView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case SLCCollectionTransitionFrom:
                            {
                                [UIView transitionFromView:footer
                                                    toView:self.slc_collectionView_transition_to
                                                  duration:self.slc_collectionView_itemDuration
                                                   options:self.slc_collectionView_animationType
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
                    switch (self.slc_collectionView_transition)
                    {
                        case SLCCollectionTransitionNone:
                        {
                            item.transform = collectionView_to;
                            
                            if (self.slc_collectionView_spring)
                            {
                                [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                      delay:0
                                     usingSpringWithDamping:0.85
                                      initialSpringVelocity:10.0
                                                    options:self.slc_collectionView_animationType
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
                                [UIView animateWithDuration:self.slc_collectionView_itemDuration
                                                      delay:0
                                                    options:self.slc_collectionView_animationType
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
                            
                            
                        case SLCCollectionTransitionContent:
                        {
                            [UIView transitionWithView:item
                                              duration:self.slc_collectionView_itemDuration
                                               options:self.slc_collectionView_transitionAnimation
                                            animations:nil
                                            completion:^(BOOL finished) {
                                                
                                                if (self.completion)
                                                {
                                                    self.completion();
                                                }
                                            }];
                        }
                            break;
                            
                            
                        case SLCCollectionTransitionFrom:
                        {
                            [UIView transitionFromView:item
                                                toView:self.slc_collectionView_transition_to
                                              duration:self.slc_collectionView_itemDuration
                                               options:self.slc_collectionView_transitionAnimation
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
