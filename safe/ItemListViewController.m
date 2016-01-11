//
//  ItemListViewController.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "ItemListViewController.h"
#import <Realm/Realm.h>
#import "Item.h"
#import "ItemTableViewCell.h"
#import "AddItemViewController.h"

@interface ItemListViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)RLMResults<Item *> *items;
@property(nonatomic,strong)Item *selectedEntry;
@end
@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.items = [[Item allObjects] sortedResultsUsingProperty:@"limit" ascending:YES];
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    Item *entry = self.items[indexPath.row];
    cell.entry = entry;
    
    cell.ItemNameLabel.text = entry.name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"期限:yyyy/MM/dd"];
    NSString *dateStr = [formatter stringFromDate:entry.limit];
    cell.limitLabel.text = dateStr;
    cell.amountLabel.text = [NSString stringWithFormat:@"在庫:%ld個", (long)entry.amount];
    [cell layoutSubviews];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *entry = self.items[indexPath.row];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:entry];
        [realm commitWriteTransaction];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"add"]) {
        
    } else {
        AddItemViewController* vc = [segue.destinationViewController topViewController];
        vc.origineEntry = self.selectedEntry;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedEntry = self.items[indexPath.row];
    return indexPath;
}



@end
