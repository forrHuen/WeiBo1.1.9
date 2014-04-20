//
//  SetUserViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "SetUserViewController.h"
#import "UserMainViewController.h"
#import "UserPhotoViewController.h"
#import "UIImageView+WebCache.h"
#import "ForwardCell.h"
#import "DataModel.h"
#import "FindFriendViewController.h"
#import "BodyViewController.h"
#import "TextViewController.h"
#import "HTMLViewController.h"
#import "CommViewController.h"
#import "EditViewController.h"
@implementation SetUserViewController

-(void)dealloc
{
    [_userTable release];
    [dataSource release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.userMainViewController = [[UserMainViewController alloc]init];
        self.userPhotoViewController = [[UserPhotoViewController alloc]init];
    }
    return self;
}
-(void)loadView
{
    separateX = 135;
    [self myLogin];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBarHidden = YES;
    
    
//    //自定义BarButtom
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 25, 25);
//    [backBtn setBackgroundImage:[UIImage imageNamed:@"returnBack"] forState:0];
//    [backBtn setTitleColor:[UIColor orangeColor] forState:0];
//    [backBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:backBtn] autorelease];
    
    self.userImageView= [[[UIImageView alloc]initWithFrame:CGRectMake(0,-60, 320, 320)]autorelease];
    self.userImageView.userInteractionEnabled = YES;
    self.userImageView.image = [UIImage imageNamed:@"personal_userBG.jpg"];
//    self.userImageView.backgroundColor = [UIColor redColor];
    
   
    //初始化ScrollView
    self.userScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.userScrollView.contentSize = CGSizeMake(320, self.userScrollView.frame.size.height);
    self.userScrollView.showsVerticalScrollIndicator = NO;
    self.userScrollView.bounces = YES;
    self.userScrollView.scrollEnabled = YES;
    self.userScrollView.userInteractionEnabled = YES;
    self.userScrollView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    self.userScrollView.delegate = self;
    [self.view addSubview:self.userScrollView];
    
    
#pragma mark ============初始化TableView=============
    //初始化TableView
    self.userTable = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain]autorelease];
    self.userTable.backgroundColor = [UIColor clearColor];
    self.userTable.delegate =self;
    self.userTable.dataSource = self;
    self.userTable.userInteractionEnabled = YES;
    self.userTable.showsVerticalScrollIndicator =NO;
    self.userTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.userScrollView addSubview:self.userTable];
    [self.userScrollView addSubview:self.userImageView];
    
    //=================表头视图=================
    self.userView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    self.userView.userInteractionEnabled = YES;
    self.userView.backgroundColor = [UIColor clearColor];
    [self.userScrollView addSubview:self.userView];
    
    //头像背景
    UIImageView *userHeadBG = [[UIImageView alloc]initWithFrame:CGRectMake((320-66)/2, (205-66)/2, 66, 66)];
    userHeadBG.backgroundColor = [UIColor whiteColor];
    userHeadBG.userInteractionEnabled = YES;
    userHeadBG.layer.cornerRadius = 3;
    userHeadBG.alpha = 0.6;
    
    [self.userView addSubview:userHeadBG];
    
    //用户头像
    self.userHead = [[UIImageView alloc]initWithFrame:CGRectMake((320-60)/2, (205-60)/2, 60, 60)];
    self.userHead.userInteractionEnabled = YES;
    [self.userView addSubview:self.userHead];
    
    //用户昵称
    self.userName = [[[UILabel alloc]initWithFrame:CGRectMake(110, 140, 100, 25)]autorelease];
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.textColor = [UIColor whiteColor];
    self.userName.shadowColor = [UIColor blackColor];
    self.userName.shadowOffset = CGSizeMake(0.8, 0.3);
    self.userName.font = [UIFont boldSystemFontOfSize:18];
    [self.userView addSubview:self.userName];
    
    //性别
    UIImageView *sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(110+100, 143, 20, 20)];
    sexImage.userInteractionEnabled = YES;
    sexImage.image = [UIImage imageNamed:@"sexnan"];
    [self.userView addSubview:sexImage];
    
    //关注
    self.followerLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 170, 320/2-15, 35)]autorelease];
    self.followerLabel.textAlignment = NSTextAlignmentRight;
    self.followerLabel.shadowColor = [UIColor blackColor];
    self.followerLabel.shadowOffset = CGSizeMake(-0.2, -0.2);
    self.followerLabel.font = [UIFont boldSystemFontOfSize:15];
    self.followerLabel.textColor = [UIColor whiteColor];
    [self.userView addSubview:self.followerLabel];
    
    //粉丝
    self.fansLabel = [[[UILabel alloc]initWithFrame:CGRectMake(175, 170, 320-175, 35)]autorelease];
    self.fansLabel.textAlignment = NSTextAlignmentLeft;
    self.fansLabel.shadowColor = [UIColor blackColor];
    self.fansLabel.shadowOffset = CGSizeMake(-0.2, -0.2);
    self.fansLabel.font = [UIFont boldSystemFontOfSize:15];
    self.fansLabel.textColor = [UIColor whiteColor];
    [self.userView addSubview:self.fansLabel];
    
    //分割线
    UIImageView *separateView = [[UIImageView alloc]initWithFrame:CGRectMake(320/2-1, 180, 2, 15)];
    separateView.backgroundColor = [UIColor whiteColor];
    separateView.userInteractionEnabled = YES;
    [self.userView addSubview:separateView];
    
    //底部视图
    UIImageView *footView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 205, 320, 75)];
    footView.userInteractionEnabled = YES;
    
    footView.backgroundColor = [UIColor whiteColor];
    [self.userView addSubview:footView];
    
    //个人简介
    self.briefLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 20)]autorelease];
    self.briefLabel.textColor = [UIColor grayColor];
    self.briefLabel.textAlignment = NSTextAlignmentCenter;
    self.briefLabel.font = [UIFont systemFontOfSize:12];
    [footView addSubview:self.briefLabel];
    
    
    //编辑按钮背景视图
    
    UIImageView *editBG = [[UIImageView alloc]initWithFrame:CGRectMake(109, 29, 102, 37)];
    editBG.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    editBG.layer.cornerRadius = 2;
    [footView addSubview:editBG];
    //编辑按钮
    UIButton*editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(110, 30, 100, 35);
    editBtn.backgroundColor = [UIColor colorWithRed:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
    [editBtn setImage:[UIImage imageNamed:@"personal_edit"] forState:0];
    [editBtn setTitle:@"编辑资料" forState:0];
    [editBtn setTitleColor:[UIColor grayColor] forState:0];
    editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [editBtn addTarget:self action:@selector(EditBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:editBtn];
    
    //--------------footView按钮选择视图-------------
    UIView *footImageView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, 320, 40)];
    footImageView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    footImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    footImageView.layer.shadowOffset = CGSizeMake(0, 0.7);
    footImageView.layer.shadowOpacity = 10;
    footImageView.layer.shadowRadius = 0.4;
    footImageView.userInteractionEnabled = YES;
    [self.userView addSubview:footImageView];
    
    //主页
    UIButton *myHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myHomeBtn.frame = CGRectMake(40, 0, 80, 39);
    myHomeBtn.tag = 505;
    [myHomeBtn setTitle:@"主页" forState:0];
    myHomeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [myHomeBtn setTitleColor:[UIColor grayColor] forState:0];
    [myHomeBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footImageView addSubview:myHomeBtn];
    
    //微博
    UIButton *microblogBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    microblogBtn.frame = CGRectMake(120, 0, 80, 39);
    microblogBtn.tag = 506;
    [microblogBtn setTitle:@"微博" forState:0];
    microblogBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [microblogBtn setTitleColor:[UIColor grayColor] forState:0];
    [microblogBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footImageView addSubview:microblogBtn];
    
    //相册
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake(200, 0, 80, 39);
    photoBtn.tag= 507;
    [photoBtn setTitleColor:[UIColor grayColor] forState:0];
    photoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [photoBtn setTitle:@"相册" forState:0];
    [photoBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footImageView addSubview:photoBtn];
    
    //动画线
    self.footSeparate = [[UIImageView alloc]initWithFrame:CGRectMake(separateX, 38, 50, 2)];
    self.footSeparate.backgroundColor = [UIColor colorWithRed:255.0/255 green:129.0/255 blue:39.0/255 alpha:1];
    self.footSeparate.userInteractionEnabled = YES;
    [footImageView addSubview:self.footSeparate];
    

#pragma mark ==================表视图头部视图===============
    //============根视图控件===============
    
    //左右按钮之返回按钮
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn .frame = CGRectMake(5, 25, 28, 25);
    self.leftBtn .backgroundColor =[ UIColor blackColor];
    self.leftBtn .layer.cornerRadius = 3;
    [self.leftBtn  setBackgroundImage:[UIImage imageNamed:@"returnBackW"] forState:0];
    self.leftBtn .alpha = 0.5;
    [self.leftBtn  addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBtn ];
    
    //左右按钮之共享按钮
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(287, 25, 28, 25);
    self.rightBtn.backgroundColor = [UIColor blackColor];
    self.rightBtn.layer.cornerRadius = 3;
    self.rightBtn.alpha = 0.5;
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:0];
    [self.view addSubview:self.rightBtn];
    
    
    //=================表视图头部视图===================
    
    //承载三个按钮，线======
    self.moveTopView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    self.moveTopView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    self.moveTopView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.moveTopView.layer.shadowOffset = CGSizeMake(0, 0.7);
    self.moveTopView.layer.shadowOpacity = 10;
    self.moveTopView.layer.shadowRadius = 0.4;
    self.moveTopView.hidden = YES;
    self.moveTopView.userInteractionEnabled =YES;
    [self.view addSubview:self.moveTopView];
    
    //表视图头部主页
    UIButton *topMyHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topMyHomeBtn.tag = 501;
    topMyHomeBtn.frame = CGRectMake(40, 20, 80, 39);
    [topMyHomeBtn setTitle:@"主页" forState:0];
    topMyHomeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [topMyHomeBtn setTitleColor:[UIColor grayColor] forState:0];
    [topMyHomeBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.moveTopView addSubview:topMyHomeBtn];
    
    //表视图头部微博
    UIButton *topMicroblogBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    topMicroblogBtn.tag = 502;
    topMicroblogBtn.frame = CGRectMake(120, 20, 80, 39);
    [topMicroblogBtn setTitle:@"微博" forState:0];
    topMicroblogBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [topMicroblogBtn setTitleColor:[UIColor grayColor] forState:0];
    [topMicroblogBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.moveTopView addSubview:topMicroblogBtn];
    
    //表视图头部相册
    UIButton *topPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topPhotoBtn.tag = 503;
    topPhotoBtn.frame = CGRectMake(200, 20, 80, 39);
    [topPhotoBtn setTitleColor:[UIColor grayColor] forState:0];
    topPhotoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [topPhotoBtn setTitle:@"相册" forState:0];
    [topPhotoBtn addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.moveTopView addSubview:topPhotoBtn];
    
    //top按钮之返回按钮
    UIButton *topBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBackBtn.frame = CGRectMake(5, 27, 28, 25);
    topBackBtn.layer.cornerRadius = 3;
    [topBackBtn setBackgroundImage:[UIImage imageNamed:@"returnBackB"] forState:0];
    [topBackBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.moveTopView addSubview:topBackBtn];
    
    //top按钮之共享按钮
    UIButton *topshareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topshareBtn.frame = CGRectMake(287, 27, 28, 25);
    topshareBtn.layer.cornerRadius = 3;
    [topshareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtnB"] forState:0];
    [self.moveTopView addSubview:topshareBtn];
    
    //动画线
    self.topSeparate = [[UIImageView alloc]init];
    self.topSeparate.backgroundColor = [UIColor colorWithRed:255.0/255 green:129.0/255 blue:39.0/255 alpha:1];
    self.topSeparate.userInteractionEnabled = YES;
    [self.moveTopView addSubview:self.topSeparate];
    
    
    
}

#pragma mark =================请求数据==================
//================登陆之后==================
-(void)myLogin
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.UserData.Uid],@"uid",@"20",@"count",nil];
        [self getDataArrayandURL:@"statuses/user_timeline.json" andDictionary:params andMethod:@"GET"];
    }
    else
    {
        //登陆界面
    }
    
}

#pragma mark ==============数据源=================

- (void)viewDidLoad
{
    [super viewDidLoad];
	dataSource = [[NSMutableArray alloc]init];
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            //存每条微博的key值
            [dataSource addObject:[arr objectAtIndex:i]];
            [self.userTable reloadData];
        }
    };
    
//------------------------控件插入数据--------------
    
    
            
            
            self.userName.text = self.UserData.screen_name;
    
            self.briefLabel.text = [NSString stringWithFormat:@"简介:%@",self.UserData.description];
            [self.userHead setImageWithURL:[NSURL URLWithString:self.UserData.profile_image_url] placeholderImage:[UIImage imageNamed:@"head_null"]];
            self.followerLabel.text = [NSString stringWithFormat:@"关注 %@",[self.UserData.friends_count stringValue]];
            self.fansLabel.text = [NSString stringWithFormat:@"粉丝 %@",[self.UserData.followers_count stringValue]];
            
//        }
//    };
}


#pragma mark ========leftBtnAction=======
-(void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ==============ScrollViewDelegate===========
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"y=%f",self.userTable.contentOffset.y);
    CGFloat Yoffset = self.userTable.contentOffset.y;
    CGFloat mainOffset = self.userMainViewController.UserMainTable.contentOffset.y;
    NSLog(@"mainOFFset ==%f",mainOffset);
//    CGFloat photoOffset = self.userPhotoViewController.UserPhotoTable.contentOffset.y;
    //==================视觉差效果=================
    //往下移动
    
    if (Yoffset<0 ) {
        self.userImageView.frame = CGRectMake(0, -60-(Yoffset*0.5), 320, 320);
        self.userView.frame = CGRectMake(0, -Yoffset, 320, 320);
        
        
        
    }
    //往上移动
    if (Yoffset>0)
    {
        self.userImageView.frame = CGRectMake(0, -(Yoffset)-60, 320, 320);
        self.userView.frame = CGRectMake(0, -Yoffset, 320, 320);
        
        
    }
    //=================按钮变换视觉效果=================
     if(Yoffset>=260)
    {
        self.leftBtn.hidden = YES;
        self.rightBtn.hidden = YES;
        self.moveTopView.hidden = NO;
        self.topSeparate.frame =CGRectMake(separateX, 58, 50, 2);
        
    }
    
    if (Yoffset<260)
    {
        self.leftBtn.hidden = NO;
        self.rightBtn.hidden = NO;
        self.moveTopView.hidden = YES;
        self.footSeparate.Frame=CGRectMake(separateX, 38, 50, 2);
        
    }else
    {}

}


#pragma mark ===============TableViewDelegate=============

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellType ctype;
    if (dataSource.count && dataSource.count != indexPath.row)
    {
        self.myData = [[DataModel alloc]initWithDictionary:[dataSource objectAtIndex:indexPath.row]];
        int retweeted = [[self.myData.fourTypeDic objectForKey:@"retweeted"] integerValue];
        int pic = [[self.myData.fourTypeDic objectForKey:@"pic"] integerValue];
        if (retweeted==1&&pic == 1)
        {
            ctype=AFAndHasPic;
        }
        else if(retweeted==1&&pic==0)
        {
            ctype=AFAndNOPic;
        }
        else if(retweeted==0&&self.myData.Images.count != 0)
        {
            ctype=NonAFAndHasPic;
        }
        else
        {
            ctype=NonAFAndNOPic;
        }
        NSLog(@"%u ---- %d",ctype,indexPath.row);
    }
    int a = self.myData.Images.count;
    static NSString *forwardCellIdentifier = @"forwardCellIdentifier";
    ForwardCell *forwardCell =[tableView dequeueReusableHeaderFooterViewWithIdentifier:forwardCellIdentifier];
    if (!forwardCell)
    {
        forwardCell = [[[ForwardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:forwardCellIdentifier andType:ctype andImageNumber:a ]autorelease];
    }
    forwardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataSource.count)
    {
        [forwardCell setCountandData:self.myData];
        [forwardCell setCellandContentHeightandData:self.myData];
        forwardCell.model = self.myData;
        forwardCell.middleView.personBlock = ^(DataModel *model)
        {
            
        };

        forwardCell.middleView.showBlock = ^(NSArray *urlStrArr,int num,BOOL b,CGFloat long_height)
        {
            
        };
        forwardCell.myCommentCellBlock = ^(DataModel *model)
        {
            
        };
    
        forwardCell.myPresionBlock = ^(DataModel *model)
        {
            
        };
        forwardCell.middleView.myHttpBlock= ^(NSString *str)
        {
            
        };
    }
    return forwardCell;
}
#pragma mark =================自定义表头==============
//=======表头==============
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 296)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.userTable setTableHeaderView:headView];
    return headView;
}
//===============行高=================
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



#pragma mark ============主页、微博、相册按钮方法==============

//=========top视图按钮方法===============
-(void)topBtnAction:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    switch (sender.tag)
    {
        //表示图头部的主页
        case 501:
        {
            self.topSeparate.frame = CGRectMake(55, 58, 50, 2);
            separateX = self.topSeparate.frame.origin.x;
            
            
        }
            break;
        //微博
        case 502:
        {
            self.topSeparate.frame = CGRectMake(135, 58, 50, 2);
            separateX = self.topSeparate.frame.origin.x;
        }
            break;
        //相册
        case 503:
        {
            self.topSeparate.frame = CGRectMake(215, 58, 50, 2);
           separateX = self.topSeparate.frame.origin.x;
           
        }
            break;
        case 505:
        {
            self.footSeparate.frame =CGRectMake(55, 38, 50, 2);
            separateX = self.footSeparate.frame.origin.x;
           
            self.userMainViewController.view.frame = CGRectMake(0, 0, 320, 568);
            
            self.userTable.frame = CGRectMake(320, 0, 320, 568);
            self.userPhotoViewController.view.frame = CGRectMake(320, 0, 320, 568);
            
            [_userMainViewController initWithSubViewUserMain];
            [_userMainViewController initWithUserMainData];
            [self.userScrollView insertSubview:_userMainViewController.view atIndex:0];
            
          
            
        }
            break;
        case 506:
        {
         
            self.footSeparate.frame =CGRectMake(135, 38, 50, 2);
            separateX = self.footSeparate.frame.origin.x;
            self.userTable.frame = CGRectMake(0, 0, 320, 568);
            self.userMainViewController.view.frame = CGRectMake(-320, 0, 320, 568);
            self.userPhotoViewController.view.frame = CGRectMake(320, 0, 320, 568);
            [self.userScrollView insertSubview:self.userTable atIndex:0];
        }
            break;
        case 507:
        {
            self.footSeparate.frame =CGRectMake(215, 38, 50, 2);
            separateX = self.footSeparate.frame.origin.x;
            self.userPhotoViewController.view.frame = CGRectMake(0, 0, 320, 568);
            self.userPhotoViewController.view.backgroundColor = [UIColor redColor];
            self.userTable.frame = CGRectMake(-320, 0, 320, 568);
            self.userMainViewController.view.frame = CGRectMake(-320, 0, 320, 568);
            
            [self.userPhotoViewController initWithSubViewUserPhoto];
            [self.userPhotoViewController initWithUserPhotoSource];
            [self.userScrollView insertSubview:self.userPhotoViewController.view atIndex:0];
        }
            break;
        default:
            break;
    }
     [UIView commitAnimations];
}

#pragma mark =============按钮推送事件=============
//==========编辑按钮=============
-(void)EditBtnAction:(UIButton *)sender
{
    EditViewController *editVC = [EditViewController new];
    [self.navigationController pushViewController:editVC animated:YES];
     editVC.userData =self.UserData ;
    self.navigationController.navigationBarHidden = NO;
    [editVC release];
    

}

@end
