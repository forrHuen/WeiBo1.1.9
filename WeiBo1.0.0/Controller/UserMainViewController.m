//
//  UserMainViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "UserMainViewController.h"

@implementation UserMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    
   
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

-(void)initWithSubViewUserMain{
    self.UserMainTable= [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped]autorelease];
    self.UserMainTable.delegate =self;
    self.UserMainTable.dataSource = self;
    [self.view addSubview:self.UserMainTable];
}

-(void)initWithUserMainData{
    UserMainSource = [[NSMutableArray alloc]init];
    [_UserMainTable reloadData];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    cell.textLabel.text = @"爱施德安师大空间的房间的飞地方";
    return cell;
}

#pragma mark =================自定义表头==============
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 296)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.UserMainTable setTableHeaderView:headView];
    return headView;
}
@end
