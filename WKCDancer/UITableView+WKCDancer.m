//
//  UITableView+WKCDancer.m
//  WKCDancerCollectionView
//
//  Created by WeiKunChao on 2019/3/28.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "UITableView+WKCDancer.h"
#import <objc/runtime.h>
#import "UITableView+WKCDancerProperty.h"


static NSString * const WKCTableViewViewCompletionKey = @"wkc.collection.completion";

CGAffineTransform tableView_to;
NSInteger tableView_totalItemsCount = 0;

@implementation UITableView (WKCDancer)

- (WKCDancerTableViewFloat)makeScale
{
    return ^ UITableView * (CGFloat scale) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(scale, scale);
        return self;
    };
}

- (WKCDancerTableViewFloat)makeScaleX
{
    return ^ UITableView * (CGFloat scaleX) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(scaleX, 1.0);
        return self;
    };
}

- (WKCDancerTableViewFloat)makeScaleY
{
    return ^ UITableView * (CGFloat scaleY) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeScale(1.0, scaleY);
        return self;
    };
}

- (WKCDancerTableViewFloat)makeRotation
{
    return ^ UITableView * (CGFloat rotation) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeRotation(rotation);
        return self;
    };
}



- (WKCDancerTableViewFloat)moveX
{
    return ^ UITableView * (CGFloat x) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(x, 0);
        return self;
    };
}

- (WKCDancerTableViewFloat)moveY
{
    return ^ UITableView * (CGFloat y) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(0, y);
        return self;
    };
}

- (WKCDancerTableViewPoint)moveXY
{
    return ^ UITableView * (CGPoint xy) {
        [self wkc_resetInitParams];
        tableView_to = CGAffineTransformMakeTranslation(xy.x, xy.y);
        return self;
    };
}



#pragma mark -TRANSITION
- (WKCDancerTableViewTo)transitionTo
{
    return ^ UITableView * (UIView * to) {
        [self wkc_resetInitParams];
        self.wkc_tableView_transition = WKCTableViewTransitionFrom;
        self.wkc_tableView_transition_to = to;
        return self;
    };
}


#pragma mark -ITEMDURATION
- (WKCDancerTableViewTimeInterval)itemDuration
{
    return ^ UITableView * (NSTimeInterval duration) {
        self.wkc_tableView_itemDuration = duration;
        return self;
    };
}

- (WKCDancerTableViewTimeInterval)itemDelay
{
    return ^ UITableView * (NSTimeInterval delay) {
        self.wkc_tableView_itemDelay = delay;
        return self;
    };
}


- (WKCDancerTableViewBool)headerDancer
{
    return ^ UITableView * (BOOL dancer) {
        self.wkc_tableView_isHeaderDancer = dancer;
        return self;
    };
}

- (WKCDancerTableViewBool)footerDancer
{
    return ^ UITableView * (BOOL dancer) {
        self.wkc_tableView_isFooterDancer = dancer;
        return self;
    };
}



#pragma mark -RELOAD
- (WKCDancerTableViewVoid)reloadDataWithDancer
{
    return ^ UITableView * (void) {
        self.wkc_tableView_reload = WKCTableViewReloadTypeVisible;
        [self wkc_startDancer];
        return self;
    };
}

- (WKCDancerTableViewFixed)reloadDataFixedWithDancer
{
    return ^ UITableView * (NSIndexPath * indexPath) {
        self.wkc_tableView_reload = WKCTableViewReloadTypeFixed;
        self.wkc_tableView_indexPath = indexPath;
        [self wkc_startDancer];
        return self;
    };
}


#pragma mark -ANIMATION
- (UITableView *)easeLiner
{
    self.wkc_tableView_animationType = UIViewAnimationOptionCurveLinear;
    return self;
}

- (UITableView *)easeInOut
{
    self.wkc_tableView_animationType = UIViewAnimationOptionCurveEaseInOut;
    return self;
}

- (UITableView *)easeIn
{
    self.wkc_tableView_animationType = UIViewAnimationOptionCurveEaseIn;
    return self;
}

- (UITableView *)easeOut
{
    self.wkc_tableView_animationType = UIViewAnimationOptionCurveEaseOut;
    return self;
}


#pragma mark -TRANSITION
- (UITableView *)transitionFlipFromLeft
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
    return self;
}

- (UITableView *)transitionFromRight
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    return self;
}

- (UITableView *)transitionCurlUp
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCurlUp;
    return self;
}

- (UITableView *)transitionCurlDown
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCurlDown;
    return self;
}

- (UITableView *)transitionCrossDissolve
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionCrossDissolve;
    return self;
}

- (UITableView *)transitionFlipFromTop
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromTop;
    return self;
}

- (UITableView *)transitionFlipFromBottom
{
    [self wkc_resetInitParams];
    self.wkc_tableView_transition = WKCTableViewTransitionContent;
    self.wkc_tableView_transitionAnimation = UIViewAnimationOptionTransitionFlipFromBottom;
    return self;
}


#pragma mark -SPRING
- (UITableView *)spring
{
    self.wkc_tableView_spring = YES;
    return self;
}



- (void)setCompletion:(WKCDancerVoidCompletion)completion
{
    objc_setAssociatedObject(self, &WKCTableViewViewCompletionKey, completion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WKCDancerVoidCompletion)completion
{
    return objc_getAssociatedObject(self, &WKCTableViewViewCompletionKey);
}


- (void)wkc_resetInitParams
{
    tableView_to = CGAffineTransformIdentity;
    tableView_totalItemsCount = 0;
}

- (void)wkc_startDancer
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        switch (self.wkc_tableView_reload)
        {
            case WKCTableViewReloadTypeVisible:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                NSInteger sections = self.numberOfSections;
                
                for (NSInteger indexSelection = 0; indexSelection < sections; indexSelection ++)
                {
                    UITableViewHeaderFooterView * header = [self headerViewForSection:indexSelection];
                    UITableViewHeaderFooterView * footer = [self footerViewForSection:indexSelection];
                    
                    NSInteger numbers = [self numberOfRowsInSection:indexSelection];
                    
                    NSTimeInterval delay = tableView_totalItemsCount * self.wkc_tableView_itemDelay;
                    
                    if (header && self.wkc_tableView_isHeaderDancer)
                    {
                        switch (self.wkc_tableView_transition)
                        {
                            case WKCTableViewTransitionNone:
                            {
                                header.transform = tableView_to;
                                
                                if (self.wkc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_tableView_animationType
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
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_tableView_animationType
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
                                
                            case WKCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:header
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                                
                            case WKCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:header
                                                        toView:self.wkc_tableView_transition_to
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                        
                        switch (self.wkc_tableView_transition)
                        {
                            case WKCTableViewTransitionNone:
                            {
                                cell.transform = tableView_to;
                                
                                if (self.wkc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_tableView_animationType
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
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_tableView_animationType
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
                                
                            case WKCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:cell
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                                
                            case WKCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:cell
                                                        toView:self.wkc_tableView_transition_to
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                    
                    
                    if (footer && self.wkc_tableView_isFooterDancer)
                    {
                        switch (self.wkc_tableView_transition)
                        {
                            case WKCTableViewTransitionNone:
                            {
                                footer.transform = tableView_to;
                                
                                if (self.wkc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_tableView_animationType
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
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:delay
                                                        options:self.wkc_tableView_animationType
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
                                
                            case WKCTableViewTransitionContent:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionWithView:footer
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                                
                            case WKCTableViewTransitionFrom:
                            {
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [UIView transitionFromView:footer
                                                        toView:self.wkc_tableView_transition_to
                                                      duration:self.wkc_tableView_itemDuration
                                                       options:self.wkc_tableView_transitionAnimation
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
                
                
            case WKCTableViewReloadTypeFixed:
            {
                [self reloadData];
                [self layoutIfNeeded];
                
                UITableViewHeaderFooterView * header = [self headerViewForSection:self.wkc_tableView_indexPath.section];
                UITableViewHeaderFooterView * footer = [self footerViewForSection:self.wkc_tableView_indexPath.section];
                UITableViewCell * item = [self cellForRowAtIndexPath:self.wkc_tableView_indexPath];
                
                if (self.wkc_tableView_isHeaderDancer || self.wkc_tableView_isFooterDancer)
                {
                    if (self.wkc_tableView_isHeaderDancer && header)
                    {
                        switch (self.wkc_tableView_transition)
                        {
                            case WKCTableViewTransitionNone:
                            {
                                header.transform = tableView_to;
                                
                                if (self.wkc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_tableView_animationType
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
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:0
                                                        options:self.wkc_tableView_animationType
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
                                
                                
                            case WKCTableViewTransitionContent:
                            {
                                [UIView transitionWithView:header
                                                  duration:self.wkc_tableView_itemDuration
                                                   options:self.wkc_tableView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case WKCTableViewTransitionFrom:
                            {
                                [UIView transitionFromView:header
                                                    toView:self.wkc_tableView_transition_to
                                                  duration:self.wkc_tableView_itemDuration
                                                   options:self.wkc_tableView_transitionAnimation
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
                    
                    if (self.wkc_tableView_isFooterDancer && footer)
                    {
                        switch (self.wkc_tableView_transition)
                        {
                            case WKCTableViewTransitionNone:
                            {
                                footer.transform = tableView_to;
                                
                                if (self.wkc_tableView_spring)
                                {
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:0
                                         usingSpringWithDamping:0.85
                                          initialSpringVelocity:10.0
                                                        options:self.wkc_tableView_animationType
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
                                    [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                          delay:0
                                                        options:self.wkc_tableView_animationType
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
                                
                                
                            case WKCTableViewTransitionContent:
                            {
                                [UIView transitionWithView:footer
                                                  duration:self.wkc_tableView_itemDuration
                                                   options:self.wkc_tableView_transitionAnimation
                                                animations:nil
                                                completion:^(BOOL finished) {
                                                    
                                                    if (self.completion)
                                                    {
                                                        self.completion();
                                                    }
                                                }];
                            }
                                break;
                                
                                
                            case WKCTableViewTransitionFrom:
                            {
                                [UIView transitionFromView:footer
                                                    toView:self.wkc_tableView_transition_to
                                                  duration:self.wkc_tableView_itemDuration
                                                   options:self.wkc_tableView_transitionAnimation
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
                    switch (self.wkc_tableView_transition)
                    {
                        case WKCTableViewTransitionNone:
                        {
                            item.transform = tableView_to;
                            
                            if (self.wkc_tableView_spring)
                            {
                                [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                      delay:0
                                     usingSpringWithDamping:0.85
                                      initialSpringVelocity:10.0
                                                    options:self.wkc_tableView_animationType
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
                                [UIView animateWithDuration:self.wkc_tableView_itemDuration
                                                      delay:0
                                                    options:self.wkc_tableView_animationType
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
                            
                            
                        case WKCTableViewTransitionContent:
                        {
                            [UIView transitionWithView:item
                                              duration:self.wkc_tableView_itemDuration
                                               options:self.wkc_tableView_transitionAnimation
                                            animations:nil
                                            completion:^(BOOL finished) {
                                                
                                                if (self.completion)
                                                {
                                                    self.completion();
                                                }
                                            }];
                        }
                            break;
                            
                            
                        case WKCTableViewTransitionFrom:
                        {
                            [UIView transitionFromView:item
                                                toView:self.wkc_tableView_transition_to
                                              duration:self.wkc_tableView_itemDuration
                                               options:self.wkc_tableView_transitionAnimation
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
