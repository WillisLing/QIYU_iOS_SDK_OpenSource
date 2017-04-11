//
//  YSFProductInfoContentConfig.m
//  YSFSessionViewController
//
//  Created by JackyYu on 16/5/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "YSFCommodityInfoContentConfig.h"

@implementation YSFCommodityInfoContentConfig

- (CGSize)contentSize:(CGFloat)cellWidth
{
    CGFloat msgBubbleMaxWidth = (cellWidth - 112);
    CGFloat bubbleLeftToContent = 14;
    CGFloat contentRightToBubble = 14;
    CGFloat msgContentMaxWidth = (msgBubbleMaxWidth - contentRightToBubble - bubbleLeftToContent);
    
    return CGSizeMake(msgContentMaxWidth, 89);
}

- (NSString *)cellContent
{
    return @"YSFSessionCommodityInfoContentView";
}

- (UIEdgeInsets)contentViewInsets
{
    return self.message.isOutgoingMsg ? UIEdgeInsetsMake(0, 12, 0, 14) : UIEdgeInsetsMake(0, 14, 0, 12);
}


@end
