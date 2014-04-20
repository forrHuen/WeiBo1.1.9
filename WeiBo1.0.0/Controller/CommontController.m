//
//  AViewController.m
//  WeiBo1.0.0
//
//  Created by 梁康乐 on 14-4-13.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "CommontController.h"
#import "ForwardCell.h"
#import "FindFriendViewController.h"
#import "CommentsCell.h"
#import "CommentsData.h"
@interface CommontController ()

@end

@implementation CommontController
-(void)dealloc
{
    [_homeTableView release];
    [dataSource release];
    [refreshView release];
    [super dealloc];
}
-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)] autorelease];
    [self login];
    self.title = @"评论";
    //初始化表视图
    _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_homeTableView];
    [_homeTableView release];
    //初始化第三方下拉控件
    refreshView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-_homeTableView.bounds.size.height,_homeTableView.bounds.size.width, _homeTableView.bounds.size.height) styleColor:[UIColor groupTableViewBackgroundColor]];
    refreshView.delegate = self;
    [_homeTableView addSubview:refreshView];
    [refreshView refreshLastUpdatedDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc]init];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            CommentsData *d=[[CommentsData alloc]initWithDictionary:[arr objectAtIndex:i]];
            [dataSource addObject:d];
            [_homeTableView reloadData];
            
        }
    };
	
}

#pragma mark -tableView Delegate Method-
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *forwardCellIdentifier = @"forwardCellIdentifier";
    CommentsCell *commentCell =[tableView dequeueReusableHeaderFooterViewWithIdentifier:forwardCellIdentifier];
    if (!commentCell)
    {
        commentCell =[[CommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forwardCellIdentifier];
    }
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommentsData *myData =[dataSource objectAtIndex:indexPath.row];
    [commentCell setContentData:myData];
    [commentCell setHeightWithCell:myData];
    return commentCell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsCell *targetCell = (CommentsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return targetCell.frame.size.height+5;
}
#pragma mark -ScrollView DelegateMethod-
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewDidScroll:scrollView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark -第三方下拉刷新-
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view//3
{
    [self reloadTableViewData];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view//执行多次2
{
    return isLoading;
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view//执行顺序1
{
    return [NSDate date];
}
-(void)reloadTableViewData
{
    isLoading = YES;//加载
}
-(void)doneLoadingTableViewData
{
    isLoading = NO;//不用加载
    //刷新数据
    [dataSource removeAllObjects];
    dataSource = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"15" forKey:@"count"];
    [self getDataArrayandURL:@"comments/to_me.json" andDictionary:params andMethod:@"GET"];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            CommentsData *d=[[CommentsData alloc]initWithDictionary:[arr objectAtIndex:i]];
            [dataSource addObject:d];
            [_homeTableView reloadData];
            
        }
    };
    
    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_homeTableView];
    
}
#pragma mark  登陆之后..........
-(void)login
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"15" forKey:@"count"];
        [self getDataArrayandURL:@"comments/to_me.json" andDictionary:params andMethod:@"GET"];
    }
    else
    {
        //登陆界面
    }
    
}
#pragma mark -click Action-
-(void)pushFindFriendAction
{
    FindFriendViewController *find = [[FindFriendViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
}
-(void)refreshAction
{
    
}
@end
