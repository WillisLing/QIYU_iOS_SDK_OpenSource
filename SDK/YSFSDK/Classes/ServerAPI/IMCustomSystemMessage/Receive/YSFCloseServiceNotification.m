//
//  YSFCloseService.m
//  YSFSDK
//
//  Created by amao on 9/7/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "YSFCloseServiceNotification.h"
#import "NSDictionary+YSFJson.h"
#import "YSFApiDefines.h"

@implementation YSFCloseServiceNotification

+ (instancetype)dataByJson:(NSDictionary *)dict
{
    YSFCloseServiceNotification *instance = [[YSFCloseServiceNotification alloc] init];
    instance.sessionId = [dict ysf_jsonLongLong:YSFApiKeySessionId];
    instance.evaluate  = [dict ysf_jsonBool:YSFApiKeyEvaluate];
    return instance;
}

@end
