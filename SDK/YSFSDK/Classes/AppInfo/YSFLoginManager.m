//
//  YSFLoginManager.m
//  YSFSDK
//
//  Created by amao on 9/6/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#import "YSFLoginManager.h"

static NSInteger YSFMaxRetryDelay = 64;

@interface YSFLoginManager ()<YSF_NIMLoginManagerDelegate>
@property (nonatomic,strong)    YSFAccountInfo  *appInfo;

@property (nonatomic,assign)    NSInteger retryDelay;

@end

@implementation YSFLoginManager
- (instancetype)init
{
    if (self = [super init]) {
        _retryDelay = 1;
        [[[YSF_NIMSDK sharedSDK] loginManager] addDelegate:self];
    }
    return self;
}

- (void)tryToLogin:(YSFAccountInfo *)info
{
    self.appInfo = info;
    NIMLogApp(@"try to login using %@ ",info.accid);
    NSString *account   = info.accid;
    NSString *token     = info.token;
    
    if (info.isEverLogined) {
        
        [[[YSF_NIMSDK sharedSDK] loginManager] autoLogin:account
                                               token:token];
    }
    else
    {
        [[[YSF_NIMSDK sharedSDK] loginManager] login:account
                                           token:token
                                      completion:^(NSError *error) {
                                          if (error == nil)
                                          {
                                              if (_delegate && [_delegate respondsToSelector:@selector(onLoginSuccess:)])
                                              {
                                                  [_delegate onLoginSuccess:account];
                                              }
                                          }
                                          else
                                          {
                                              [self runLoginErrorCallback:error];
                                          }
                                      }];
    }
}

- (void)onAutoLoginFailed:(NSError *)error
{
    [self runLoginErrorCallback:error];
}

- (void)runLoginErrorCallback:(NSError *)error
{
    NSInteger code = [error code];
    if (code == YSF_NIMRemoteErrorCodeInvalidPass ||
        code == YSF_NIMRemoteErrorCodeExist)
    {
        if(_delegate && [_delegate respondsToSelector:@selector(onFatalLoginFailed:)])
        {
            [_delegate onFatalLoginFailed:error];
        }
    }
    else
    {
        _retryDelay *= 2;
        if (_retryDelay > YSFMaxRetryDelay)
        {
            _retryDelay = 1;
        }
        NIMLogApp(@"retry login after %zd seconds",_retryDelay);

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_retryDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self tryToLogin:self.appInfo];
        });
        
    }
}

@end
