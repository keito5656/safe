//
//  CategoryListViewController.h
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selectable.h"
@interface CategoryListViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,Selectable>
@property(nonatomic,strong)Item *item;

@end
