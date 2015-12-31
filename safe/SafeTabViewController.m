//
//  SafeTabViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/31.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "SafeTabViewController.h"

@interface SafeTabViewController () <UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation SafeTabViewController

- (void)viewDidLoad {
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
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

    // Do any additional setup after loading the view.
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
