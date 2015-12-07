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
#import "YLLoadNewStatus.h"
#import "YLLoadMoreView.h"
#import "IWUnReadCount.h"
#import <objc/runtime.h>
#define LOAD_COUNT 20
@interface YLhomeTableViewController ()
@property (strong, nonatomic)UIButton *btn;

@property (strong, nonatomic)NSMutableArray *statusArray;
@end

@implementation YLhomeTableViewController

- (NSMutableArray *)statusArray{
    if (_statusArray==nil) {
        
        _statusArray = [NSMutableArray array];
    }

    return _statusArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setNav];
    
    // 设置用户信息
    [self userInfoDictionary];
    YLLoadMoreView *loadView = [YLLoadMoreView loadMoreView];
    
    self.tableView.tableFooterView = loadView;
    loadView.hidden = YES;
    // 刷新微博
    
    [self setRefreshView];
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"呵护"];
    
    
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

- (void)setRefreshView{

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    //这行代码比较重要，不要忘记添加控件
    [self.view addSubview:refreshControl];
       [refreshControl addTarget:self action:@selector(loadNewStatuses:) forControlEvents:UIControlEventValueChanged];
    
    [self loadNewStatuses:refreshControl];
    
}


- (void)loadNewStatuses:(UIRefreshControl *)refreshControl{
    
    
    
    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"count"] = @(LOAD_COUNT);
    if ([self.statusArray firstObject]) {
        parameters[@"since_id"] = @([[self.statusArray firstObject] id]);
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"%@",responseObject);
        [refreshControl endRefreshing];
        NSArray *array= responseObject[@"statuses"];
        
        NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
        [self.statusArray insertObjects:status atIndexes:indexSet];
        [self.tableView reloadData];
      //  self.tabBarItem.badgeValue = nil;
        
        [self loadLabelCountWithCount:status.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误是:%@",error);
        [refreshControl endRefreshing];
    }];

}


- (void)loadMoreStatuses{

    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"count"] = @(LOAD_COUNT);
    if ([self.statusArray firstObject]) {
        parameters[@"max_id"] = @([[self.statusArray lastObject] id] - 1);
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"%@",responseObject);
        
        NSArray *array= responseObject[@"statuses"];
        
        NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
        

        [self.statusArray addObjectsFromArray:status];
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误是:%@",error);
        self.tableView.tableFooterView.hidden = YES;
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.statusArray.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return ;
    }
    
    float result = scrollView.contentSize.height - SCREENH;
    if (result <= (scrollView.contentOffset.y - self.tabBarController.tabBar.height)) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatuses];
    }

}

- (void)showUnReadNumbers{
    
    NSString *urlString = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    YLAccount *account = [YLAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        IWUnReadCount *unRead = [IWUnReadCount objectWithKeyValues:responseObject];
        if (unRead.status) {
           self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",unRead.status];
            [UIApplication sharedApplication].applicationIconBadgeNumber = unRead.status;
        }else{
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"哈哈"];;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

- (void)loadLabelCountWithCount:(NSInteger)count{

    UILabel *loadCount = [[UILabel alloc]init];
    
    if (count) {
        loadCount.text = [NSString stringWithFormat:@"加载出%zd条微博",count];
    }else{
    
    loadCount.text = @"没有新的微博数据了";
    }
    
    loadCount.textColor = [UIColor whiteColor];
    loadCount.backgroundColor = [UIColor orangeColor];
    loadCount.textAlignment = NSTextAlignmentCenter;
    loadCount.size = CGSizeMake(SCREENW, 35);
    loadCount.font = [UIFont systemFontOfSize:14];
    loadCount.y = 64 - loadCount.height;
    [self.navigationController.view insertSubview:loadCount belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:2.0 animations:^{
        loadCount.y = 64;
        
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:2.0 delay:1.0 options:0 animations:^{
            loadCount.y = 64 - loadCount.height;
        } completion:^(BOOL finished) {
            
            loadCount.hidden = YES;
            [loadCount removeFromSuperview];
        }];
        
    }];
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = [self.statusArray[indexPath.row] text];
    
    return cell;
}


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
