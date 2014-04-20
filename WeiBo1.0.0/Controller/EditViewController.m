//
//  EditViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "EditViewController.h"
#import "SetUserViewController.h"
#import "EditCell.h"
#import "UIImageView+WebCache.h"

@implementation EditViewController
-(void)dealloc
{
    [_editTable release];
    [dataSource release];
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
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    self.title = @"编辑资料";
    
    
    //初始化表视图
    self.editTable = [[UITableView alloc]initWithFrame:CGRectMake(10, -30, 300, self.view.frame.size.height+30) style:UITableViewStyleGrouped];
    self.editTable.dataSource = self;
    self.editTable.delegate = self;
    self.editTable.sectionHeaderHeight = 5;
    self.editTable.sectionFooterHeight = 0;
    self.editTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.editTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.editTable];
    
    //自定义左右BarButton
    UIButton *returnBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBackBtn.frame = CGRectMake(0, 0, 28, 25);
    [returnBackBtn setBackgroundImage:[UIImage imageNamed:@"returnBackB"] forState:0];
    [returnBackBtn setTitleColor:[UIColor orangeColor] forState:0];
    [returnBackBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(0, 0, 28, 25);
    [comfirmBtn setBackgroundImage:[UIImage imageNamed:@"comfirmBtn"] forState:0];
    [comfirmBtn setTitleColor:[UIColor orangeColor] forState:0];
    [comfirmBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:comfirmBtn]autorelease];
     self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:returnBackBtn] autorelease];
    
    
}

#pragma mark ==============数据源===============
- (void)viewDidLoad
{
    [super viewDidLoad];
	dataSource = [[NSMutableArray alloc]init];
    for (int i = 0; i<3; i++) {
        [dataSource addObject:[NSMutableArray array]];
    }
    NSArray *arr1 = [NSArray arrayWithObjects:@"昵称",@"性别",@"所在地",@"简介", nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"生日",@"邮箱",@"博客",@"QQ",@"MSN", nil];
    NSArray *arr3 = [NSArray arrayWithObjects:@"输入出生日期",@"输入邮箱",@"输入博客地址",@"QQ账号",@"MSN账号", nil];
    
    for (int i = 0; i<arr1.count; i++) {
        [[dataSource objectAtIndex:1]addObject:[NSDictionary dictionaryWithObjectsAndKeys:[arr1 objectAtIndex:i],@"title", nil]];
    }
    for (int i = 0; i<arr2.count; i++) {
        [[dataSource objectAtIndex:2]addObject:[NSDictionary dictionaryWithObjectsAndKeys:[arr2 objectAtIndex:i],@"title",[arr3 objectAtIndex:i],@"info", nil]];
    }
}

#pragma mark ==============BarButton点击事件方法============
-(void)leftBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ===============表视图Delegate=================
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 4;
    }else
        return 5;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //两种类型的Cell-------
    CellType cellType;
    if (indexPath.section==0) {
        cellType = firstTypeCell;
    }else{
        cellType = secondTypeCell;
    }
    static NSString *CellIdentifier = @"cell";
    EditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[EditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier typeCell:cellType];
    }
    //选择Cell的种类==================
    switch (cellType) {
        case firstTypeCell:
        {
             [cell.headImage setImageWithURL:[NSURL URLWithString:self.userData.profile_image_url] placeholderImage:[UIImage imageNamed:@"head_null"]];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case secondTypeCell:
        {
            cell.infoLabel.text = [[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"title"];
            if (indexPath.section ==1 &&indexPath.row == 0) {
                cell.userInfoLabel.text = self.userData.screen_name;
            }
            else if (indexPath.section ==1 &&indexPath.row == 1)
            {
                if ([self.userData.gender isEqualToString:@"m"]) {
                    cell.userInfoLabel.text = @"男";
                }else{
                    cell.userInfoLabel.text = @"女";
                }
            }else if (indexPath.section ==1 &&indexPath.row == 2)
            {
                cell.userInfoLabel.text =self.userData.location;
            }
            else if(indexPath.section ==1 &&indexPath.row==3)
            {
                cell.userInfoLabel.text = self.userData.description;
                cell.frame = CGRectMake(0, 0, 300, 60);
                cell.infoLabel.frame =CGRectMake(10, 20, 60, 20);
                cell.userInfoLabel.frame = CGRectMake(80, 20, 220, 20);
                cell.separateImage.frame = CGRectMake(0, 59.5, 300, 0.5);
            }
            else
            {
                cell.userInfoLabel.text = [[[dataSource objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectForKey:@"info"];
                cell.userInfoLabel.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
            }
        
        }
            break;
        default:
            break;
    }
    
    return cell;
}
//------cell的高度------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditCell *cell = (EditCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
//--------------cell的点击事件------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
