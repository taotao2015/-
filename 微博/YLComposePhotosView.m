//
//  YLComposePhotosView.m
//  微博
//
//  Created by tao on 15/12/13.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposePhotosView.h"
#import "YLComposePhotoView.h"
@implementation YLComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)addImage:(UIImage *)image{
    YLComposePhotoView *imageView = [[YLComposePhotoView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];

}

- (NSArray *)images{
//    NSMutableArray *arry = [NSMutableArray array];
//    for (UIImageView *image in self.subviews) {
//        [arry addObject:image];
//    }
    
    return [self.subviews valueForKeyPath:@"image"];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonWH = (SCREENW - MARGIN * 2) / 3;
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        UIImageView *imageView = self.subviews[i];
        imageView.width = buttonWH;
        imageView.height = buttonWH;
        
        if (imageView.x == 0 && imageView.y == 0) {
            imageView.x = (buttonWH + MARGIN) * col;
            imageView.y = (buttonWH + MARGIN) * row;
        }
        [UIView animateWithDuration:1.0 animations:^{
            
            imageView.x = (buttonWH + MARGIN) * col;
            imageView.y = (buttonWH + MARGIN) * row;
            
        }];
        
    }
}

@end
