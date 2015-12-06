//
//  YLAccount.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLAccount.h"

@implementation YLAccount

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInteger:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInteger:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInteger:self.uid forKey:@"uid"];
    
    

}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.access_token = [coder decodeObjectForKey:@"access_token"];
        
        self.remind_in = [coder decodeIntegerForKey:@"remind_in"];
        self.uid = [coder decodeIntegerForKey:@"uid"];
        self.expires_in = [coder decodeIntegerForKey:@"expires_in"];
        
    }
    return self;
}
@end
