//
//  ItemTableViewCell.h
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/26.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Item;
@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIView  *contentBaseView;
@property (weak, nonatomic) IBOutlet UIImageView  *itemImageView;


@property (nonatomic,weak)Item *entry;
@end
