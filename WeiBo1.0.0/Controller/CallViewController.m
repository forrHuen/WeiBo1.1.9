//
//  CellViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "CallViewController.h"
#import "UserData.h"
#import "ChineseToPinyin.h"
#import "UIImageView+WebCache.h"
@interface CallViewController ()

@end

@implementation CallViewController

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
    Search=[[UISearchBar alloc]initWithFrame:CGRectMake(0,64, 320, 44)];
    [self.view addSubview:Search];
    Search.placeholder=@"搜索";
    Search.delegate=self;
    tabelview =[[UITableView alloc]initWithFrame:CGRectMake(-15,108,SCREEN_WIDTH,SCREEN_HEIGHT-108) style:UITableViewStylePlain];
    tabelview.dataSource=self;
    tabelview.delegate=self;
    [self.view addSubview:tabelview];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    array=[[NSMutableArray alloc]init];
    NSMutableArray *array2=[NSMutableArray array];
    for (int i=0;i<[self.data count];i++)
    {
        UserData *d=[[UserData alloc]initWithDictionary:[self.data objectAtIndex:i]];
        [array2 addObject:d];
    }
    Index=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    for (int i=0;i<[Index count];i++)
    {
        NSArray *air=[self telihua:array2 andclass:[Index objectAtIndex:i]];
        [array addObject:air];
    }
}
-(NSArray*)telihua:(NSArray*)arra andclass:(NSString *)str
{
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0;i<arra.count;i++)
    {
        UserData *d=[arra objectAtIndex:i];
        char air=[ChineseToPinyin sortSectionTitle:d.name];
        char stry =[str characterAtIndex:0];
        if (air==stry)
        {
            [arr addObject:[arra objectAtIndex:i]];
        }
    }
    return arr;
}
#pragma mark --UISearchBardelegate--
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![searchBar.text isEqualToString:@""])
    {
        //输入的时候走的方法
        NSString *result =[NSString stringWithFormat:@"SELF Like[c]'%@*'",searchBar.text];
        NSPredicate *pred=[NSPredicate predicateWithFormat:result];
        NSMutableArray *ax=[NSMutableArray array];
        NSMutableArray *dx=[NSMutableArray array];
        for (NSArray *arr in array)
        {
            for (UserData *d in arr)
            {
                [dx addObject:d];
                [ax addObject:d.name];
            }
        }
        NSArray *arr3=[ax filteredArrayUsingPredicate:pred];
        ax=[NSMutableArray array];
        [array removeAllObjects];
        array=[[NSMutableArray alloc]init];
        for (int i=0;i<[dx count];i++)
        {
            UserData *d=[dx objectAtIndex:i];
            for (int j=0;j<[arr3 count];j++)
            {
                if ([d.name isEqualToString:[arr3 objectAtIndex:j]])
                {
                    [ax addObject:d];
                }
            }
        }
        Index=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
        for (int i=0;i<[Index count];i++)
        {
            NSArray *air=[self telihua:ax andclass:[Index objectAtIndex:i]];
            [array addObject:air];
        }
        [tabelview reloadData];
    }
    else
    {
        [array removeAllObjects];
        array=[[NSMutableArray alloc]init];
        NSMutableArray *array2=[NSMutableArray array];
        for (int i=0;i<[self.data count];i++)
        {
            UserData *d=[[UserData alloc]initWithDictionary:[self.data objectAtIndex:i]];
            [array2 addObject:d];
        }
        Index=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
        for (int i=0;i<[Index count];i++)
        {
            NSArray *air=[self telihua:array2 andclass:[Index objectAtIndex:i]];
            [array addObject:air];
        }
        [tabelview reloadData];
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [Index objectAtIndex:section];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([array count]==26)
    {
        return 26;
    }
    else
    {
      return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[array objectAtIndex:section]count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str]autorelease];
    }
    UserData *d=[[array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:d.headImageURL] placeholderImage:[UIImage imageNamed:@"head_null"]];
    cell.textLabel.text=d.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:NO];
    UserData *d=[[array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    NSString *str=[NSString stringWithFormat:@"@%@",d.name];
    self.Block(str);
}
@end
