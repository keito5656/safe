//
//  UIColor+SafeColor.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/27.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "UIColor+SafeColor.h"

@implementation UIColor (SafeColor)
+ (UIColor *)safe_orangeColor {
    return [UIColor colorWithRed:255.0f/255.0f green:138.0f/255.0f blue:0.0f alpha:1.0f];
}
+ (UIColor *)safe_yellowColor {
    return [UIColor colorWithRed:255.0f/255.0f green:215.0f/255.0f blue:71.0f/255.0f alpha:1.0f];
    
}

@end
