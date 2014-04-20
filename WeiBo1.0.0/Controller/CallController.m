//
//  B2ViewController.m
//  WeiBo1.0.0
//
//  Created by 梁康乐 on 14-4-13.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "CallController.h"
#import "ForwardCell.h"
#import "FindFriendViewController.h"
#import "ForwardCell.h"
#import "DataModel.h"
#import "BodyViewController.h"
@interface CallController ()

@end

@implementation CallController
@synthesize homeTableView = _homeTableView;
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
    self.title = @"@我";
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
            DataModel *d=[[DataModel alloc]initWithDictionary:[arr objectAtIndex:i]];
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
    CellType ctype;
    DataModel *myData =[dataSource objectAtIndex:indexPath.row];
    if (dataSource.count)
    {
        
        int retweeted = [[myData.fourTypeDic objectForKey:@"retweeted"] integerValue];
        int pic = [[myData.fourTypeDic objectForKey:@"pic"] integerValue];
        NSLog(@"%d",pic);
        NSLog(@"%d",retweeted);
        if (retweeted==1&&myData.Images.count != 0)
        {
            ctype=AFAndHasPic;
        }
        else if(retweeted==1&&pic==0)
        {
            ctype=AFAndNOPic;
        }
        else if(retweeted==0&&myData.Images.count != 0)
        {
            ctype=NonAFAndHasPic;
        }
        else
        {
            ctype=NonAFAndNOPic;
        }
        NSLog(@"%u ---- %d",ctype,indexPath.row);
    }
    int a = myData.Images.count;
    static NSString *forwardCellIdentifier = @"forwardCellIdentifier";
    ForwardCell *forwardCell =[tableView dequeueReusableHeaderFooterViewWithIdentifier:forwardCellIdentifier];
    if (!forwardCell)
    {
        forwardCell = [[[ForwardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forwardCellIdentifier andType:ctype andImageNumber: a ]autorelease];
    }
    forwardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataSource.count)
    {
        DataModel *myData =[dataSource objectAtIndex:indexPath.row];
        forwardCell.model = myData;
        [forwardCell setCountandData:myData];
        [forwardCell setCellandContentHeightandData:myData];
        forwardCell.myCommentCellBlock = ^(DataModel *model)
        {
            BodyViewController *commentVC= [BodyViewController new];
            [self.navigationController pushViewController:commentVC animated:YES];
            
        };
    }
    return forwardCell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForwardCell *targetCell = (ForwardCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
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
    [self getDataArrayandURL:@"statuses/mentions.json" andDictionary:params andMethod:@"GET"];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            DataModel *d=[[DataModel alloc]initWithDictionary:[arr objectAtIndex:i]];
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
        [self getDataArrayandURL:@"statuses/mentions.json" andDictionary:params andMethod:@"GET"];
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
