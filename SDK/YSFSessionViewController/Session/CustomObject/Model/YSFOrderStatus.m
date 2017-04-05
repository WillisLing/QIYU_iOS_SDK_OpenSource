#import "YSFOrderStatus.h"
#import "NSDictionary+YSFJson.h"



@implementation YSFOrderStatus

+ (instancetype)objectByDict:(NSDictionary *)dict
{
    YSFOrderStatus *instance = [YSFOrderStatus new];
    instance.label = [dict ysf_jsonString:YSFApiKeyLabel];
    instance.title = [dict ysf_jsonString:YSFApiKeyTitle];
    instance.params = [dict ysf_jsonString:YSFApiKeyParams];
    
    NSArray *list = [dict ysf_jsonArray:YSFApiKeyList];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    [list enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        YSFAction *action = [YSFAction objectByDict:dict];
        [mutableArray addObject:action];
    }];
    instance.actionArray = mutableArray;
    
    return instance;
}

@end
