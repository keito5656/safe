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
@interface ItemListViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)RLMResults<Item *> *items;
@end
@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.editing = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.items = [Item allObjects];
    [self.tableView reloadData];
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
    cell.ItemNameLabel.text = entry.name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"期限:yyyy/MM/dd"];
    NSString *dateStr = [formatter stringFromDate:entry.limit];
    cell.limitLabel.text = dateStr;
    
    cell.categoryLabel.text = entry.category;
    
    
    cell.amountLabel.text = [NSString stringWithFormat:@"%ld個", entry.amount];
    
    
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
        // ここは空のままでOKです。
    }
}


@end
