//
//  UITableView+SLCDancerProperty.h
//  ddddd
//
//  Created by WeiKunChao on 2019/4/8.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SLCTableViewReloadType) {
    SLCTableViewReloadTypeVisible = 0,
    SLCTableViewReloadTypeFixed
};

typedef NS_ENUM(NSInteger, SLCTableViewTransition) {
    SLCTableViewTransitionNone = 0,
    SLCTableViewTransitionContent,
    SLCTableViewTransitionFrom
};

@interface UITableView (SLCDancerProperty)

@property (nonatomic, assign, readwrite) UIViewAnimationOptions slc_tableView_animationType;

@property (nonatomic, assign, readwrite) SLCTableViewReloadType slc_tableView_reload;

@property (nonatomic, assign, readwrite) SLCTableViewTransition slc_tableView_transition;

@property (nonatomic, assign, readwrite) BOOL slc_tableView_spring;

@property (nonatomic, assign, readwrite) NSTimeInterval slc_tableView_itemDuration;

@property (nonatomic, assign, readwrite) NSTimeInterval slc_tableView_itemDelay;

@property (nonatomic, strong, readwrite) NSIndexPath * slc_tableView_indexPath;

@property (nonatomic, strong, readwrite) UIView * slc_tableView_transition_to;

@property (nonatomic, assign, readwrite) UIViewAnimationOptions slc_tableView_transitionAnimation;

@property (nonatomic, assign, readwrite) BOOL slc_tableView_isHeaderDancer;

@property (nonatomic, assign, readwrite) BOOL slc_tableView_isFooterDancer;


@end

