//
//  YSFMixReplyContentView.m
//  YSFSessionViewController
//
//  Created by liaosipei on 2018/8/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "YSFMixReplyContentView.h"
#import "YSFMessageModel.h"
#import "YSFMixReply.h"
#import "UIControl+BlocksKit.h"
#import "NSString+FileTransfer.h"
#import "NSAttributedString+YSF.h"
#import "YSFCoreText.h"

CGFloat const kYSFMixReplyNormalMargin = 15;
CGFloat const kYSFMixReplyHeaderBtmMargin = 12;
CGFloat const kYSFMixReplyContentNormalMargin = 7.5f;
CGFloat const kYSFMixReplyContentSpacing = 0.5f;
CGFloat const kYSFMixReplyArrowRMargin = 20.f;
CGFloat const kYSFMixReplyPointWidth = 4;
CGFloat const kYSFMixReplyActionLabelAndPointMargin = 10;
CGFloat const kYSFMixReplyActionLabelAndArrowMargin = 10;
CGFloat const kYSFMixReplyBubbleArrowMargin = 5;

@interface YSFMixReplyContentView()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation YSFMixReplyContentView

#pragma mark ActionView

+ (UIView *)genActionViewWithTitle:(NSString *)title
                           lastOne:(BOOL)lastOne
                          maxWidth:(CGFloat)maxWidth
                 contentViewInsets:(UIEdgeInsets)contentViewInsets
{
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    
    UIView *point = [[UIView alloc] initWithFrame:CGRectMake(contentViewInsets.left, 0, kYSFMixReplyPointWidth, kYSFMixReplyPointWidth)];
    point.backgroundColor = YSFRGB(0xd6d6d6);
    point.layer.cornerRadius = kYSFMixReplyPointWidth/2;
    [actionView addSubview:point];
    
    UIImage *arrowImage = [UIImage ysf_imageInKit:@"qe_mix_reply_item_arrow"];
    UIImageView *arrow = [[UIImageView alloc] initWithImage:arrowImage];
    arrow.ysf_frameSize = arrowImage.size;
    arrow.ysf_frameRight = actionView.ysf_frameWidth - kYSFMixReplyArrowRMargin;
    [actionView addSubview:arrow];
    
    YSFAttributedLabel *actionLabel = [self genActionLabel];
    [actionLabel setText:title];
    [actionView addSubview:actionLabel];
    CGFloat actionLabelMAxW = maxWidth - (contentViewInsets.left - kYSFMixReplyPointWidth) - kYSFMixReplyActionLabelAndPointMargin - kYSFMixReplyActionLabelAndArrowMargin - kYSFMixReplyPointWidth - kYSFMixReplyArrowRMargin;
    CGSize size = [actionLabel sizeThatFits:CGSizeMake(actionLabelMAxW, CGFLOAT_MAX)];
    actionLabel.ysf_frameTop = kYSFMixReplyContentNormalMargin;
    actionLabel.ysf_frameLeft = point.ysf_frameRight + kYSFMixReplyActionLabelAndPointMargin;
    actionLabel.ysf_frameWidth = actionLabelMAxW;
    actionLabel.ysf_frameHeight = size.height;
    
    point.ysf_frameTop = actionLabel.ysf_frameTop + kYSFMixReplyContentNormalMargin;
    actionView.ysf_frameHeight = actionLabel.ysf_frameBottom + kYSFMixReplyContentNormalMargin;
    
    arrow.ysf_frameCenterY = actionView.ysf_frameCenterY;
    
    if (!lastOne) {
        CGFloat lineDegree = 1. / [UIScreen mainScreen].scale;
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(kYSFMixReplyBubbleArrowMargin, 0, actionView.ysf_frameWidth - kYSFMixReplyBubbleArrowMargin, lineDegree)];
        splitLine.backgroundColor = YSFRGB(0xf0f0f0);
        splitLine.ysf_frameBottom = actionView.ysf_frameBottom;
        [actionView addSubview:splitLine];
    }
    
    return actionView;
}

+ (YSFAttributedLabel *)genActionLabel
{
    YSFAttributedLabel *label = [[YSFAttributedLabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = YSFRGB(0x666666);
    
    return label;
}

- (instancetype)initSessionMessageContentView {
    self = [super initSessionMessageContentView];
    if (self) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (![YSF_NIMSDK sharedSDK].sdkOrKf) {
        _contentView.ysf_frameLeft = -5;
    }
    _contentView.ysf_frameWidth = self.ysf_frameWidth;
    _contentView.ysf_frameHeight = self.ysf_frameHeight;
}

- (void)refresh:(YSFMessageModel *)data
{
    [super refresh:data];
    YSF_NIMCustomObject *object = data.message.messageObject;
    YSFMixReply *mixReply = (YSFMixReply *)object.attachment;
    
    [_contentView ysf_removeAllSubviews];
    __block CGFloat offsetY = self.model.contentViewInsets.top;
    
    YSFAttributedTextView *attrHeader = [[YSFAttributedTextView alloc] initWithFrame:CGRectInfinite];
    attrHeader.shouldDrawImages = NO;
    attrHeader.backgroundColor = [UIColor clearColor];
    
    NSString *labelStr = mixReply.label;
    attrHeader.attributedString = [labelStr ysf_attributedString:self.model.message.isOutgoingMsg];
    if (attrHeader.attributedString.length) {
        offsetY += kYSFMixReplyNormalMargin;
        attrHeader.ysf_frameWidth = self.model.contentSize.width;
        CGSize size = [attrHeader.attributedTextContentView sizeThatFits:CGSizeZero];
        attrHeader.frame = CGRectMake(self.model.contentViewInsets.left, offsetY, self.model.contentSize.width, size.height);
        [attrHeader layoutSubviews];
        [_contentView addSubview:attrHeader];
        offsetY += attrHeader.ysf_frameHeight;
        offsetY += kYSFMixReplyHeaderBtmMargin;
    }
    
    CGFloat lineDegree = 1. / [UIScreen mainScreen].scale;
    UIView *splitLine = [[UIView alloc] init];
    splitLine.backgroundColor = YSFRGB(0xf5f5f5);
    splitLine.frame = CGRectMake(kYSFMixReplyBubbleArrowMargin, offsetY, self.ysf_frameWidth - kYSFMixReplyBubbleArrowMargin, lineDegree);
    [_contentView addSubview:splitLine];
    offsetY += kYSFMixReplyContentSpacing;
    
    __weak typeof(self) weakSelf = self;
    
    [mixReply.actionList enumerateObjectsUsingBlock:^(YSFAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *title = action.validOperation;
        if (title.length) {
            UIView *itemView = [[weakSelf class] genActionViewWithTitle:title
                                                                lastOne:(idx == (mixReply.actionList.count-1))
                                                               maxWidth:self.ysf_frameWidth
                                                      contentViewInsets:self.model.contentViewInsets];
            itemView.ysf_frameTop = offsetY;
            [weakSelf.contentView addSubview:itemView];
            
            UIButton *actionBtn = [[UIButton alloc] initWithFrame:itemView.frame];
            [weakSelf.contentView addSubview:actionBtn];
            [actionBtn ysf_addEventHandler:^(id  _Nonnull sender) {
                YSFKitEvent *event = [[YSFKitEvent alloc] init];
                event.eventName = YSFKitEventNameTapMixReply;
                event.message = weakSelf.model.message;
                event.data = action;
                [weakSelf.delegate onCatchEvent:event];
            } forControlEvents:UIControlEventTouchUpInside];
            
            offsetY += itemView.ysf_frameHeight;
        }
    }];
}

@end
