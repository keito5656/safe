//
//  NOtificationHelper.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/27.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "NOtificationHelper.h"
#import "Item.h"
#import <UIKit/UIKit.h>

@implementation NotificationHelper

+ (void)makeNotification {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    RLMResults<Item *> *items = [Item allObjects];
    for (Item *entry in items) {
        UILocalNotification *notify = [[UILocalNotification alloc] init];
        notify.repeatInterval = kCFCalendarUnitDay;
        notify.fireDate = entry.limit;
        notify.alertBody = [NSString stringWithFormat:@"%@の期限は%@です。確認しましょう", entry.name, [entry dateToString]];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notify];
    }
}
@end
