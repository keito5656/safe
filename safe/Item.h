//
//  Item.h
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import <Realm/Realm.h>

@interface Item : RLMObject
@property NSString *name;
@property NSInteger amount;
@property NSDate *limit;
@property NSString *category;
@end
RLM_ARRAY_TYPE(Item)