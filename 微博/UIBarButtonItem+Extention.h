//
//  UIBarButtonItem+Extention.h
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)

+(instancetype)itemWithImageName:(NSString *)imageName addTarget:(id)target action:(SEL)action;
+(instancetype)itemWithImageName:(NSString *)imageName addTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
