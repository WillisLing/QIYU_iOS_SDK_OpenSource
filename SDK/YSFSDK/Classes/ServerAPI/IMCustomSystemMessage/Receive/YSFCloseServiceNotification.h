//
//  YSFCloseService.h
//  YSFSDK
//
//  Created by amao on 9/7/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

@interface YSFCloseServiceNotification : NSObject

@property (nonatomic,assign)  long long    sessionId;
@property (nonatomic,assign)    BOOL evaluate;

+ (instancetype)dataByJson:(NSDictionary *)dict;

@end
