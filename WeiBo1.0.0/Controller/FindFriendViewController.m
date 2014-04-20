//
//  FindFriendViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "FindFriendViewController.h"
#import "SearchViewController.h"
#import "ButtonView.h"
@interface FindFriendViewController ()

@end

@implementation FindFriendViewController

-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索昵称";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    [searchBar release];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"名人",@"兴趣分类",@"周边的人",@"通讯录",nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"head_null",@"head_null",@"head_null",@"head_null", nil];
    ButtonView *buttonView = [[ButtonView alloc]initWithFrame:CGRectMake(7, 64+44+7, 306, 75) andTitlesArr:titleArr andImagesArr:imageArr];
    [self.view addSubview:buttonView];
    [buttonView release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"找朋友";
}
#pragma mark -UISearchBarDelegate代理方法-
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
    return NO;
}

@end
