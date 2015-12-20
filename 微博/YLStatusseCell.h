//
//  YLStatusseCell.h
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLStatueFrame.h"
#define Identifier @"Identifier"
@interface YLStatusseCell : UITableViewCell
@property(strong,nonatomic)YLStatueFrame *statueFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
