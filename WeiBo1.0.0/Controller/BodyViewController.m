//
//  CommentViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-10.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BodyViewController.h"

#import "HTMLViewController.h"
#import "TextViewController.h"
#import "CommViewController.h"
#import "SetUserViewController.h"
#import "UIImageView+WebCache.h"
#import "TextViewController.h"
@interface BodyViewController ()
{
    UIView *bgView;
}
@end

@implementation BodyViewController
@synthesize myDataModel = _myDataModel;
@synthesize showScrollView = _showScrollView;
@synthesize commentTable = _commentTable;
@synthesize commentBtn = _commentBtn;
@synthesize forwardBtn = _forwardBtn;
@synthesize praiseBtn = _praiseBtn;
@synthesize mytype = _mytype;
-(void)dealloc
{
    [_commentTable release];
    [_myDataModel release];
    [_forwardBtn release];
    [_commentBtn release];
    [_praiseBtn release];
    [_showScrollView release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    bgView.frame = CGRectMake(0, SCREEN_HEIGHT-NavigationBar_HEIGHT, SCREEN_WIDTH, NavigationBar_HEIGHT);
}

-(void)viewWillDisappear:(BOOL)animated
{
    bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, NavigationBar_HEIGHT);
}

-(id)initWithType:(FourType )aType
{
    if (self = [super init])
    {
        self.mytype = aType;
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    self.title = @"微博正文";
    self.view.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    
    //初始化展示大图的ScrollView
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
    _commentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _commentTable.delegate =self;
    _commentTable.dataSource =self;
    _commentTable.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    _commentTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_commentTable];
    
    ////////////////////////////////////////////////底部按钮/////////////////////////////
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,NavigationBar_HEIGHT)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.9;
    [self.view addSubview:bgView];
    [bgView release];
    
    UIButton *retBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    retBtn.frame = CGRectMake(7, 10, 95, 25);
    [retBtn setImage:[UIImage imageNamed:@"forward3"] forState:0];
    [retBtn setTitle:@"转发" forState:0];
    retBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [retBtn setTitleColor:[UIColor grayColor] forState:0];
    retBtn.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    [retBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:7];
    retBtn.tag = 3000;
    retBtn.layer.cornerRadius = 5;
    [bgView addSubview:retBtn];
    
    UIButton *comBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comBtn.frame = CGRectMake(7+100+5,10, 95, 25);
    [comBtn setImage:[UIImage imageNamed:@"comment3"] forState:0];
    [comBtn setTitle:@"评论" forState:0];
    [comBtn setTitleColor:[UIColor grayColor] forState:0];
    comBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    comBtn.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    [comBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:7];
    comBtn.tag = 3001;
    comBtn.layer.cornerRadius = 5;
    [bgView addSubview:comBtn];
   
    UIButton *praBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    praBtn.frame = CGRectMake(7+100+100+10, 10, 95, 25);
    [praBtn setTitle:@"赞" forState:0];
    [praBtn setTitleColor:[UIColor grayColor] forState:0];
    [praBtn setImage:[UIImage imageNamed:@"praise3"] forState:0];
    praBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    praBtn.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    [praBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:7];
    praBtn.tag = 3002;
    praBtn.layer.cornerRadius = 5;
    [bgView addSubview:praBtn];
    
    
    [self login];
}
-(void)login
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.myDataModel.Wid],@"id",@"20",@"count", nil];
        [self getDataArrayandURL:@"comments/show.json" andDictionary:params andMethod:@"GET"];
        
        
    }
    else
    {
        //jump登陆界面
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *section2 = [NSMutableArray array];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            CommentsData *d=[[CommentsData alloc]initWithDictionary:[arr objectAtIndex:i]];
            [section2 addObject:d];
            [_commentTable reloadData];
            
        }
    };
    
    dataSource = [[NSMutableArray alloc]initWithObjects:self.myDataModel,section2, nil];
    
}

#pragma mark =============表视图代理方法==============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return 1;
            break;
        }
        case 1:
        {
            NSMutableArray *section2 = [dataSource objectAtIndex:section];
            return section2.count;
            break;
        }
        default:
            break;
    }
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *returnCell = nil;
    static NSString *forwardCellIdentifier = @"forwardCellIdentifier";
    static NSString *mainBodyCellIdentifier = @"body";
    static NSString *Cellidentifier = @"cell";
    
    switch (indexPath.section)
    {
        case 0:
        {
            DataModel *dataModel = self.myDataModel;
            if (self.mytype == 5 || self.mytype ==6 )
            {
                ForwardBodyCell *forbodyCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:mainBodyCellIdentifier];
                if (!forbodyCell)
                {
                    forbodyCell = [[[ForwardBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainBodyCellIdentifier andType:self.mytype andImageNumber:dataModel.Images.count]autorelease];
                    
                }
                [forbodyCell setCountandData:dataModel];
                [forbodyCell setCellandContentHeightandData:dataModel];
                forbodyCell.selectionStyle = UITableViewCellSelectionStyleNone;
                forbodyCell.showBlock = ^(NSArray *urlStrArr,int num,BOOL b,CGFloat long_height)
                {
                    [self.tabBarController.view addSubview:self.showScrollView];
                    [self showBigImages:urlStrArr andNum:num andBool:b andCGFloat:long_height];
                };
                return forbodyCell;
            }
            else if(self.mytype)
            {
                BodyCell *bodyCell =[tableView dequeueReusableHeaderFooterViewWithIdentifier:forwardCellIdentifier];
                if (!bodyCell)
                {
                    bodyCell = [[[BodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forwardCellIdentifier andType:self.mytype andImageNumber:dataModel.Images.count]autorelease];
                }
                bodyCell.selectionStyle = UITableViewCellSelectionStyleNone;
                bodyCell.model = dataModel;
                [bodyCell setCountandData:dataModel];
                [bodyCell setCellandContentHeightandData:dataModel];
                ////////////////////////////////////微博正文中的跳转/////////////////////////////////
                bodyCell.middleView.personBlock = ^(DataModel *model)
                {
                    SetUserViewController *user = [[SetUserViewController alloc]init];
                    [self.navigationController pushViewController:user animated:YES];
                };
                bodyCell.middleView.myBodyBlock= ^(DataModel *model,FourType type)
                {
                    
                };
                bodyCell.middleView.showBlock = ^(NSArray *urlStrArr,int num,BOOL b,CGFloat long_height)
                {
                    [self.tabBarController.view addSubview:self.showScrollView];
                    [self showBigImages:urlStrArr andNum:num andBool:b andCGFloat:long_height];
                };
                bodyCell.middleView.myHttpBlock= ^(NSString *str)
                {
                    HTMLViewController *HTTPVC=[HTMLViewController new];
                    HTTPVC.webURL=str;
                    [self.navigationController pushViewController:HTTPVC animated:YES];
                };
                //////////////////////////////////跳转////////////////////////////////
                bodyCell.myCommentCellBlock = ^(DataModel *model)
                {
                    CommViewController *comm = [[CommViewController alloc]init];
                    comm.datamodel = model;
                    [self.navigationController pushViewController:comm animated:YES];
                };
                bodyCell.myForwardCellBlock = ^(DataModel *model)
                {
                    TextViewController *TVC= [TextViewController new];
                    TVC.datamodel=model;
                    [self.navigationController pushViewController:TVC animated:YES];
                };
                bodyCell.myPresionBlock = ^(DataModel *model)
                {
                    SetUserViewController *user = [[SetUserViewController alloc]init];
                    [self.navigationController pushViewController:user animated:YES];
                };
                return bodyCell;
            }
            break;
        }
        case 1:
        {
            NSArray *section2 = [dataSource objectAtIndex:indexPath.section];
            
            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
            if (!cell) {
                cell = [[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier]autorelease];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (section2.count)
            {
                [cell setCellData:[section2 objectAtIndex:indexPath.row]];
                [cell setCellHeight:[section2 objectAtIndex:indexPath.row]];
            }
            //点击头像跳转。。。。。。
            return cell;
            break;
        }
        default:
            break;
    }
    return returnCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            BodyCell *targetCell = (BodyCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return targetCell.frame.size.height;
            break;
        }
        case 1:
        {
            CommentCell *commCell = (CommentCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            return commCell.frame.size.height;
            break;
        }
        default:
            break;
    }
    return 0;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 45;
}
#pragma mark ==============自定义section============
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    DataModel *dataModel = [dataSource objectAtIndex:0];
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    sectionView.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    //
    UIImageView *sectionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5,0, 310, 44)];
    sectionImageView.backgroundColor = [UIColor whiteColor];
    sectionImageView.userInteractionEnabled = YES;
    [sectionView addSubview:sectionImageView];
    
    self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forwardBtn.frame = CGRectMake(0, 0, 72, 43);
    [self.forwardBtn setTitle:[NSString stringWithFormat:@"%d转发",[dataModel.reposts_count integerValue]] forState:0];
    self.forwardBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.forwardBtn addTarget:self action:@selector(forwardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionImageView addSubview:self.forwardBtn];
    
    UIView *separateView = [[UIView alloc]initWithFrame:CGRectMake(72, 11.5, 1, 20)];
    separateView.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [sectionImageView addSubview:separateView];
    
    self.commentBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    self.commentBtn.frame = CGRectMake(78, 0, 70, 43);
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%d评论",[dataModel.comments_count integerValue]] forState:0];
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.commentBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionImageView addSubview:self.commentBtn];
    
    self.praiseBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    self.praiseBtn.frame = CGRectMake(240, 0, 66, 43);
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%d赞",[dataModel.attitudes_count integerValue]] forState:0];
    self.praiseBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.praiseBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionImageView addSubview:self.praiseBtn];
    
    
    if ([[[dataSource lastObject] lastObject]isMemberOfClass:[CommentsData class]])
    {
        [self.praiseBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
        [self.forwardBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
        [self.commentBtn setTitleColor:[UIColor blackColor] forState:0];
    }
    else
    {
        [self.praiseBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
        [self.commentBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
        [self.forwardBtn setTitleColor:[UIColor blackColor] forState:0];
    }
    return sectionView;  
}

#pragma mark ==============section上的转发，评论，赞的按钮方法===============
-(void)forwardBtnAction:(UIButton *)sender
{
    //点击第二遍的时候不用再次请求数据
    if ([[[dataSource lastObject] lastObject] isMemberOfClass:[RepostsData class]])
    {
        return;
    }
    //切换成转发的数据
    [dataSource removeLastObject];
    NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.myDataModel.Wid],@"id",@"20",@"count", nil];
    [self getDataArrayandURL:@"statuses/repost_timeline.json" andDictionary:params2 andMethod:@"GET"];
    
     NSMutableArray *section3 = [NSMutableArray array];
    self.myBlock = ^(NSMutableArray *arr)
    {
        for (int i = 0; i < [arr count]; i++)
        {
            RepostsData *d = [[RepostsData alloc]initWithDictionary:[arr objectAtIndex:i]];
            [section3 addObject:d];
            [_commentTable reloadData];
        }
    };
    [dataSource addObject:section3];
}
-(void)commentBtnAction:(UIButton *)sender
{
    //点击第二遍的时候不用再次请求数据
    if ([[[dataSource lastObject] lastObject]isMemberOfClass:[CommentsData class]])
    {
        return;
    }
    //切换成评论的数据
    [dataSource removeLastObject];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.myDataModel.Wid],@"id",@"20",@"count", nil];
    [self getDataArrayandURL:@"comments/show.json" andDictionary:params andMethod:@"GET"];
    
    NSMutableArray *section2 = [NSMutableArray array];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            CommentsData *d=[[CommentsData alloc]initWithDictionary:[arr objectAtIndex:i]];
            [section2 addObject:d];
            [_commentTable reloadData];
        }
    };
    [dataSource addObject:section2];

}
-(void)praiseBtnAction:(UIButton *)sender
{
//    [self.praiseBtn setTitleColor:[UIColor blackColor] forState:0];
//    [self.forwardBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
//    [self.commentBtn setTitleColor:[UIColor colorWithRed:154.0/255 green:154.0/255 blue:154.0/255 alpha:1] forState:0];
}
-(void)clickBtnAction:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 3000:
        {
            TextViewController *TVC= [TextViewController new];
            [self.navigationController pushViewController:TVC animated:YES];
            break;
        }
        case 3001:
        {
            TextViewController *TVC= [TextViewController new];
            [self.navigationController pushViewController:TVC animated:YES];
            break;
        }
        case 3002:
        {
            NSLog(@"赞");
            break;
        }
        default:
            break;
    }
}
#pragma mark -显示图片-
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
