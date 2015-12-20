//
//  YLtemp2ViewController.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLtemp2ViewController.h"
#import "YLtemp3ViewController.h"
@interface YLtemp2ViewController ()

@end

@implementation YLtemp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"temp2";
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:<#(NSString *)#> addTarget:<#(id)#> action:<#(SEL)#> title:<#(NSString *)#>
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    YLtemp3ViewController *temp3 = [[YLtemp3ViewController alloc]init];
    [self.navigationController pushViewController:temp3 animated:YES];
}
@end
