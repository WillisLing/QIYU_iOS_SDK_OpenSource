//
//  NIMMessageMaker.h
//  YSFKit
//
//  Created by chris.
//  Copyright (c) 2015年 NetEase. All rights reserved.
//

@class YSF_NIMMessage;
@protocol YSF_NIMCustomAttachment;

@interface YSFMessageMaker : NSObject

+ (YSF_NIMMessage*)msgWithText:(NSString*)text;

+ (YSF_NIMMessage*)msgWithImage:(UIImage*)image;

+ (YSF_NIMMessage*)msgWithAudio:(NSString*)filePath;

+ (YSF_NIMMessage*)msgWithCustom:(id<YSF_NIMCustomAttachment>) attachment;

@end
