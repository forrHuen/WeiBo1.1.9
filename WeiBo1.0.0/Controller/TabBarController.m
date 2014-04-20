//
//  TabBarController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "SquareViewController.h"
#import "PersonViewController.h"
#import "RoundView.h"

@interface TabBarController ()
{
    UIButton *targetBtn;
    
}
@end

@implementation TabBarController
@synthesize topView;
@synthesize nextView;
@synthesize tabBarImageView = _tabBarImageView;
-(void)dealloc
{
    [_tabBarImageView release];
    [topView release];
    [nextView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *home = [[HomeViewController alloc]init];
    home.tabBarController = self;
    MessageViewController *message = [[MessageViewController alloc]init];
    SquareViewController *square = [[SquareViewController alloc]init];
    PersonViewController *person = [[PersonViewController alloc]init];
    NSArray *array = [NSArray arrayWithObjects:home,message,square,person,nil];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i = 0; i < array.count; i++)
    {
        BaseNavigationController *base = [[BaseNavigationController alloc]initWithRootViewController:[array objectAtIndex:i]];
        [viewControllers addObject:base];
        [base release];
    }
    self.viewControllers = viewControllers;
    [home release];
    [message release];
    [square release];
    [person release];
    
    //自定义TabBarController
    self.tabBar.hidden = YES;
    if (self.tabBar.hidden)
    {
        [self initWithCustomTarBar];
    }
    else
    {
        //系统TabBarController
    }
}
-(void)initWithCustomTarBar
{
    //选项栏
    
    _tabBarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-NavigationBar_HEIGHT,SCREEN_WIDTH, NavigationBar_HEIGHT)];
    _tabBarImageView.backgroundColor = [UIColor whiteColor];
    _tabBarImageView.alpha = 0.9;
    _tabBarImageView.userInteractionEnabled = YES;
    [self.view addSubview:_tabBarImageView];
    
    //选项按钮
    NSArray *arrNormalImages = [NSArray arrayWithObjects:@"n0",@"n1",@"n3",@"n4", nil];
    NSArray *arrSelectImages = [NSArray arrayWithObjects:@"n10",@"n11",@"n13",@"n14", nil];
    for (int i = 0; i < arrNormalImages.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:7];
        [button setImage:[UIImage imageNamed:[arrNormalImages objectAtIndex:i]] forState:0];
        [button setImage:[UIImage imageNamed:[arrSelectImages objectAtIndex:i]] forState:UIControlStateSelected];
        if (i < 2)
        {
            button.frame = CGRectMake(0+i*(SCREEN_WIDTH/5),0,SCREEN_WIDTH/5,NavigationBar_HEIGHT);
        }
        else
        {
            button.frame = CGRectMake(64+i*(SCREEN_WIDTH/5),0,SCREEN_WIDTH/5, NavigationBar_HEIGHT);
        }
        [_tabBarImageView addSubview:button];
    }
    
    self.selectedIndex = 0;//默认选中第一个tabBarItem与对应的VC
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000];
    btn.selected = YES;
    
    targetBtn = btn;//用于记录上一个按钮
    
    /////////////////////////////////加号按钮/////////////////////////////////////////////
    //初始化TopView
    [self initWithTopView];
    //初始化加号按钮
    UIButton *operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [operateBtn addTarget:self action:@selector(animateWithTopView) forControlEvents:7];
    operateBtn.frame = CGRectMake(64*2,0,SCREEN_WIDTH/5, NavigationBar_HEIGHT);
    [operateBtn setImage:[UIImage imageNamed:@"n_add"] forState:0];
    [_tabBarImageView addSubview:operateBtn];
    
    UIView *separate = [[UIView alloc]initWithFrame:CGRectMake(0,-0.5, SCREEN_WIDTH, 0.5)];
    separate.backgroundColor = [UIColor grayColor];
    [_tabBarImageView addSubview:separate];
    [separate release];

}
-(void)buttonClickAction:(UIButton *)sender
{
    if (sender.tag == targetBtn.tag)//点同一个按钮
    {
        return;
    }
    else
    {
        self.selectedIndex = sender.tag -1000;//换VC
        sender.selected = YES;
        targetBtn.selected = NO;
        targetBtn = sender;
    }
}
-(void)initWithTopView
{
#pragma mark -第一页-
    topView = [[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH , SCREEN_HEIGHT)]autorelease];
    [self.view addSubview:topView];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor darkGrayColor];
    topView.alpha = 0.9;

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0,SCREEN_HEIGHT-65, SCREEN_WIDTH,65);
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.userInteractionEnabled = YES;
    UIEdgeInsets insets = {-20,0,0,0};
    cancelBtn.contentEdgeInsets = insets;
    [cancelBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:0];//@"tabbar_compose_background_icon_add"
    [cancelBtn addTarget:self action:@selector(cancelBtnClickAction) forControlEvents:7];
    [topView addSubview:cancelBtn];
    /////////////////oneRow///////////////////
    RoundView *textView = [[RoundView alloc]initWithFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_idea"] andTitle:@"文字" andTag:1000];
    textView.tabBarController = self;
    RoundView *albumView = [[RoundView alloc]initWithFrame:CGRectMake(124, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_photo"] andTitle:@"相册" andTag:1001];
    albumView.tabBarController = self;
    RoundView *photographView = [[RoundView alloc]initWithFrame:CGRectMake(224, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_camera"] andTitle:@"拍照" andTag:1002];
    photographView.tabBarController = self;
    [topView addSubview:textView];
    [topView addSubview:albumView];
    [topView addSubview:photographView];
    [textView release];
    [albumView release];
    [photographView release];
    /////////////////twoRow///////////////////
    RoundView *signInView = [[RoundView alloc]initWithFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_lbs"] andTitle:@"签到" andTag:1003];
    signInView.tabBarController = self;
    RoundView *secondBeatsView = [[RoundView alloc]initWithFrame:CGRectMake(124, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_shooting"] andTitle:@"秒拍" andTag:1004];
    secondBeatsView.tabBarController = self;
    RoundView *moreView = [[RoundView alloc]initWithFrame:CGRectMake(224, SCREEN_HEIGHT, 0, 0) andImage:[UIImage imageNamed:@"tabbar_compose_more"] andTitle:@"更多" andTag:1005];
    moreView.tabBarController = self;
    [topView addSubview:signInView];
    [topView addSubview:secondBeatsView];
    [topView addSubview:moreView];
    [signInView release];
    [secondBeatsView release];
    [moreView release];

#pragma mark -第二页-
    /////////////////nextPage///////////////////
    nextView = [[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,20, SCREEN_WIDTH, SCREEN_HEIGHT)]autorelease];
    nextView.userInteractionEnabled = YES;
    nextView.backgroundColor = [UIColor darkGrayColor];
    nextView.alpha = 0.9;
    [self.view addSubview:nextView];

    RoundView *friendsView = [[RoundView alloc]initWithFrame:CGRectMake(24, 110, 80, 100) andImage:[UIImage imageNamed:@"tabbar_compose_friend"] andTitle:@"好友圈" andTag:1006];
    friendsView.tabBarController = self;
    friendsView.titleLabel.frame = CGRectMake(10, 83, 70, 14);
    RoundView *voicedPicView = [[RoundView alloc]initWithFrame:CGRectMake(124, 110, 80, 100) andImage:[UIImage imageNamed:@"tabbar_compose_voice"] andTitle:@"有声图片" andTag:1007];
    voicedPicView.tabBarController = self;
    voicedPicView.titleLabel.frame = CGRectMake(2, 83, 70, 14);
    RoundView *deleteView = [[RoundView alloc]initWithFrame:CGRectMake(224, 110, 80, 100) andImage:[UIImage imageNamed:@"tabbar_compose_delete"] andTitle:@"定时删" andTag:1008];
    deleteView.tabBarController = self;
    deleteView.titleLabel.frame = CGRectMake(10, 83, 70, 14);
    RoundView *longTextView = [[RoundView alloc]initWithFrame:CGRectMake(24, 230, 80, 100) andImage:[UIImage imageNamed:@"tabbar_compose_envelope"] andTitle:@"长微博" andTag:1009];
    longTextView.tabBarController = self;
    longTextView.titleLabel.frame = CGRectMake(10, 83, 70, 14);
    [nextView addSubview:friendsView];
    [nextView addSubview:voicedPicView];
    [nextView addSubview:deleteView];
    [nextView addSubview:longTextView];
    [friendsView release];
    [voicedPicView release];
    [deleteView release];
    [longTextView release];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,SCREEN_HEIGHT-65, SCREEN_WIDTH/2,65);
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.userInteractionEnabled = YES;
    UIEdgeInsets insets2 = {-20,0,0,0};
    backBtn.contentEdgeInsets = insets2;
    [backBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:0];//@"tabbar_compose_background_icon_add"
    [backBtn addTarget:self action:@selector(backBtnClickAction) forControlEvents:7];
    [nextView addSubview:backBtn];

    UIButton *cancelBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn2.frame = CGRectMake(SCREEN_WIDTH/2,SCREEN_HEIGHT-65, SCREEN_WIDTH/2,65);
    cancelBtn2.backgroundColor = [UIColor whiteColor];
    cancelBtn2.userInteractionEnabled = YES;
    UIEdgeInsets insets3 = {-20,0,0,0};
    cancelBtn2.contentEdgeInsets = insets3;
    [cancelBtn2 setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:0];//@"tabbar_compose_background_icon_add"
    [cancelBtn2 addTarget:self action:@selector(cancelBtnClickAction2) forControlEvents:7];
    [nextView addSubview:cancelBtn2];
    
}
#pragma mark -加号按钮事件-
-(void)animateWithTopView
{
    [self sencondState];
    
    nextView.frame = CGRectMake(SCREEN_WIDTH, 20, SCREEN_WIDTH, SCREEN_HEIGHT);
    NSArray *arr = [nextView subviews];
    [[arr objectAtIndex:0] setFrame:CGRectMake(24, 110, 80, 100)];
    [[arr objectAtIndex:1] setFrame:CGRectMake(124, 110, 80, 100)];
    [[arr objectAtIndex:2] setFrame:CGRectMake(224, 110, 80, 100)];
    [[arr objectAtIndex:3] setFrame:CGRectMake(24, 230, 80, 100)];
}
-(void)cancelBtnClickAction
{
    [self firstState];
}
-(void)backBtnClickAction
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    topView.frame = CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
    nextView.frame = CGRectMake(SCREEN_WIDTH,20, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}
-(void)cancelBtnClickAction2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [[[nextView subviews] objectAtIndex:0] setFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0)];
    [[[nextView subviews] objectAtIndex:1] setFrame:CGRectMake(124, SCREEN_HEIGHT, 0, 0)];
    [[[nextView subviews] objectAtIndex:2] setFrame:CGRectMake(224, SCREEN_HEIGHT, 0, 0)];
    [[[nextView subviews] objectAtIndex:3] setFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0)];
    [UIView setAnimationDidStopSelector:@selector(animateDidEnd2)];
    [UIView commitAnimations];
}
-(void)animateDidEnd2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.0];
    nextView.alpha = 0.0;
    nextView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}
-(void)firstState
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateDidStop)];
    NSArray *arrCustomView = [topView subviews];
    [[arrCustomView objectAtIndex:1] setFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0)];
    [[arrCustomView objectAtIndex:2] setFrame:CGRectMake(24+100, SCREEN_HEIGHT, 0, 0)];
    [[arrCustomView objectAtIndex:3] setFrame:CGRectMake(24+200, SCREEN_HEIGHT, 0, 0)];
    [[arrCustomView objectAtIndex:4] setFrame:CGRectMake(24, SCREEN_HEIGHT, 0, 0)];
    [[arrCustomView objectAtIndex:5] setFrame:CGRectMake(24+100, SCREEN_HEIGHT, 0, 0)];
    [[arrCustomView objectAtIndex:6] setFrame:CGRectMake(24+200, SCREEN_HEIGHT, 0, 0)];
    [UIView commitAnimations];
}
-(void)animateDidStop
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.0];
    topView.alpha = 0.0;
    topView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}
-(void)sencondState
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateDidBegin)];
    topView.frame = CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
    topView.alpha = 0.9;
    [UIView commitAnimations];
}

-(void)animateDidBegin
{
    NSArray *arrCustomView = [topView subviews];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [[arrCustomView objectAtIndex:1] setFrame:CGRectMake(24, 110, 80, 100)];
    [[arrCustomView objectAtIndex:2] setFrame:CGRectMake(24+100, 110, 80, 100)];
    [[arrCustomView objectAtIndex:3] setFrame:CGRectMake(24+200, 110, 80, 100)];
    [[arrCustomView objectAtIndex:4] setFrame:CGRectMake(24, 230, 80, 100)];
    [[arrCustomView objectAtIndex:5] setFrame:CGRectMake(24+100, 230, 80, 100)];
    [[arrCustomView objectAtIndex:6] setFrame:CGRectMake(24+200, 230, 80, 100)];
    [UIView commitAnimations];

}

#pragma mark ---sinaWeiboDelegate---
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    //登陆成功走的方法
    //保存微博用户的信息到本地
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    //注销走的方法
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    //取消登陆
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    //登陆失败
}
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    //token失效走的方法
    
}
@end
