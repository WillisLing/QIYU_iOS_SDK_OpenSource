//
//  YSFMixReplyContentConfig.h
//  YSFSessionViewController
//
//  Created by liaosipei on 2018/8/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "YSFBaseSessionContentConfig.h"
@class YSFMixReply;

@interface YSFMixReplyContentConfig : YSFBaseSessionContentConfig <YSFSessionContentConfig>

+ (CGFloat)heightForActionListWithInfo:(NSArray<NSString *> *)info
                    msgContentMaxWidth:(CGFloat)msgContentMaxWidth
                     contentViewInsets:(UIEdgeInsets)contentViewInsets;

@end
