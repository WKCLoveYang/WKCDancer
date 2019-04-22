//
//  SLCLaunchViewController.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCLaunchViewController.h"
#import "SLCAppDelegate.h"
#import "SLCMainViewController.h"

@interface SLCLaunchViewController ()

@end

@implementation SLCLaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        SLCAppDelegate * delegate = (SLCAppDelegate *)UIApplication.sharedApplication.delegate;
        delegate.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SLCMainViewController alloc] init]];
        
    });
}



@end
