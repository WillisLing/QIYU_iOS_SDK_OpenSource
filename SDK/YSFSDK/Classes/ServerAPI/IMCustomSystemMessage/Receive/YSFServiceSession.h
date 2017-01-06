//
//  YSFSession.h
//  YSFSDK
//
//  Created by amao on 8/28/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//


@class YSFShopInfo;

@interface YSFServiceSession : NSObject

@property (nonatomic,copy)      NSString        *serviceId;
@property (nonatomic,assign)    long long       sessionId;
@property (nonatomic,copy)      NSString        *staffId;
@property (nonatomic,assign)    long long       realStaffId;
@property (nonatomic,assign)    long long       groupId;
@property (nonatomic,copy)      NSString        *staffName;
@property (nonatomic,copy)      NSString        *iconUrl;
@property (nonatomic,strong)    NSDate          *lastServiceTime;
@property (nonatomic,assign)    NSInteger       before;
@property (nonatomic,assign)    NSInteger       code;
@property (nonatomic,assign)    BOOL            humanOrMachine;
@property (nonatomic,assign)    BOOL            operatorEable;
@property (nonatomic,copy)      NSString        *notExistTip;
@property (nonatomic,strong)    NSDictionary    *evaluation;
@property (nonatomic,strong)    YSFShopInfo    *shopInfo;           //平台电商的商铺信息

- (BOOL)canOfferService;

+ (YSFServiceSession *)dataByJson:(NSDictionary *)dict;
@end
