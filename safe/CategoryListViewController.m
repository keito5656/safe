//
//  CategoryListViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "CategoryListViewController.h"
#import "Item.h"


@implementation CategoryListViewController

- (NSArray*)categoryList {
    return @[
      @"食料、飲料品",
      @"高齢者用品",
      @"女性用品",
      @"生活用品",
      @"幼児用品"
      ];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self categoryList] count];
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self categoryList][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.item.category = [self categoryList][row];
}

@end
