//
//  Item.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/24.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "Item.h"

@implementation Item
- (NSString*)dateToString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:self.limit];
}
@end
