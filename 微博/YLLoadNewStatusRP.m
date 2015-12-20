//
//  YLLoadNewStatusRP.m
//  微博
//
//  Created by tao on 15/12/10.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLLoadNewStatusRP.h"
#import "YLLoadNewStatus.h"
@implementation YLLoadNewStatusRP

+ (NSDictionary *)objectClassInArray{

    return @{@"statuses":[YLLoadNewStatus class]};

}
@end
