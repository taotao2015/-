//
//  YLhomeDataTool.m
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLhomeDataTool.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLBaseTool.h"
#import "YLLoadNewStatusRP.h"
#import "IWUnReadCount.h"
@implementation YLhomeDataTool
+ (void)getStauseWithSinceId:(long long)sinceId maxId:(long long)maxId  count:(NSInteger)count success:(void(^)(YLLoadNewStatusRP *resp))success faile:(void(^)(NSError *error))faile{

    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"count"] = @(count);
    parameters[@"since_id"] = @(sinceId);
    parameters[@"max_id"] = @(maxId);
    [self getWithUrl:urlString param:parameters class:[YLLoadNewStatusRP class] success:success faile:faile];
}

+ (void)getUnreadWithSuccess:(void(^)(IWUnReadCount *resp))success faile:(void(^)(NSError *error))faile{

    NSString *urlString = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    YLAccount *account = [YLAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    [self getWithUrl:urlString param:parameters class:[IWUnReadCount class] success:success faile:faile];
}
@end
