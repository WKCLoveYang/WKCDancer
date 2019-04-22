//
//  AppDelegate.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/24.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCAppDelegate.h"
#import "SLCLaunchViewController.h"

@interface SLCAppDelegate ()

@end

@implementation SLCAppDelegate

- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    return _window;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = [[SLCLaunchViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
