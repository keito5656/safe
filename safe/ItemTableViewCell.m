//
//  ItemTableViewCell.m
//  safe
//
//  Created by YAMAMOTOHIROKI on 2015/12/26.
//  Copyright © 2015年 keito5656. All rights reserved.
//

#import "ItemTableViewCell.h"
#import "Item.h"
#import "UIColor+SafeColor.h"
#import <QuartzCore/QuartzCore.h>
@interface ItemTableViewCell()

@end

@implementation ItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSDate *now = [NSDate date];
    if (self.entry) {
        NSComparisonResult result = [now compare:self.entry.limit];
        
        switch (result) {
            case NSOrderedSame:
                // 同一時刻
                self.limitLabel.textColor = [UIColor lightGrayColor];
                break;
            case NSOrderedAscending:
                // nowよりotherDateのほうが未来
                self.limitLabel.textColor = [UIColor lightGrayColor];
                break;
            case NSOrderedDescending:
                // nowよりotherDateのほうが過去
                self.limitLabel.textColor = [UIColor redColor];
                break;
        }
    }

    
    self.contentBaseView.layer.masksToBounds = NO;
    // 影のかかる方向を指定する
    self.contentBaseView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    // 影の透明度
    self.contentBaseView.layer.shadowOpacity = 0.4f;
    // 影の色
    self.contentBaseView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    // ぼかしの量
    self.contentBaseView.layer.shadowRadius = 2.0f;
    
    self.contentBaseView.layer.cornerRadius = 5;
    
    
    if ([self.entry.category isEqualToString:@"食料、飲料品"]) {
        self.itemImageView.image = [UIImage imageNamed:@"GoodsIcon01"];
    } else if ([self.entry.category isEqualToString:@"高齢者用品"]) {
        self.itemImageView.image = [UIImage imageNamed:@"GoodsIcon02"];
    } else if ([self.entry.category isEqualToString:@"女性用品"]) {
        self.itemImageView.image = [UIImage imageNamed:@"GoodsIcon03"];
    } else if ([self.entry.category isEqualToString:@"生活用品"]) {
        self.itemImageView.image = [UIImage imageNamed:@"GoodsIcon04"];
    } else if ([self.entry.category isEqualToString:@"幼児用品"]) {
        self.itemImageView.image = [UIImage imageNamed:@"GoodsIcon05"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
