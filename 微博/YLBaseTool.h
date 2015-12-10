//
//  YLBaseTool.h
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLBaseTool : NSObject
+ (void)getWithUrl:(NSString *)url param:(NSMutableDictionary *)param class:(Class)claff success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;
+ (void)PostWithUrl:(NSString *)url param:(NSMutableDictionary *)param class:(Class)claff success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))faile;
@end
