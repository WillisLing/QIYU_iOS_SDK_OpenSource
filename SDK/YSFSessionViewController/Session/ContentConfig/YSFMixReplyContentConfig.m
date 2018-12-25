//
//  YSFMixReplyContentConfig.m
//  YSFSessionViewController
//
//  Created by liaosipei on 2018/8/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "YSFMixReplyContentConfig.h"
#import "YSFMixReply.h"
#import "NSString+FileTransfer.h"
#import "NSAttributedString+YSF.h"
#import "YSFCoreText.h"
#import "YSFMixReplyContentView.h"

@implementation YSFMixReplyContentConfig

+ (CGFloat)heightForActionListWithInfo:(NSArray<NSString *> *)info
                    msgContentMaxWidth:(CGFloat)msgContentMaxWidth
                     contentViewInsets:(UIEdgeInsets)contentViewInsets
{
    __block CGFloat actionListsH = 0;
    [info enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        if (title.length) {
            YSFAttributedLabel *actionLabel = [YSFMixReplyContentView genActionLabel];
            [actionLabel setText:title];
            
            CGFloat actionLabelMaxW = msgContentMaxWidth - (contentViewInsets.left - kYSFMixReplyPointWidth) - kYSFMixReplyActionLabelAndPointMargin - kYSFMixReplyActionLabelAndArrowMargin - kYSFMixReplyPointWidth - kYSFMixReplyArrowRMargin;
            
            CGSize size = [actionLabel sizeThatFits:CGSizeMake(actionLabelMaxW, CGFLOAT_HEIGHT_UNKNOWN)];
            
            actionListsH += kYSFMixReplyContentNormalMargin;
            actionListsH += size.height;
            actionListsH += kYSFMixReplyContentNormalMargin;
            actionListsH += kYSFMixReplyContentSpacing;
        }
    }];
    
    return actionListsH;
}

- (CGSize)contentSize:(CGFloat)cellWidth
{
    YSF_NIMCustomObject *object = self.message.messageObject;
    YSFMixReply *mixReply = (YSFMixReply *)object.attachment;
    
    CGFloat msgBubbleMaxWidth = (cellWidth - 112);
    CGFloat msgContentMaxWidth = msgBubbleMaxWidth - self.contentViewInsets.left - self.contentViewInsets.right;
    CGFloat msgContentFitW = 0;
    __block CGFloat msgContentFitH = 0;
    
    NSString *labelStr = mixReply.label;
    NSAttributedString *attrStr = [labelStr ysf_attributedString:self.message.isOutgoingMsg];
    if (attrStr.length) {

        CGSize size = [attrStr intrinsicContentSizeWithin:CGSizeMake(msgContentMaxWidth, CGFLOAT_HEIGHT_UNKNOWN)];

        msgContentFitW = msgContentMaxWidth;
        msgContentFitH += kYSFMixReplyNormalMargin;
        msgContentFitH += size.height;
        msgContentFitH += kYSFMixReplyHeaderBtmMargin;
        msgContentFitH += kYSFMixReplyContentSpacing;
    }
    
    NSMutableArray<NSString *> *actionList = [[NSMutableArray alloc] init];
    [mixReply.actionList enumerateObjectsUsingBlock:^(YSFAction *action, NSUInteger idx, BOOL *stop) {
        NSString *title = action.validOperation;
        if (title.length) {
            [actionList addObject:title];
        }
    }];
    
    msgContentFitH += [[self class] heightForActionListWithInfo:actionList
                                             msgContentMaxWidth:msgContentMaxWidth
                                              contentViewInsets:self.contentViewInsets];
    
    return CGSizeMake(msgContentFitW, msgContentFitH);
}

- (NSString *)cellContent
{
    return NSStringFromClass(YSFMixReplyContentView.class);
}

- (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(0, kYSFMixReplyNormalMargin + kYSFMixReplyBubbleArrowMargin, 0, 0);
}

@end
