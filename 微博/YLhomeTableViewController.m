//
//  YLhomeTableViewController.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLhomeTableViewController.h"
#import "YLtemp2ViewController.h"
#import "YLpopButton.h"
#import "YLAccountTool.h"
#import "YLAccount.h"
#import "YLUser.h"
@interface YLhomeTableViewController ()
@property (strong, nonatomic)UIButton *btn;
@end

@implementation YLhomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏内容
    [self setNav];
    
    
    [self userInfoDictionary];
}

- (void)setNav{
    YLhomeTittleButton *button = [[YLhomeTittleButton alloc]init];
  
    [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:(UIControlStateNormal)];
    [button setTitle:@"首页" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(homeTitleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
      self.btn = button;
    self.navigationItem.titleView = button;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" addTarget:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" addTarget:self action:@selector(pop)];
}

- (void)homeTitleButtonClicked{
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.width = 100;
    redView.height = 100;
    redView.userInteractionEnabled = YES;
    YLpopButton *popButton = [[YLpopButton alloc]initWithCustomView:redView showView:self.btn];
    popButton.backgroundColor = [UIColor clearColor];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:popButton];
}

- (void)friendsearch{
    YLtemp2ViewController *temp2 = [[YLtemp2ViewController alloc]init];
    
    [self.navigationController pushViewController:temp2 animated:YES];
}

- (void)pop{
    
    NSLog(@"%s",__func__);
}

- (void)userInfoDictionary{
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    YLAccount *account = [YLAccountTool account];
    parameter[@"access_token"] = account.access_token;
    parameter[@"uid"] = account.uid;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        YLUser *user = [[YLUser alloc]init];
        [user setKeyValues:responseObject];
        YLhomeTittleButton *button = (YLhomeTittleButton *)self.navigationItem.titleView;
        [button setTitle:user.screen_name forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误信息：%@",error);
    }];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
