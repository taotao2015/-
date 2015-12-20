//
//  YLHttpTool.m
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLHttpTool.h"

@implementation YLHttpTool
+ (void)getWithUrl:(NSString *)url param:(NSMutableDictionary *)param success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faile) {
            faile(error);
        }
    }];

}

+ (void)PostWithUrl:(NSString *)url param:(NSMutableDictionary *)param success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faile) {
            faile(error);
        }
    }];

}

@end
