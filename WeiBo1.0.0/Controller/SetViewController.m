//
//  SetViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "SetViewController.h"
#import "SetCell.h"

@implementation SetViewController
-(void)dealloc
{
    [dataSouce release];
    [_setTabel release];
    [super dealloc];
}
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
    self.view = [[[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    
    
    //自定义BarButtom
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 28, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"returnBackB"] forState:0];
    [backBtn setTitleColor:[UIColor orangeColor] forState:0];
    [backBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:backBtn] autorelease];
    
    //初始化tableview
    self.setTabel = [[[UITableView alloc]initWithFrame:CGRectMake(10, 34, 300, self.view.frame.size.height) style:UITableViewStyleGrouped]autorelease];
    _setTabel.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    _setTabel.delegate = self;
    _setTabel.dataSource = self;
    _setTabel.sectionFooterHeight = 5;
    _setTabel.sectionHeaderHeight = 0;
    _setTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_setTabel];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	dataSouce = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<5; i++) {
        [dataSouce addObject:[NSMutableArray array]];
    }
    [[dataSouce objectAtIndex:0]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"账号管理",@"title",nil]];
    [[dataSouce objectAtIndex:1]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"主题、背景",@"title",@"personal_new",@"image", nil]];
    [[dataSouce objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"通知和提醒",@"title",nil]];
    [[dataSouce objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"通用设置",@"title",nil]];
    [[dataSouce objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"隐私与安全",@"title",nil]];
    [[dataSouce objectAtIndex:3]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"意见反馈",@"title",nil]];
    [[dataSouce objectAtIndex:3]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"关于微博",@"title",nil]];
    [[dataSouce objectAtIndex:4]addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"退出当前账号",@"title",@"personal_setBG1",@"image", nil]];
}

#pragma mark ================tableDelegate===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1||section==4) {
        return 1;
    }else if (section==2)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d%d",[indexPath section],[indexPath row]];
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CellType aType;
    if (indexPath.section ==1) {
        aType = secondTypeCell;
    }else if (indexPath.section==4)
    {
        aType = thirdTypeCell;
    }else
    {
        aType = firstTypeCell;
    }
    
    if (!cell) {
        cell = [[[SetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier CellTypeCell:aType]autorelease];
    }
    switch (aType) {
        case firstTypeCell:
        {
            cell.titleLabel.text= [[[dataSouce objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case secondTypeCell:
        {
            cell.titleLabel.text= [[[dataSouce objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            cell.rightImage.image = [UIImage imageNamed:[[[dataSouce objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"image"]];
        }
            break;
        case thirdTypeCell:
        {
            cell.titleLabel.text= [[[dataSouce objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            cell.rightImage.image = [UIImage imageNamed:[[[dataSouce objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"image"]];
        }
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetCell *cell = (SetCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark ========leftBtnAction=======
-(void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
