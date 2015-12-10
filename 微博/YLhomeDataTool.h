//
//  YLhomeDataTool.h
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLLoadNewStatusRP.h"
#import "IWUnReadCount.h"
#import "YLBaseTool.h"
@interface YLhomeDataTool : YLBaseTool

+ (void)getStauseWithSinceId:(long long)sinceId maxId:(long long)maxId  count:(NSInteger)count success:(void(^)(YLLoadNewStatusRP *resp))success faile:(void(^)(NSError *error))faile;

+ (void)getUnreadWithSuccess:(void(^)(IWUnReadCount *resp))success faile:(void(^)(NSError *error))faile;

@end
