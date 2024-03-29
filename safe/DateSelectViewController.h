//
//  DateSelectViewController.h
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/26.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selectable.h"

@interface DateSelectViewController : UIViewController<Selectable>
@property(nonatomic,strong)Item *item;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;

@end
