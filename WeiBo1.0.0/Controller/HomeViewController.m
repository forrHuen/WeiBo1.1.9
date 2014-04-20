//
//  HomeViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "HomeViewController.h"
#import "FindFriendViewController.h"
#import "BodyViewController.h"
#import "TextViewController.h"
#import "SetUserViewController.h"
#import "HTMLViewController.h"
#import "CommViewController.h"
@implementation HomeViewController
@synthesize homeTableView = _homeTableView;
@synthesize tabBarController = _tabBarController;
@synthesize showScrollView = _showScrollView;
@synthesize myDataModel = _myDataModel;
-(void)dealloc
{
    [_homeTableView release];
    [dataSource release];
    [refreshView release];
    [_showScrollView release];
    [_tabBarController release];
    [_myDataModel release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT-NavigationBar_HEIGHT, SCREEN_WIDTH, NavigationBar_HEIGHT);
}
-(void)loadView
{
    totalCount = 0;
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)] autorelease];
//    self.groupTableView = [[[TabelView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-192)/2,64, 192, 285)]autorelease];
//    self.groupTableView.backgroundColor = [UIColor darkGrayColor];
//    self.groupTableView.alpha = 0.8;
//    [self.view addSubview:self.groupTableView];
    
//    UIButton *titleBtn =  [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [titleBtn setTitle:@"陈奕迅的微博" forState:0];
//    titleBtn.selected = YES;
//    [titleBtn addTarget:self action:@selector(groupClickAction:) forControlEvents:7];
//    self.navigationItem.titleView = titleBtn;
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"找朋友" style:UIBarButtonItemStyleDone target:self action:@selector(pushFindFriendAction)]autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refreshAction)]autorelease];
    
    //初始化展示大图的UIImageView
    self.showScrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)]autorelease];
    self.showScrollView.backgroundColor = [UIColor blackColor];
    self.showScrollView.userInteractionEnabled = YES;
    self.showScrollView.scrollEnabled = YES;
    self.showScrollView.pagingEnabled = YES;
    self.showScrollView.bounces = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageViewTapAction:)];
    [self.showScrollView addGestureRecognizer:tap];
    [tap release];
    
    //初始化表视图
    _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homeTableView.scrollsToTop = YES;
    [self.view addSubview:_homeTableView];
    
    //初始化第三方下拉控件
    refreshView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-_homeTableView.bounds.size.height,_homeTableView.bounds.size.width, _homeTableView.bounds.size.height) styleColor:[UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1]];
    refreshView.delegate = self;
    [_homeTableView addSubview:refreshView];
    [refreshView refreshLastUpdatedDate];
    //请求数据
    [self login];
}
/*
#pragma mark -分组列表点击事件-
-(void)groupClickAction:(UIButton *)sender
{
    if (sender.selected)
    {
        [self.view bringSubviewToFront:self.groupTableView];
        sender.selected = NO;
    }
    else
    {
        [self.view sendSubviewToBack:self.groupTableView];
        sender.selected = YES;
    }
}
*/

#pragma mark  登陆之后..........
-(void)login
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"20" forKey:@"count"];
        [self getDataArrayandURL:@"statuses/friends_timeline.json" andDictionary:params andMethod:@"GET"];
    }
    else
    {
        //jump登陆界面
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc]init];
    //得到数据并存入数据源
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            //存入每条微博的key值@"statuses"
            [dataSource addObject:[arr objectAtIndex:i]];
            //刷新表视图
            [_homeTableView reloadData];
        }
    };
	
}

#pragma mark -tableView Delegate Method-
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    totalCount = dataSource.count;
    return totalCount+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataSource.count && dataSource.count != indexPath.row)
    {
        //初始化DataModel
        self.myDataModel = [[DataModel alloc]initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
        //判断单元格4中情况,并记入self.ctype
        int retweeted = [[self.myDataModel.fourTypeDic objectForKey:@"retweeted"] integerValue];
        int pic = [[self.myDataModel.fourTypeDic objectForKey:@"pic"] integerValue];
        if (retweeted==1&&pic == 1)
        {
            self.myType=AFAndHasPic;
        }
        else if(retweeted==1&&pic==0)
        {
            self.myType=AFAndNOPic;
        }
        else if(retweeted==0&&self.myDataModel.Images.count != 0)
        {
            self.myType=NonAFAndHasPic;
        }
        else
        {
            self.myType=NonAFAndNOPic;
        }
    }

    
    //图片个数
    int a = self.myDataModel.Images.count;
    UITableViewCell *cell = nil;
    static NSString *moreIdentifier = @"moreCellIdentifier";
    static NSString *forwardCellIdentifier = @"forwardCellIdentifier";
    if (dataSource.count == indexPath.row)
    {
        UITableViewCell *moreCell = [tableView
                                       dequeueReusableHeaderFooterViewWithIdentifier:
                                       moreIdentifier ];
        if (!moreCell)
        {
            moreCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                           
                                                reuseIdentifier:moreIdentifier]autorelease];
            UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            moreLabel.textAlignment = NSTextAlignmentCenter;
            moreLabel.text = @"加载中......";
            moreLabel.font = [UIFont systemFontOfSize:12];
            moreLabel.textColor = [UIColor grayColor];
            moreCell.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
            [moreCell.contentView addSubview:moreLabel];
            [moreLabel release];
        }
        return moreCell;
    }
    else
    {
        ForwardCell *forwardCell =[tableView dequeueReusableHeaderFooterViewWithIdentifier:forwardCellIdentifier];
        if (!forwardCell)
        {
            forwardCell = [[[ForwardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forwardCellIdentifier andType:self.myType andImageNumber:a ]autorelease];
        }
        forwardCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (dataSource.count)
        {
            forwardCell.model = self.myDataModel;
            [forwardCell setCountandData:self.myDataModel];
            [forwardCell setCellandContentHeightandData:self.myDataModel];
            ///////////////////////////微博正文中的跳转///////////////////////////////////////
            //跳转到个人页
            forwardCell.middleView.personBlock = ^(DataModel *model)
            {
                SetUserViewController *user = [[SetUserViewController alloc]init];
                self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                [self.navigationController pushViewController:user animated:YES];
            };
            //跳转到微博正文
            forwardCell.middleView.myBodyBlock= ^(DataModel *model,FourType type)
            {
                BodyViewController *bodyVC= [[BodyViewController alloc]initWithType:type];//转发的情况下
                bodyVC.myDataModel = forwardCell.model;
                bodyVC.mytype = type;
                
                self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                [self.navigationController pushViewController:bodyVC animated:YES];
            };
            //跳转到大图
            forwardCell.middleView.showBlock = ^(NSArray *urlStrArr,int num,BOOL b,CGFloat long_height)
            {
                [self.tabBarController.view addSubview:self.showScrollView];
                [self showBigImages:urlStrArr andNum:num andBool:b andCGFloat:long_height];
            };
            ///////////////////////////首页中的跳转///////////////////////////////////////
            //跳转到评论
            forwardCell.myCommentCellBlock = ^(DataModel *model)
            {
                if ([model.comments_count integerValue] == 0)
                {
                    CommViewController *comm = [[CommViewController alloc]init];
                    comm.datamodel = model;
                    self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                    [self.navigationController pushViewController:comm animated:YES];
                }
                else
                {
                    BodyViewController *commentVC= [BodyViewController new];
                    commentVC.myDataModel = forwardCell.model;
                    commentVC.mytype = self.myType;
                    self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                    [self.navigationController pushViewController:commentVC animated:YES];
  
                }
                
            };
            //跳转到转发
            forwardCell.myForwardCellBlock = ^(DataModel *model)
            {
                TextViewController *TVC= [TextViewController new];
                TVC.datamodel=forwardCell.model;
                self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                [self.navigationController pushViewController:TVC animated:YES];
            };
            //跳转到个人页面
            forwardCell.myPresionBlock = ^(DataModel *model)
            {
                SetUserViewController *user = [[SetUserViewController alloc]init];
                self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                [self.navigationController pushViewController:user animated:YES];
            };
            //跳转到网页
            forwardCell.middleView.myHttpBlock= ^(NSString *str)
            {
                HTMLViewController *HTTPVC=[HTMLViewController new];
                HTTPVC.webURL=str;
                self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
                [self.navigationController pushViewController:HTTPVC animated:YES];
            };
        }
        return forwardCell;
    }
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataSource.count == indexPath.row)
    {
        return 44;
    }
    else
    {
        ForwardCell *targetCell = (ForwardCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return targetCell.frame.size.height;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到微博正文
    BodyViewController *bodyVC= [[BodyViewController alloc]init];
    ForwardCell *targetCell = (ForwardCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    bodyVC.myDataModel = targetCell.model;
    bodyVC.mytype = self.myType;
    self.tabBarController.tabBarImageView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT);
    [self.navigationController pushViewController:bodyVC animated:YES];
}
#pragma mark -ScrollView DelegateMethod-
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshView egoRefreshScrollViewDidScroll:scrollView];
}
#pragma mark -上拉加载-
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView egoRefreshScrollViewDidEndDragging:scrollView];
//    NSLog(@"%f **************** %f",_homeTableView.contentOffset.y+44+SCREEN_HEIGHT,scrollView.contentSize.height);
    if (_homeTableView.contentOffset.y+SCREEN_HEIGHT >= scrollView.contentSize.height)
    {
        //按最后1条微博id加载
        DataModel *data = [[DataModel alloc]initWithDictionary:[dataSource lastObject]];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"3",@"count",[NSString stringWithFormat:@"%@",data.Wid],@"max_id", nil];//每次加载2条
        [self getDataArrayandURL:@"statuses/friends_timeline.json" andDictionary:params andMethod:@"GET"];
        
        self.myBlock=^(NSMutableArray *arr)
        {
            for (int i=1;i<[arr count];i++)
            {
                [dataSource addObject:[arr objectAtIndex:i]];
                [_homeTableView reloadData];
            }
        };
    }
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
    ////////////////////////////////////下拉刷新数据////////////////////////////////////////
    //按第一条微博id决定是否需要刷新
    DataModel *data = [[DataModel alloc]initWithDictionary:[dataSource objectAtIndex:0]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",data.Wid],@"since_id", nil];
    [self getDataArrayandURL:@"statuses/friends_timeline.json" andDictionary:params andMethod:@"GET"];

    self.myBlock=^(NSMutableArray *arr)
    {
        if (arr.count != 0)
        {
            NSMutableArray *tempMArr = [NSMutableArray arrayWithArray:dataSource];
            //新请求下来n的数据，拼接上旧的数据
            [arr addObjectsFromArray:tempMArr];
            [dataSource removeAllObjects];
            [dataSource retain];
            for (int i=0;i<[arr count];i++)
            {
                [dataSource addObject:[arr objectAtIndex:i]];
                [_homeTableView reloadData];
                //刷新完滚回第一行单元格
                NSIndexPath *_index = [NSIndexPath indexPathForRow:0 inSection:0];
                [_homeTableView scrollToRowAtIndexPath:_index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }
    };

    [refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_homeTableView];
 
}
#pragma mark -导航按钮click Action-
-(void)pushFindFriendAction
{
    FindFriendViewController *find = [[FindFriendViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
}
-(void)refreshAction
{
    
}
#pragma mark -显示大图处理-
-(void)showImageViewTapAction:(UIGestureRecognizer *)sender
{
    UIImageView *targetImage = (UIImageView *)[self.showScrollView viewWithTag:5000];
    [targetImage removeFromSuperview];
    UIImageView *targetImage1 = (UIImageView *)[self.showScrollView viewWithTag:5001];
    [targetImage1 removeFromSuperview];
    [self.showScrollView removeFromSuperview];
}
-(void)showBigImages:(NSArray *)urlStrArr andNum:(int)num andBool:(BOOL)b
          andCGFloat:(CGFloat )long_height//图片数组，点击的是第几张图片，是否长图，长图的高
{
    switch (num)
    {
        case 1:
        {
            self.showScrollView.contentOffset = CGPointMake(0, 0);
            break;
        }
        case 2:
        {
            self.showScrollView.contentOffset = CGPointMake(1*SCREEN_WIDTH, 0);
            break;
        }
        case 3:
        {
            self.showScrollView.contentOffset = CGPointMake(2*SCREEN_WIDTH, 0);
            break;
        }
        case 4:
        {
            self.showScrollView.contentOffset = CGPointMake(3*SCREEN_WIDTH, 0);
            break;
        }
        case 5:
        {
            self.showScrollView.contentOffset = CGPointMake(4*SCREEN_WIDTH, 0);
            break;
        }
        case 6:
        {
            self.showScrollView.contentOffset = CGPointMake(5*SCREEN_WIDTH, 0);
            break;
        }
        case 7:
        {
            self.showScrollView.contentOffset = CGPointMake(6*SCREEN_WIDTH, 0);
            break;
        }
        case 8:
        {
            self.showScrollView.contentOffset = CGPointMake(7*SCREEN_WIDTH, 0);
            break;
        }
        case 9:
        {
            self.showScrollView.contentOffset = CGPointMake(8*SCREEN_WIDTH, 0);
            break;
        }
        default:
            break;
    }
    switch (urlStrArr.count)
    {
        case 1:
        {
            if (b)
            {
                
                self.showScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, long_height*20);
            }
            else
            {
                self.showScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
            }
            break;
        }
        case 2:
        {
            self.showScrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 3:
        {
            self.showScrollView.contentSize = CGSizeMake(3*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 4:
        {
            self.showScrollView.contentSize = CGSizeMake(4*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 5:
        {
            self.showScrollView.contentSize = CGSizeMake(5*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 6:
        {
            self.showScrollView.contentSize = CGSizeMake(6*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 7:
        {
            self.showScrollView.contentSize = CGSizeMake(7*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 8:
        {
            self.showScrollView.contentSize = CGSizeMake(8*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        case 9:
        {
            self.showScrollView.contentSize = CGSizeMake(9*SCREEN_WIDTH, SCREEN_HEIGHT);
            break;
        }
        default:
            break;
    }
    for (int i = 0; i<urlStrArr.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i+0,0, SCREEN_WIDTH,SCREEN_WIDTH)];
        if (i==0 && b==1)
        {
            imageView.frame = CGRectMake(0,0, SCREEN_WIDTH, long_height*20);
            imageView.tag = 5000;
            imageView.contentMode = UIViewContentModeScaleToFill;
            [imageView setImageWithURL:[NSURL URLWithString:[urlStrArr objectAtIndex:0]]];
        }
        else
        {
            imageView.frame = CGRectMake(320*i+0,64, SCREEN_WIDTH,SCREEN_WIDTH);
            imageView.tag = 5000+i+1;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView setImageWithURL:[NSURL URLWithString:[urlStrArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"head_null"]];
        }
        
        [self.showScrollView addSubview:imageView];
        [imageView release];
    }
    
}
@end
