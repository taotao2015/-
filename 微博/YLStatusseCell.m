//
//  YLStatusseCell.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatusseCell.h"

@implementation YLStatusseCell


- (void)setStatueFrame:(YLStatueFrame *)statueFrame{
    _statueFrame = statueFrame;
    self.textLabel.text = statueFrame.statuses.text;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    YLStatusseCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    return cell;

}


@end
