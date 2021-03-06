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
#import "YLStatusseCell.h"
#import "YLStatueFrame.h"
#import "YLHttpTool.h"
#import "YLBaseTool.h"
#import "YLLoadNewStatusRP.h"
#import "YLhomeDataTool.h"
#define LOAD_COUNT 20
@interface YLhomeTableViewController ()
@property (strong, nonatomic)UIButton *btn;

@property (strong, nonatomic)NSMutableArray *statusFrames;
@end

@implementation YLhomeTableViewController

- (NSMutableArray *)statusFrames{
    if (_statusFrames==nil) {
        
        _statusFrames = [NSMutableArray array];
    }

    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[YLStatusseCell class] forCellReuseIdentifier:Identifier];
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
        account.screen_name = user.screen_name;
        [YLAccountTool setAccount:account];
        
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
    
    
    
//    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
//    YLAccount *account = [YLAccountTool account];
   // NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"access_token"] = account.access_token;
//    parameters[@"count"] = @(LOAD_COUNT);
    long long since_id = 0;
    if ([self.statusFrames firstObject]) {
        YLStatueFrame *statusFrame = [self.statusFrames firstObject];
        
        since_id = [statusFrame.statuses id];
    }
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //NSLog(@"%@",responseObject);
//        [refreshControl endRefreshing];
//        NSArray *array= responseObject[@"statuses"];
//        
//        NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
//        
//        NSArray *statusFrame = [self convertStatusFrames:status];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
//        [self.statusFrames insertObjects:statusFrame atIndexes:indexSet];
//        [self.tableView reloadData];
//      //  self.tabBarItem.badgeValue = nil;
//        
//        [self loadLabelCountWithCount:status.count];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"错误是:%@",error);
//        [refreshControl endRefreshing];
//    }];
//    [YLHttpTool getWithUrl:urlString param:parameters success:^(id responseObject) {
//            [refreshControl endRefreshing];
//            NSArray *array= responseObject[@"statuses"];
//    
//            NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
//    
//            NSArray *statusFrame = [self convertStatusFrames:status];
//    
//            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];
//            [self.statusFrames insertObjects:statusFrame atIndexes:indexSet];
//            [self.tableView reloadData];
//          //  self.tabBarItem.badgeValue = nil;
//    
//            [self loadLabelCountWithCount:status.count];
//
//        } faile:^(NSError *error) {
//             NSLog(@"错误是:%@",error);
//            [refreshControl endRefreshing];
//        }];
//    [YLBaseTool getWithUrl:urlString param:parameters class:[YLLoadNewStatusRP class] success:^(YLLoadNewStatusRP *respos) {
//        NSArray *statusFrame = [self convertStatusFrames:respos.statuses];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, respos.statuses.count)];
//        [self.statusFrames insertObjects:statusFrame atIndexes:indexSet];
//        [self.tableView reloadData];
//      //  self.tabBarItem.badgeValue = nil;
//
//        [self loadLabelCountWithCount:respos.statuses.count];
//
//    } faile:^(NSError *error) {
//        NSLog(@"错误是:%@",error);
//        [refreshControl endRefreshing];
//        
//    }];
    [YLhomeDataTool getStauseWithSinceId:since_id maxId:0 count:LOAD_COUNT success:^(YLLoadNewStatusRP *resp) {
        NSArray *statusFrame = [self convertStatusFrames:resp.statuses];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, resp.statuses.count)];
        [self.statusFrames insertObjects:statusFrame atIndexes:indexSet];
        [self.tableView reloadData];
      //  self.tabBarItem.badgeValue = nil;
        [refreshControl endRefreshing];
        [self loadLabelCountWithCount:resp.statuses.count];
        
    } faile:^(NSError *error) {
        
    }];
    
}


- (void)loadMoreStatuses{

//    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
//    YLAccount *account = [YLAccountTool account];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"access_token"] = account.access_token;
//    parameters[@"count"] = @(LOAD_COUNT);
    long long max_id = 0;
    if ([self.statusFrames firstObject]) {
        YLStatueFrame *statusFrame = [self.statusFrames firstObject];
        
        max_id = [statusFrame.statuses id] - 1;
    }
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // NSLog(@"%@",responseObject);
//        
//        NSArray *array= responseObject[@"statuses"];
//        
//        NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
//        
//        NSArray *statusFrame = [self convertStatusFrames:status];
//        
//        [self.statusFrames addObjectsFromArray:statusFrame];
//        [self.tableView reloadData];
//        self.tableView.tableFooterView.hidden = YES;
//        [self performSelector:@selector(method) withObject:nil afterDelay:3.0];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"错误是:%@",error);
//        self.tableView.tableFooterView.hidden = YES;
//    }];
//        [YLHttpTool getWithUrl:urlString param:parameters success:^(id responseObject) {
//            // NSLog(@"%@",responseObject);
//            
//            NSArray *array= responseObject[@"statuses"];
//    
//            NSArray *status = [YLLoadNewStatus objectArrayWithKeyValuesArray:array];
//    
//            NSArray *statusFrame = [self convertStatusFrames:status];
//    
//            [self.statusFrames addObjectsFromArray:statusFrame];
//            [self.tableView reloadData];
//            self.tableView.tableFooterView.hidden = YES;
//            [self performSelector:@selector(method) withObject:nil afterDelay:3.0];
//            
//
//        } faile:^(NSError *error) {
//            
//        }];
//    [YLBaseTool getWithUrl:urlString param:parameters class:[YLLoadNewStatusRP class] success:^(YLLoadNewStatusRP *resp) {
//        
//        NSArray *statusFrame = [self convertStatusFrames:resp.statuses];
//
//        [self.statusFrames addObjectsFromArray:statusFrame];
//        [self.tableView reloadData];
//        self.tableView.tableFooterView.hidden = YES;
//        [self performSelector:@selector(method) withObject:nil afterDelay:3.0];
//
//    } faile:^(NSError *error) {
//        
 //   }];
    [YLhomeDataTool getStauseWithSinceId:0 maxId:max_id count:LOAD_COUNT success:^(YLLoadNewStatusRP *resp) {
        NSArray *statusFrame = [self convertStatusFrames:resp.statuses];
        [self.statusFrames addObjectsFromArray:statusFrame];
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
        [self performSelector:@selector(method) withObject:nil afterDelay:3.0];
    } faile:^(NSError *error) {
        
    }];
    
}
- (void)method{
 self.tableView.tableFooterView.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return ;
    }
    
    float result = scrollView.contentSize.height - SCREENH;
    if (result <= (scrollView.contentOffset.y - self.tabBarController.tabBar.height)) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatuses];
    }

}

- (void)showUnReadNumbers{
    
//    NSString *urlString = @"https://rm.api.weibo.com/2/remind/unread_count.json";
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    YLAccount *account = [YLAccountTool account];
//    parameters[@"access_token"] = account.access_token;
//    parameters[@"uid"] = account.uid;

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        IWUnReadCount *unRead = [IWUnReadCount objectWithKeyValues:responseObject];
//        if (unRead.status) {
//           self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",unRead.status];
//            [UIApplication sharedApplication].applicationIconBadgeNumber = unRead.status;
//        }else{
//            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"哈哈"];;
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    [YLHttpTool getWithUrl:urlString param:parameters success:^(id responseObject) {
//        IWUnReadCount *unRead = [IWUnReadCount objectWithKeyValues:responseObject];
//        if (unRead.status) {
//           self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",unRead.status];
//            [UIApplication sharedApplication].applicationIconBadgeNumber = unRead.status;
//        }else{
//            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"哈哈"];;
//        }
//        
//    } faile:^(NSError *error) {
//        
//    }];
//    [YLBaseTool getWithUrl:urlString param:parameters class:[IWUnReadCount class] success:^(IWUnReadCount *resp) {
//        //IWUnReadCount *unRead = [IWUnReadCount objectWithKeyValues:resp];
//        if (resp.status) {
//           self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",resp.status];
//            [UIApplication sharedApplication].applicationIconBadgeNumber = resp.status;
//        }else{
//            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"哈哈"];;
//        }
//
//        
//    } faile:^(NSError *error) {
//        
//    }];
    [YLhomeDataTool getUnreadWithSuccess:^(IWUnReadCount *resp) {
        if (resp.status) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",resp.status];
            [UIApplication sharedApplication].applicationIconBadgeNumber = resp.status;
        }else{
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"哈哈"];;
        }

    } faile:^(NSError *error) {
        
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

- (NSArray *)convertStatusFrames:(NSArray *)status{
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (YLLoadNewStatus *statu in status) {
        YLStatueFrame *statusFrame = [[YLStatueFrame alloc]init];
        statusFrame.statuses = statu;
        [statusFrameArray addObject:statusFrame];
    }
    return [statusFrameArray copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *reuseIdentifier = @"cell";
    
    //YLStatusseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    YLStatusseCell *cell = [YLStatusseCell cellWithTableView:tableView];
    
//    if (cell==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    }
    YLStatueFrame *statueFrame = self.statusFrames[indexPath.row];
    
    [cell setStatueFrame:statueFrame];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.contentView.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.statusFrames[indexPath.row] cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
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
