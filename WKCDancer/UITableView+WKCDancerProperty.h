//
//  UITableView+WKCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WKCTableViewReloadType) {
    WKCTableViewReloadTypeVisible = 0,
    WKCTableViewReloadTypeFixed
};

typedef NS_ENUM(NSInteger, WKCTableViewTransition) {
    WKCTableViewTransitionNone = 0,
    WKCTableViewTransitionContent,
    WKCTableViewTransitionFrom
};

@interface UITableView (WKCDancerProperty)

@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_tableView_animationType;

@property (nonatomic, assign, readwrite) WKCTableViewReloadType wkc_tableView_reload;

@property (nonatomic, assign, readwrite) WKCTableViewTransition wkc_tableView_transition;

@property (nonatomic, assign, readwrite) BOOL wkc_tableView_spring;

@property (nonatomic, assign, readwrite) NSTimeInterval wkc_tableView_itemDuration;

@property (nonatomic, assign, readwrite) NSTimeInterval wkc_tableView_itemDelay;

@property (nonatomic, strong, readwrite) NSIndexPath * wkc_tableView_indexPath;

@property (nonatomic, strong, readwrite) UIView * wkc_tableView_transition_to;

@property (nonatomic, assign, readwrite) UIViewAnimationOptions wkc_tableView_transitionAnimation;

@property (nonatomic, assign, readwrite) BOOL wkc_tableView_isHeaderDancer;

@property (nonatomic, assign, readwrite) BOOL wkc_tableView_isFooterDancer;


@end

