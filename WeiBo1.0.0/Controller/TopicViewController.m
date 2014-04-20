//
//  TopicViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicData.h"
@interface TopicViewController ()

@end

@implementation TopicViewController

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
    Search=[[UISearchBar alloc]initWithFrame:CGRectMake(0,64, 320, 44)];
    [self.view addSubview:Search];
    Search.placeholder=@"搜索";
    Search.delegate=self;
    tabelview =[[UITableView alloc]initWithFrame:CGRectMake(0,108,SCREEN_WIDTH,SCREEN_HEIGHT-108) style:UITableViewStylePlain];
    tabelview.dataSource=self;
    tabelview.delegate=self;
    [self.view addSubview:tabelview];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    array=[[NSMutableArray alloc]init];
    for (int i=0;i<[self.data count];i++)
    {
        TopicData *d=[[TopicData alloc]initWithDictionary:[self.data objectAtIndex:i]];
        [array addObject:d.TopicName];
    }
}
#pragma mark --UISearchBardelegate--
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![searchBar.text isEqualToString:@""])
    {
        //输入的时候走的方法
        NSString *result =[NSString stringWithFormat:@"SELF Like[c]'%@*'",searchBar.text];
        NSPredicate *pred=[NSPredicate predicateWithFormat:result];
        NSArray *arr3=[array filteredArrayUsingPredicate:pred];
        [array removeAllObjects];
        array=[[NSMutableArray alloc]init];
        for (NSString *name in arr3)
        {
            [array addObject:name];
        }
        [tabelview reloadData];
    }
    else
    {
        [array removeAllObjects];
        array=[[NSMutableArray alloc]init];
        for (int i=0;i<[self.data count];i++)
        {
            TopicData *d=[[TopicData alloc]initWithDictionary:[self.data objectAtIndex:i]];
            [array addObject:d.TopicName];
        }
        [tabelview reloadData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str]autorelease];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"#%@#",[array objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:NO];
    NSString *str=[NSString stringWithFormat:@"#%@#",[array objectAtIndex:indexPath.row]];
    self.Block(str);
}

@end
