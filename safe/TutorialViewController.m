//
//  TutorialViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2016/01/06.
//  Copyright © 2016年 keito5656. All rights reserved.
//

#import "TutorialViewController.h"
#import "EAIntroView.h"
#import "EAIntroPage.h"

@interface TutorialViewController ()<EAIntroDelegate>

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"tutorial1"];
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"tutorial2"];
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"tutorial3"];
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"tutorial4"];
    EAIntroPage *page5 = [EAIntroPage page];
    page5.bgImage = [UIImage imageNamed:@"tutorial5"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5]];
    [intro setDelegate:self];
    intro.swipeToExit = YES;
    intro.scrollingEnabled = YES;
    intro.tapToNext = YES;
    [intro showInView:self.view animateDuration:0.0];
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
