//
//  YLAccountTool.h
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLAccount.h"
@interface YLAccountTool : NSObject

+ (void)setAccount:(YLAccount *)account;
+ (YLAccount *)account;
@end
