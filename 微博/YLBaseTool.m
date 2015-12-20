//
//  YLBaseTool.m
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLHttpTool.h"
@implementation YLBaseTool
+ (void)getWithUrl:(NSString *)url param:(NSMutableDictionary *)param class:(Class)claff success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile{
    [YLHttpTool getWithUrl:url param:param success:^(id responseObject) {
        if (success) {
            id result = [[claff alloc]init];
            [result setKeyValues:responseObject];
            success(result);
            
        }
    } faile:^(NSError *error) {
        
    }];

}

+ (void)PostWithUrl:(NSString *)url param:(NSMutableDictionary *)param class:(Class)claff success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile{
    [YLHttpTool PostWithUrl:url param:param success:^(id responseObject) {
        if (success) {
            id result = [[claff alloc]init];
            [result setKeyValues:responseObject];
            success(result);
        }
    } faile:^(NSError *error) {
        
    }];

}
@end
