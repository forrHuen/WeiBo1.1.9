//
//  SquareViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "SquareViewController.h"

#import "TopicCell.h"

#import "HotViewController.h"
#import "FindFriendViewController.h"

#import "NearViewController.h"
#import "GameViewController.h"
#import "AppViewController.h"

#import "VideoViewController.h"
#import "MusicViewController.h"
#import "MovieViewController.h"
#import "MoreViewController.h"
@interface SquareViewController ()

@end

@implementation SquareViewController
@synthesize tableView = _tableView;
-(void)dealloc
{
    [dataVC release];
    [_tableView release];
    [super dealloc];
}
-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(-20, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    search.placeholder = @"搜索";
    search.backgroundColor = [UIColor darkGrayColor];
    search.delegate = self;
    self.navigationItem.titleView = search;
    [search release];
    
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain]autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    HotViewController *hot = [[HotViewController alloc]init];
    hot.rowImage = [UIImage imageNamed:@"square_hot"];
    FindFriendViewController *find = [[FindFriendViewController alloc]init];
    find.rowImage = [UIImage imageNamed:@"square_find"];
    NearViewController *near = [[NearViewController alloc]init];
    near.rowImage = [UIImage imageNamed:@"square_near"];
    GameViewController *game = [[GameViewController alloc]init];
    game.rowImage = [UIImage imageNamed:@"square_game"];
    AppViewController *app = [[AppViewController alloc]init];
    app.rowImage = [UIImage imageNamed:@"square_app"];
    VideoViewController *video = [[VideoViewController alloc]init];
    video.rowImage = [UIImage imageNamed:@"square_video"];
    MusicViewController *music = [[MusicViewController alloc]init];
    music.rowImage = [UIImage imageNamed:@"square_music"];
    MovieViewController *movie = [[MovieViewController alloc]init];
    movie.rowImage = [UIImage imageNamed:@"square_movie"];
    MoreViewController *more = [[MoreViewController alloc]init];
    more.rowImage = [UIImage imageNamed:@"square_more"];
    
    hot.title = @"hot";
    find.title = @"find";
    near.title = @"near";
    game.title = @"game";
    app.title = @"app";
    video.title = @"video";
    music.title = @"music";
    movie.title = @"movie";
    more.title = @"more";
    dataVC = [[NSMutableArray alloc]initWithObjects:hot,hot,find,near,game,app,video,music,movie,more,nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataVC.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    static NSString *topicIdentifier = @"topicId";
    static NSString *systemIdentifier = @"systemId";
    if (indexPath.row == 0)
    {
        TopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicIdentifier];
        if (!topicCell)
        {
            topicCell = [[[TopicCell alloc]initWithStyle:UITableViewCellStyleValue1
                                         reuseIdentifier:systemIdentifier]autorelease];
            
        }
        return topicCell;
    }
    else
    {
        UITableViewCell *systemCell = [tableView dequeueReusableCellWithIdentifier:systemIdentifier];
        if (!systemCell)
        {
            systemCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:systemIdentifier]autorelease];
        }
        BaseTableViewController *viewController = [dataVC objectAtIndex:indexPath.row];
        systemCell.textLabel.text = viewController.title;
        systemCell.imageView.image = viewController.rowImage;
        systemCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return systemCell;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 100;
    }
    else
    {
        return 44;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        
    }
    else
    {
        BaseTableViewController *VCs = [dataVC objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:VCs animated:YES];
    }
}

@end