//
//  AddItemViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "AddItemViewController.h"
#import "Item.h"
#import "Selectable.h"

@interface AddItemViewController()<UITextFieldDelegate>
@property (nonatomic,strong)Item *entry;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *amauntButton;
@property (weak, nonatomic) IBOutlet UIButton *limitButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@end


@implementation AddItemViewController


- (void)viewDidLoad {
    self.entry = [[Item alloc] init];
    self.entry.name = @"";
    self.entry.amount = 1;
    self.entry.limit = [NSDate date];
    self.entry.category = @"Category0";
    }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameField.text = self.entry.name;
    [self.amauntButton setTitle:[NSString stringWithFormat:@"%ld個", (long)self.entry.amount] forState:UIControlStateNormal];
    
    [self.limitButton setTitle:[self.entry dateToString] forState:UIControlStateNormal];
    [self.categoryButton setTitle:self.entry.category forState:UIControlStateNormal];
}


- (IBAction)completeButtonTap:(id)sender {
    self.entry.name = self.nameField.text;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:self.entry];
    [realm commitWriteTransaction];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonTap:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.entry.name = self.nameField.text;
    UIViewController <Selectable> *vc = segue.destinationViewController;
    vc.item = self.entry;
}
@end
