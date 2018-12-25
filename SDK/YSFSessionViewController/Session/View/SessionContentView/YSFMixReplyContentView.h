//
//  YSFMixReplyContentView.h
//  YSFSessionViewController
//
//  Created by liaosipei on 2018/8/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "YSFSessionMessageContentView.h"

@class YSFAttributedLabel;

extern CGFloat const kYSFMixReplyNormalMargin;
extern CGFloat const kYSFMixReplyHeaderBtmMargin;
extern CGFloat const kYSFMixReplyContentNormalMargin;
extern CGFloat const kYSFMixReplyContentSpacing;
extern CGFloat const kYSFMixReplyArrowRMargin;
extern CGFloat const kYSFMixReplyPointWidth;
extern CGFloat const kYSFMixReplyActionLabelAndPointMargin;
extern CGFloat const kYSFMixReplyActionLabelAndArrowMargin;
extern CGFloat const kYSFMixReplyBubbleArrowMargin;

@interface YSFMixReplyContentView : YSFSessionMessageContentView

+ (UIView *)genActionViewWithTitle:(NSString *)title
                           lastOne:(BOOL)lastOne
                          maxWidth:(CGFloat)maxWidth
                 contentViewInsets:(UIEdgeInsets)contentViewInsets;

+ (YSFAttributedLabel *)genActionLabel;

@end
