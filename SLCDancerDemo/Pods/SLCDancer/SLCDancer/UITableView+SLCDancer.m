//
//  UITableView+SLCDancer.m
//  SLCDancerCollectionView
//
//  Created by WeiKunChao on 2019/3/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UITableView+SLCDancer.h"
#import <objc/runtime.h>
#import "UITableView+SLCDancerProperty.h"


static NSString * const SLCTableViewViewCompletionKey = @"slc.collection.completion";

CGAffineTransform tableView_to;
NSInteger tableView_totalItemsCount = 0;

@implementation UITableView (SLCDancer)

- (SLCDancerTableViewFloat)makeScale
{
    return ^ UITableView * (CGFloat scale) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(scale, scale);
        return self;
    };
}

- (SLCDancerTableViewFloat)makeScaleX
{
    return ^ UITableView * (CGFloat scaleX) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(scaleX, 1.0);
        return self;
    };
}

- (SLCDancerTableViewFloat)makeScaleY
{
    return ^ UITableView * (CGFloat scaleY) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(1.0, scaleY);
        return self;
    };
}

- (SLCDancerTableViewFloat)makeRotation
{
    return ^ UITableView * (CGFloat rotation) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeRotation(rotation);
        return self;
    };
}



- (SLCDancerTableViewFloat)moveX
{
    return ^ UITableView * (CGFloat x) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(x, 0);
        return self;
    };
}

- (SLCDancerTableViewFloat)moveY
{
    return ^ UITableView * (CGFloat y) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(0, y);
        return self;
    };
}

- (SLCDancerTableViewPoint)moveXY
{
    return ^ UITableView * (CGPoint xy) {
        [self slc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(xy.x, xy.y);
        return self;
    };
}



#pragma mark -TRANSITION
- (SLCDancerTableViewTo)transitionTo
{
    return ^ UITableView * (UIView * to) {
        [self slc_resetInitParams];
        self.slc_tableView_transition = SLCTableViewTransitionFrom;
        self.slc_tableView_transition_to = to;
        return self;
    };
}


#pragma mark -ITEMDURATION
- (SLCDancerTableViewTimeInterval)itemDuration
{
    return ^ UITableView * (NSTimeInterval duration) {
        self.slc_tableView_itemDuration = duration;
        return self;
    };
}

- (SLCDancerTableViewTimeInterval)itemDelay
{
    return ^ UITableView * (NSTimeInterval delay) {
        self.slc_tableView_itemDelay = delay;
        return self;
    };
}


- (SLCDancerTableViewBool)headerDancer
{
    return ^ UITableView * (BOOL dancer) {
        self.slc_tableView_isHeaderDancer = dancer;
        return self;
    };
}

- (SLCDancerTableViewBool)footerDancer
{
    return ^ UITableView * (BOOL dancer) {
        self.slc_tableView_isFooterDancer = dancer;
        return self;
    };
}



#pragma mark -RELOAD
- (SLCDancerTableViewVoid)reloadDataWithDancer
{
    return ^ UITableView * (void) {
        self.slc_tableView_reload = SLCTableViewReloadTypeVisible;
        [self slc_startDancer];
        return self;
    };
}

- (SLCDancerTableViewFixed)reloadDataFixedWithDancer
{
    return ^ UITableView * (NSIndexPath * indexPath) {
        self.slc_tableView_reload = SLCTableViewReloadTypeFixed;
        self.slc_tableView_indexPath = indexPath;
        [self slc_startDancer];
        return self;
    };
}


#pragma mark -ANIMATION
- (UITableView *)easeLiner
{
    self.slc_tableView_animationType = UIViewAnimationOptionCurveLinear;
    return self;
}

- (UITableView *)easeInOut
{
    self.slc_tableView_animationType = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UITableView *)easeIn
{
    self.slc_tableView_animationType = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UITableView *)easeOut
{
    self.slc_tableView_animationType = UIViewAnimationOptionCurveEaseOut;
    return self;
}


#pragma mark -TRANSITION
- (UITableView *)transitionFlipFromLeft
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
    return self;
}

- (UITableView *)transitionFromRight
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    return self;
}

- (UITableView *)transitionCurlUp
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCurlUp;
    return self;
}

- (UITableView *)transitionCurlDown
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCurlDown;
    return self;
}

- (UITableView *)transitionCrossDissolve
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCrossDissolve;
    return self;
}

- (UITableView *)transitionFlipFromTop
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromTop;
    return self;
}

- (UITableView *)transitionFlipFromBottom
{
    [self slc_resetInitParams];
    self.slc_tableView_transition = SLCTableViewTransitionContent;
    self.slc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromBottom;
    return self;
}


#pragma mark -SPRING
- (UITableView *)spring
{
    self.slc_tableView_spring = YES;
    return self;
}



- (void)setCompletion:(SLCDancerVoidCompletion)completion
{
    objc_setAssociatedObject(self, &SLCTableViewViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SLCDancerVoidCompletion)completion
{
    return objc_getAssociatedObject(self, &SLCTableViewViewCompletionKey);
}


- (void)slc_resetInitParams
{
    tableView_to = CGAffineTransformIdentity;
    tableView_totalItemsCount = 0;
}

- (void)slc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (self.slc_tableView_reload)
        {
            case SLCTableViewReloadTypeVisible:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                NSInteger sections = self.numberOfSections;
                
                for (NSInteger indexSelection = 0; indexSelection < sections; indexSelection ++)
                {
                    UITableViewHeaderFooterView * header = [self headerViewForSection:indexSelection];
                    UITableViewHeaderFooterView * footer = [self footerViewForSection:indexSelection];
                    
                    NSInteger numbers = [self numberOfRowsInSection:indexSelection];
                    
                    NSTimeInterval delay = tableView_totalItemsCount * self.slc_tableView_itemDelay;
                    
                    if (header && self.slc_tableView_isHeaderDancer)
                    {
                        switch (self.slc_tableView_transition)
                        {
                            case SLCTableViewTransitionNone:
                            {
                                header.transform = tableView_to;
                                
                                if (self.slc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_tableView_animationType
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
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.slc_tableView_animationType
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
                                
                            case SLCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:header
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                                
                            case SLCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:header
                                                        toView:self.slc_tableView_transition_to
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                        
                        
                        tableView_totalItemsCount ++;
                    }
                    
                    
                    for (NSInteger indexItem = 0; indexItem < numbers; indexItem ++)
                    {
                        UITableViewCell * cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexItem inSection:indexSelection]];
                        
                        switch (self.slc_tableView_transition)
                        {
                            case SLCTableViewTransitionNone:
                            {
                                cell.transform = tableView_to;
                                
                                if (self.slc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_tableView_animationType
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
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.slc_tableView_animationType
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
                                
                            case SLCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:cell
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                                
                            case SLCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:cell
                                                        toView:self.slc_tableView_transition_to
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                        
                        tableView_totalItemsCount ++;
                    }
                    
                    
                    if (footer && self.slc_tableView_isFooterDancer)
                    {
                        switch (self.slc_tableView_transition)
                        {
                            case SLCTableViewTransitionNone:
                            {
                                footer.transform = tableView_to;
                                
                                if (self.slc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_tableView_animationType
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
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.slc_tableView_animationType
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
                                
                            case SLCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:footer
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                                
                            case SLCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:footer
                                                        toView:self.slc_tableView_transition_to
                                                      duration:self.slc_tableView_itemDuration
                                                       options:self.slc_tableView_transitionAnimation
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
                        
                        tableView_totalItemsCount ++;
                    }
                }
                
            }
                break;
                
                
            case SLCTableViewReloadTypeFixed:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                UITableViewHeaderFooterView * header = [self headerViewForSection:self.slc_tableView_indexPath.section];
                UITableViewHeaderFooterView * footer = [self footerViewForSection:self.slc_tableView_indexPath.section];
                UITableViewCell * item = [self cellForRowAtIndexPath:self.slc_tableView_indexPath];
                
                if (self.slc_tableView_isHeaderDancer || self.slc_tableView_isFooterDancer)
                {
                    if (self.slc_tableView_isHeaderDancer && header)
                    {
                        switch (self.slc_tableView_transition)
                        {
                            case SLCTableViewTransitionNone:
                            {
                                header.transform = tableView_to;
                                
                                if (self.slc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_tableView_animationType
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
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:0
                                                        options:self.slc_tableView_animationType
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
                                
                                
                            case SLCTableViewTransitionContent:
                            {
                                [UIView transitionWithView:header
                                                  duration:self.slc_tableView_itemDuration
                                                   options:self.slc_tableView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case SLCTableViewTransitionFrom:
                            {
                                [UIView transitionFromView:header
                                                    toView:self.slc_tableView_transition_to
                                                  duration:self.slc_tableView_itemDuration
                                                   options:self.slc_tableView_transitionAnimation
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
                    
                    if (self.slc_tableView_isFooterDancer && footer)
                    {
                        switch (self.slc_tableView_transition)
                        {
                            case SLCTableViewTransitionNone:
                            {
                                footer.transform = tableView_to;
                                
                                if (self.slc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.slc_tableView_animationType
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
                                    [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                          delay:0
                                                        options:self.slc_tableView_animationType
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
                                
                                
                            case SLCTableViewTransitionContent:
                            {
                                [UIView transitionWithView:footer
                                                  duration:self.slc_tableView_itemDuration
                                                   options:self.slc_tableView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case SLCTableViewTransitionFrom:
                            {
                                [UIView transitionFromView:footer
                                                    toView:self.slc_tableView_transition_to
                                                  duration:self.slc_tableView_itemDuration
                                                   options:self.slc_tableView_transitionAnimation
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
                    switch (self.slc_tableView_transition)
                    {
                        case SLCTableViewTransitionNone:
                        {
                            item.transform = tableView_to;
                            
                            if (self.slc_tableView_spring)
                            {
                                [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                      delay:0
                                     usingSpringWithDamping:0.85
                                      initialSpringVelocity:10.0
                                                    options:self.slc_tableView_animationType
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
                                [UIView animateWithDuration:self.slc_tableView_itemDuration
                                                      delay:0
                                                    options:self.slc_tableView_animationType
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
                            
                            
                        case SLCTableViewTransitionContent:
                        {
                            [UIView transitionWithView:item
                                              duration:self.slc_tableView_itemDuration
                                               options:self.slc_tableView_transitionAnimation
                                            animations:nil
                                            completion:^(BOOL finished) {
                                                
                                                if (self.completion)
                                                {
                                                    self.completion();
                                                }
                                            }];
                        }
                            break;
                            
                            
                        case SLCTableViewTransitionFrom:
                        {
                            [UIView transitionFromView:item
                                                toView:self.slc_tableView_transition_to
                                              duration:self.slc_tableView_itemDuration
                                               options:self.slc_tableView_transitionAnimation
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
                
            default:
                break;
        }
        
    });

}

@end
