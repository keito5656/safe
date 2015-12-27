//
//  Selectable.h
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/26.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;
@protocol Selectable <NSObject>
@property(nonatomic,strong)Item *item;
@end
