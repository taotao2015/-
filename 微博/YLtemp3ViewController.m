//
//  YLtemp3ViewController.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLtemp3ViewController.h"
#import "YLtemp2ViewController.h"
@interface YLtemp3ViewController ()

@end

@implementation YLtemp3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"temp3";
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //YLtemp2ViewController *temp2 = [[YLtemp2ViewController alloc]init];
    
   // [self.navigationController popToViewController:temp2 animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
