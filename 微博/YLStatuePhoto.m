//
//  YLStatuePhoto.m
//  微博
//
//  Created by tao on 15/12/8.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatuePhoto.h"
@interface YLStatuePhoto()

@property(weak,nonatomic)UIImageView *gifImage;
@end

@implementation YLStatuePhoto

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImageView *gifImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifImage];
        self.gifImage = gifImage;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifImage.x = self.width - self.gifImage.width;
    self.gifImage.y = self.height - self.gifImage.height;

}



- (void)setPhoto:(YLPhoto *)photo{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.hidden = NO;
    
    if ([photo.thumbnail_pic hasSuffix:@".gif"]) {
        self.gifImage.hidden = NO;
    }else{
        self.gifImage.hidden = YES;
    }
    
    //self.gifImage.hidden = ![photo.thumbnail_pic hasSuffix:@".gif"];
}
@end
