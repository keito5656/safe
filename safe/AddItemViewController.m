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
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *amauntButton;
@property (weak, nonatomic) IBOutlet UIButton *limitButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong)Item *entry;
@end


@implementation AddItemViewController

- (IBAction)deleteButtonTap:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if (self.origineEntry) {
        [realm deleteObject:self.origineEntry];
    }
    [realm commitWriteTransaction];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.entry = [[Item alloc] init];
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = self;
    if (self.origineEntry) {
        self.entry.name = self.origineEntry.name;
        self.entry.amount = self.origineEntry.amount;
        self.entry.limit = self.origineEntry.limit;
        self.entry.category = self.origineEntry.category;
    } else {
        [self.deleteButton removeFromSuperview];
        self.entry.name = @"";
        self.entry.amount = 1;
        self.entry.limit = [NSDate date];
        self.entry.category = @"食料、飲料品";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameField.text = self.entry.name;
    [self.amauntButton setTitle:[NSString stringWithFormat:@"%ld個", (long)self.entry.amount] forState:UIControlStateNormal];
    
    [self.limitButton setTitle:[self.entry dateToString] forState:UIControlStateNormal];
    [self.categoryButton setTitle:self.entry.category forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameField resignFirstResponder];
    return YES;
}

- (IBAction)completeButtonTap:(id)sender {
    self.entry.name = self.nameField.text;
    
    
    if ([self.entry.name  isEqual: @""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"お願いです" message:@"品物名は必ず入れてください" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if (self.origineEntry) {
        [realm deleteObject:self.origineEntry];
    }
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
