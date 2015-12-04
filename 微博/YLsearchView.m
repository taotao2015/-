//
//  YLsearchView.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLsearchView.h"
@interface YLsearchView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightContant;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@end

@implementation YLsearchView

+ (instancetype)searchView{

    return [[[NSBundle mainBundle]loadNibNamed:@"YLsearchView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    //[super awakeFromNib];
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    
    leftView.contentMode = UIViewContentModeCenter;
    //leftView.x = 5;
    self.searchField.delegate = self;
    self.searchField.layer.cornerRadius = 5;
    self.searchField.layer.masksToBounds = YES;
    self.searchField.leftView = leftView;
    self.searchField.leftView.width = 30;
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.rightContant.constant = self.btnWidth.constant;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    [self endEditing:YES];
    
}
- (IBAction)btnClicked:(id)sender {
    
    self.rightContant.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
