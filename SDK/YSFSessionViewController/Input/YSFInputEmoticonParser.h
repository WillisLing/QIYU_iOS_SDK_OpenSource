//
//  NIMInputEmoticonParser.h
//  YSFKit
//
//  Created by chris.
//  Copyright (c) 2015 Netease. All rights reserved.
//

typedef enum : NSUInteger
{
    YSFInputTokenTypeText,
    YSFInputTokenTypeEmoticon,
    
} YSFInputTokenType;

@interface YSFInputTextToken : NSObject
@property (nonatomic,copy)      NSString    *text;
@property (nonatomic,assign)    YSFInputTokenType   type;
@end


@interface YSFInputEmoticonParser : NSObject
+ (instancetype)currentParser;
- (NSArray *)tokens:(NSString *)text;
@end
