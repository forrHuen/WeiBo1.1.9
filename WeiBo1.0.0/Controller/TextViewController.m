//
//  TextViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TextViewController.h"
#import "TopicViewController.h"
#import "CallViewController.h"
@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[self.datamodel.fourTypeDic objectForKey:@"retweeted"] intValue]==1)
    {
        NSString *RET=[NSString stringWithFormat:@" //@%@:%@",self.datamodel.name,self.datamodel.text];
        textview.text=RET;
    }
    else
    {
        textview.text=@"转发微博";
    }
    [self loing];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"转发" style:UIBarButtonItemStylePlain target:self action:@selector(fasong:)];
    l.text=@"转发同时评论";
	// Do any additional setup after loading the view.
}
-(void)loing
{
    SinaWeibo *sinaWB = [self getSinaWB];
    [sinaWB logIn];
    if ([sinaWB isAuthValid])
    {
        
    }
    else
    {
        
    }
}
-(void)fasong:(id)btn
{
    if (textview.text.length!=0)
    {
        if (textview.text.length<140)
        {
            if (self.Y)
            {
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.datamodel.Wid],@"id",textview.text,@"status",@"1",@"is_comment", nil];
                [self getDataArrayandURL:@"statuses/repost.json" andDictionary:dic andMethod:@"POST"];
                
            }
            else
            {
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",self.datamodel.Wid],@"id",textview.text,@"status", nil];
                [self getDataArrayandURL:@"statuses/repost.json" andDictionary:dic andMethod:@"POST"];
                
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"转发文本长度超过140" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
    }
    self.myBlock=^(NSMutableArray *arr)
    {
        [self.navigationController popViewControllerAnimated:NO];
    };
}
-(void)TopicClick:(UIButton*)btn
{
    if (textview.text.length!=0)
    {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys: nil];
        [self getDataArrayandURL:@"trends/weekly.json" andDictionary:dic andMethod:@"GET"];
    }
    self.myBlock=^(NSMutableArray *array)
    {
        TopicViewController *top=[[TopicViewController alloc]init];
        top.data=array;
        top.Block=^(NSString *str)
        {
            if ([textview.text isEqualToString:@"转发微博"])
            {
                textview.text=str;
            }
            else
            {
                textview.text=[NSString stringWithFormat:@"%@%@",str,textview.text];
            }
        };
        [self.navigationController pushViewController:top animated:NO];
        [top release];
    };
}
-(void)CellClick:(UIButton*)btn
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:SINA_Name,@"screen_name", nil];
    [self getDataArrayandURL:@"friendships/followers.json" andDictionary:dic andMethod:@"GET"];
    self.myBlock=^(NSMutableArray *array)
    {
        CallViewController *cell=[[CallViewController alloc]init];
        cell.data=array;
        cell.Block=^(NSString *str)
        {
            if ([textview.text isEqualToString:@"转发微博"])
            {
                textview.text=str;
            }
            else
            {
                textview.text=[NSString stringWithFormat:@"%@%@",str,textview.text];
            }
        };
        [self.navigationController pushViewController:cell animated:NO];
        [cell release];
    };
    
}

@end