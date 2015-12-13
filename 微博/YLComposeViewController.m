//
//  YLComposeViewController.m
//  微博
//
//  Created by tao on 15/12/12.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposeViewController.h"
#import "YLAccountTool.h"
#import "YLTextView.h"
@interface YLComposeViewController ()<UITextViewDelegate>

@end

@implementation YLComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    YLTextView *textView = [[YLTextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    textView.ploceholder = @"第一次我说爱你的时候";
    textView.delegate = self;
    [self.view addSubview:textView];
    
}

- (void)setNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发送" target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    NSString *preStr = @"发微博";
    NSString *nameStr = [YLAccountTool account].screen_name;
    NSString *titleStr = nil;
    if (nameStr) {
        titleStr = [NSString stringWithFormat:@"%@\n%@",preStr,nameStr];
    }else{
        titleStr = preStr;
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSRange preStrRange = [titleStr rangeOfString:preStr];
    NSRange nameStrRange = [titleStr rangeOfString:nameStr];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:preStrRange];
    [attStr addAttribute:NSFontAttributeName value:FONT(16) range:preStrRange];
    if (nameStrRange.location != NSNotFound) {
        
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:nameStrRange];
        [attStr addAttribute:NSFontAttributeName value:FONT(14) range:nameStrRange];
    }
    titleLabel.attributedText = attStr;
    // 这行代码比较重要，之前忘写了，显示不出来
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
}


- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
}


- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send{


}

@end
