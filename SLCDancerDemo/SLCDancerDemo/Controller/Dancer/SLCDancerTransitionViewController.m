//
//  SLCDancerTransitionViewController.m
//  SLCDancerDemo
//
//  Created by WeiKunChao on 2019/3/25.
//  Copyright © 2019 SecretLisa. All rights reserved.
//

#import "SLCDancerTransitionViewController.h"

@interface SLCDancerTransitionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImageview;

@end

@implementation SLCDancerTransitionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)face:(id)sender
{
   
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
    
    
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionFade.reverses(YES).animate(1).completion = ^(SLCDancer animation) {
        self.testImageview.image = [UIImage imageNamed:@"content_bg_one"];
    };
    
}

- (IBAction)pushMy:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionPush.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)revealMy:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionReveal.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)movein:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionMoveIn.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)cube:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionCube.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)suck:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionSuck.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)ripple:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionRipple.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}


- (IBAction)curl:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionCurl.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}


- (IBAction)uncurl:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionUnCurl.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)flip:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionFlip.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}


- (IBAction)open:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionHollowOpen.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

- (IBAction)close:(id)sender
{
    self.testImageview.layer.transitionDir(SLCDancerTransitionDirectionFromMiddle).transitionHollowClose.reverses(YES).animate(1);
    self.testImageview.image = [UIImage imageNamed:@"content_bg_two"];
}

@end
