//
//  NSString+Extension.h
//  微博
//
//  Created by tao on 15/12/9.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont*)font;
- (CGSize)sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size;
@end
