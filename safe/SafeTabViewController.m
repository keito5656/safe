//
//  SafeTabViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/31.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "SafeTabViewController.h"
#import "EAIntroView.h"
#import "EAIntroPage.h"

@interface SafeTabViewController () <UITabBarControllerDelegate,UITabBarDelegate,EAIntroDelegate>

@end

@implementation SafeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor  = [UIColor redColor];
    UITabBarItem *tbi = [self.tabBar.items objectAtIndex:0];
    tbi.image = [[UIImage imageNamed:@"listTab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tbi.selectedImage = [[UIImage imageNamed:@"listTabSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIEdgeInsets insets = tbi.imageInsets;
    insets.top    =  5.0;
    insets.bottom = -5.0;
    tbi.imageInsets = insets;
    
    UITabBarItem *tbi2 = [self.tabBar.items objectAtIndex:1];
    tbi2.image = [[UIImage imageNamed:@"mapTab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tbi2.selectedImage = [[UIImage imageNamed:@"mapTabSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tbi2.imageInsets = insets;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"fitstUser"]) {
        
        EAIntroPage *page1 = [EAIntroPage page];
        page1.bgImage = [UIImage imageNamed:@"tutorial1"];
//        EAIntroPage *page2 = [EAIntroPage page];
//        page2.bgImage = [UIImage imageNamed:@"tutorial2"];
        EAIntroPage *page3 = [EAIntroPage page];
        page3.bgImage = [UIImage imageNamed:@"tutorial3"];
        EAIntroPage *page4 = [EAIntroPage page];
        page4.bgImage = [UIImage imageNamed:@"tutorial4"];
        EAIntroPage *page5 = [EAIntroPage page];
        page5.bgImage = [UIImage imageNamed:@"tutorial5"];
        
        EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page3,page4,page5]];
        [intro setDelegate:self];
        intro.swipeToExit = YES;
        intro.scrollingEnabled = YES;
        intro.tapToNext = YES;
        [intro showInView:self.view animateDuration:0.0];
        intro.skipButton = nil;
    }
}

- (void)introDidFinish:(EAIntroView *)introView {
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@(YES) forKey:@"fitstUser"];
//    [ud synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
