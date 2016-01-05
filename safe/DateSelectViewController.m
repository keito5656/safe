//
//  DateSelectViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/26.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "DateSelectViewController.h"
#import "Item.h"
@interface DateSelectViewController ()

@end

@implementation DateSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker.date = self.item.limit;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)valueChange:(id)sender {
    self.item.limit = (NSDate *)[sender date];
    
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
