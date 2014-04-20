//
//  PersonViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonalCell.h"
#import "SetViewController.h"
#import "SetUserViewController.h"
#import "UserDataModel.h"
@implementation PersonViewController
-(void)dealloc
{
    [_myTable release];
    [dataSource release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
-(void)loadView
{
    [self mylogin];
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    self.title = @"我";
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    
    self.myTable = [[[UITableView alloc]initWithFrame:CGRectMake(7, -25, 306, self.view.frame.size.height+50) style:UITableViewStyleGrouped]autorelease];
    self.myTable.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    self.myTable.delegate =self;
    self.myTable.dataSource = self;
    self.myTable.sectionHeaderHeight = 0;
    self.myTable.sectionFooterHeight = 10;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTable];
    
    navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(0, 0, 40, 40);
    [navBtn setTitle:@"设置" forState:0];
    navBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [navBtn setTitleColor:[UIColor orangeColor] forState:0];
    [navBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:navBtn] autorelease];
    

}

#pragma mark =================请求数据==================
//================登陆之后==================
-(void)mylogin
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:SINA_Name forKey:@"screen_name"];
        [self getDataArrayandURL:@"users/show.json" andDictionary:params andMethod:@"GET"];
    }
    else
    {
        //登陆界面
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	dataSource = [[NSMutableArray alloc]init];
    
    self.myBlock=^(NSMutableArray *arr)
    {
        for (int i=0;i<[arr count];i++)
        {
            self.userDataModel=[[UserDataModel alloc]initWithDictionary:[arr objectAtIndex:i]];
            [self.myTable reloadData];
            [[dataSource objectAtIndex:0]addObject:self.userDataModel];
            
            NSLog(@"======================%d",dataSource.count);
        }
    };
    
    for (int i = 0 ; i<5; i++) {
        [dataSource addObject:[NSMutableArray array]];
    }
    
    [[dataSource objectAtIndex:1]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"我的好友",@"title",@"personal_friend",@"image", nil]];
    
    [[dataSource objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"我的相册",@"title",@"personal_myphoto",@"image", nil]];
    [[dataSource objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"我的收藏",@"title",@"personal_mycollect",@"image", nil]];
    [[dataSource objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"赞",@"title",@"personal_praise",@"image", nil]];
    
    [[dataSource objectAtIndex:3]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"微博支付",@"title",@"personal_pay",@"image", nil]];
    [[dataSource objectAtIndex:3]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"会员中心",@"title",@"personal_vip",@"image", nil]];
    
    [[dataSource objectAtIndex:4]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"我的名片",@"title",@"personal_mycard",@"image", nil]];
    [[dataSource objectAtIndex:4]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"草稿箱",@"title",@"personal_draft",@"image", nil]];
    

    
}
#pragma mark ===============tableViewDelegate==================
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0||section==3||section==4) {
        return 2;
    }
    else if(section ==1)
    {
        return 1;
    }
    else {
        return 3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellType aType;
    if (indexPath.section ==0 &&indexPath.row==0) {
        aType = firstTypeCell;
    }
    else if(indexPath.section==0 && indexPath.row ==1)
    {
        aType = secondTypeCell;
    }
    else if(indexPath.section ==2)
    {
        aType = fourTypeCell;
    }
    else
    {
        aType = thirdTypeCell;
    }
    //初始化自定义Cell ======================
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        [cell removeFromSuperview];
        cell = [[[PersonalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andCell:aType]autorelease];
    }
    //==cell的类型选择===================
    switch (aType) {
        case firstTypeCell:
        {
            if ([[dataSource objectAtIndex:0] count]==0)
            {
                
            }
            else
            {
                UserDataModel *userData=[[dataSource objectAtIndex:0] objectAtIndex:0];
                [cell setDataWithCell:userData];
                [cell setSizeWithCell:userData];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case secondTypeCell:
        {
            if ([[dataSource objectAtIndex:0] count]==0)
            {
                
            }
            else
            {
                UserDataModel *userData=[[dataSource objectAtIndex:0] objectAtIndex:0];
                [cell setDataWithCell:userData];
                [cell setSizeWithCell:userData];
            }
        }
            break;
        case thirdTypeCell:
        {
            cell.titleLabel.text = [[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            
            cell.titleImage.image = [UIImage imageNamed:[[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"image"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case fourTypeCell:
        {
            if ([[dataSource objectAtIndex:0] count]==0)
            {
                
            }
            else
            {
                UserDataModel *userData=[[dataSource objectAtIndex:0] objectAtIndex:0];
                [cell setDataWithCell:userData];
                [cell setSizeWithCell:userData];
            if (indexPath.row==1) {
                cell.titleNum.text = [NSString stringWithFormat:@"(%@)",userData.favourites_count];
                }
            }
            if (indexPath.row==2) {
                cell.titleNum.frame = CGRectMake(60, 10.5, 50, 24);
            }
            
            cell.titleLabel.text = [[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            
            cell.titleImage.image = [UIImage imageNamed:[[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"image"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCell *mycell = (PersonalCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return mycell.frame.size.height;
}

//=============cell的点击事件=======================
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                SetUserViewController *userVC = [SetUserViewController new];
                userVC.UserData = self.userDataModel;
                NSLog(@"%@",userVC.UserData);
                [self.navigationController pushViewController:userVC animated:YES];
                [userVC release];
            }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark ================pushAction==============
-(void)rightBtnAction:(id)sender
{
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
    [setVC release];
    
}



@end
