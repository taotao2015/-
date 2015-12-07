//
//  YLStatueFrame.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatueFrame.h"
#define MARGIN 10
@implementation YLStatueFrame

- (void)setStatuses:(YLLoadNewStatus *)statuses{

    _statuses = statuses;
    CGFloat headImageFX = MARGIN;
    CGFloat headImageFY = MARGIN;
    CGFloat headImageW = 30;
    
    self.headImageF = CGRectMake(headImageFX, headImageFY, headImageW, headImageW);
    CGFloat nameLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGSize nameLabelSize = [statuses.user.screen_name sizeWithFont:FONT(12)];
    self.nameLabelF = CGRectMake(nameLabelX, headImageFY, nameLabelSize.width, nameLabelSize.height);
    
    //CGSize contenLabelSize = [statuses.text sizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contenLabelSize = [statuses.text sizeWithFont:FONT(13) constrainedToSize:CGSizeMake(SCREENW - 2 * MARGIN, MAXFLOAT)];
    self.contentLabelF = CGRectMake(headImageFX, contentLabelY, contenLabelSize.width, contenLabelSize.height);
    
    self.cellHeight = CGRectGetMaxY(self.contentLabelF);
}
@end
