//
//  MessageViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "MessageViewController.h"
#import "PrivateLetterViewController.h"
#import "CommontController.h"
#import "CallController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    self.title = @"消息";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:self action:@selector(pushPrivateLetterAction)]autorelease];
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	array =[[NSMutableArray alloc]init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"评论",@"name",@"messagescenter_comments",@"pic",nil];
   NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"@我",@"name",@"messagescenter_at" ,@"pic",nil];
    [array addObject:dic];
    [array addObject:dic2];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
    }
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[dic objectForKey:@"pic"]];
    cell.textLabel.text=[dic objectForKey:@"name"];
    cell.detailTextLabel.text=@">";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CallController *bvc=[[CallController alloc]init];
    CommontController *avc=[[CommontController alloc]init];
    
    NSArray *arr=[NSArray arrayWithObjects:avc,bvc, nil];
    [self.navigationController pushViewController:[arr objectAtIndex:indexPath.row] animated:NO];
    [bvc release];
    [avc release];
}
-(void)pushPrivateLetterAction
{
    PrivateLetterViewController *letter = [[PrivateLetterViewController alloc]init];
    [self.navigationController pushViewController:letter animated:YES];
}
@end
