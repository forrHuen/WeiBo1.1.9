//
//  BaseTextViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseTextViewController.h"
#import "AppDelegate.h"
@interface BaseTextViewController ()

@end

@implementation BaseTextViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
    textview=[[UITextView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,180)];
    textview.text=@"请输入文本内容";
    textview.textAlignment=NSTextAlignmentLeft;
    textview.textColor=[UIColor grayColor];
    textview.font=[UIFont systemFontOfSize:13];
    textview.delegate=self;
    [self.view addSubview:textview];
    viewbtn=[[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-30, 320,30)];
    viewbtn.backgroundColor=[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    [self.view addSubview:viewbtn];
    UIButton *CellBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [CellBtn setImage:[UIImage imageNamed:@"CellBtn"] forState:0];
    [CellBtn addTarget:self action:@selector(CellClick:) forControlEvents:UIControlEventTouchUpInside];
    CellBtn.backgroundColor=[UIColor grayColor];
    CellBtn.frame=CGRectMake(5,0,30,30);
    [viewbtn addSubview:CellBtn];
    UIButton *TopicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [TopicBtn setImage:[UIImage imageNamed:@"TopicBtn"] forState:0];
    [TopicBtn addTarget:self action:@selector(TopicClick:) forControlEvents:UIControlEventTouchUpInside];
    TopicBtn.backgroundColor=[UIColor grayColor];
    TopicBtn.frame=CGRectMake(40,0,30,30);
    [viewbtn addSubview:TopicBtn];
    UIButton *SmiliesBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [SmiliesBtn setImage:[UIImage imageNamed:@"SmiliesBtn"] forState:0];
    [SmiliesBtn addTarget:self action:@selector(SmiliesBtn:) forControlEvents:UIControlEventTouchUpInside];
    SmiliesBtn.backgroundColor=[UIColor grayColor];
    SmiliesBtn.frame=CGRectMake(75,0,30,30);
    [viewbtn addSubview:SmiliesBtn];
    UIButton *DrawBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [DrawBtn setImage:[UIImage imageNamed:@"DrawBtnNo"] forState:0];
    [DrawBtn addTarget:self action:@selector(DrawBtn:) forControlEvents:UIControlEventTouchUpInside];
    DrawBtn.backgroundColor=[UIColor grayColor];
    DrawBtn.frame=CGRectMake(180,5,20,20);
    [viewbtn addSubview:DrawBtn];
    l=[[UILabel alloc]initWithFrame:CGRectMake(205,0,120,30)];
    l.textAlignment=NSTextAlignmentLeft;
    l.backgroundColor=[UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    [viewbtn addSubview:l];
    self.Y=NO;
    self.E=NO;
    
    //创建表情键盘
    if (scrollView==nil) {
        scrollView=[[UIScrollView alloc] initWithFrame:CGRectZero];
        [scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"facesBack"]]];
        for (int i=0; i<9; i++) {
            fview=[[FacialView alloc] initWithFrame:CGRectMake(12+320*i,0, facialViewWidth, facialViewHeight)];
            [fview setBackgroundColor:[UIColor clearColor]];
            [fview loadFacialView:i size:CGSizeMake(33, 43)];
            fview.delegate=self;
            [scrollView addSubview:fview];
            [fview release];
        }
    }
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    scrollView.contentSize=CGSizeMake(320*9, keyboardHeight);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    [scrollView release];
    
    
    
    
    
}
-(void)DrawBtn:(UIButton*)btn
{
    if (self.Y)
    {
        [btn setImage:[UIImage imageNamed:@"DrawBtnNO"] forState:0];
        self.Y=NO;
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"DrawBtnYES"] forState:0];
        self.Y=YES;
    }
    
}
-(void)SmiliesBtn:(UIButton*)btn
{
    if (viewbtn.frame.origin.y!=SCREEN_HEIGHT-keyboardHeight+30)
    {
        viewbtn.frame=CGRectMake(0,SCREEN_HEIGHT-keyboardHeight+30,viewbtn.frame.size.width, viewbtn.frame.size.height);
    }
    else
    {
        viewbtn.frame=CGRectMake(0,SCREEN_HEIGHT-30,viewbtn.frame.size.width, viewbtn.frame.size.height);
    }
    self.E=!self.E;
    [self EmojiKey];
}
-(void)EmojiKey
{
    if (self.E)
    {
        scrollView.frame = CGRectMake(0,SCREEN_HEIGHT-keyboardHeight+60,320,keyboardHeight);
        [textview resignFirstResponder];
    }
    else
    {
        scrollView.frame = CGRectZero;
    }
    
}

#pragma mark facialView delegate 点击表情键盘上的文字
-(void)selectedFacialView:(NSString*)str
{
    NSString *newStr;
    if ([str isEqualToString:@"删除"]) {
        if (textview.text.length>0) {
            if ([[Emoji allEmoji] containsObject:[textview.text substringFromIndex:textview.text.length-2]]) {
                newStr=[textview.text substringToIndex:textview.text.length-2];
            }else{
                newStr=@"";
            }
            textview.text=newStr;
        }
    }else{
        NSString *newStr=[NSString stringWithFormat:@"%@%@",textview.text,str];
        [textview setText:newStr];
    }
}
-(void)TopicClick:(UIButton*)btn
{
    NSLog(@"%s",__func__);
}
-(void)CellClick:(UIButton*)btn
{
    NSLog(@"%s",__func__);
}
-(void)click:(UITapGestureRecognizer *)tap
{
    if (viewbtn.frame.origin.y<400)
    {
        viewbtn.frame=CGRectMake(0,SCREEN_HEIGHT-30,viewbtn.frame.size.width, viewbtn.frame.size.height);
        scrollView.frame = CGRectZero;
        self.E=NO;
    }
    [textview resignFirstResponder];
}
//将要开始编辑

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (viewbtn.frame.origin.y==SCREEN_HEIGHT-keyboardHeight+30)
    {
        viewbtn.frame=CGRectMake(0,viewbtn.frame.origin.y-30,viewbtn.frame.size.width, viewbtn.frame.size.height);
        scrollView.frame=CGRectZero;
        self.E=NO;
    }
    if (viewbtn.frame.origin.y>400)
    {
        viewbtn.frame=CGRectMake(0,viewbtn.frame.origin.y-215,viewbtn.frame.size.width, viewbtn.frame.size.height);
    }
    return YES;
}
//将要结束编辑

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textview.textColor=[UIColor blackColor];
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textview.text.length==0)
    {
        textview.text=@"输入内容为空";
        textview.textColor=[UIColor grayColor];
    }
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=160)
        
    {
        //控制输入文本的长度
        return  NO;
    }
    if ([text isEqualToString:@"\n"])
    {
        //禁止输入换行
        return NO;
    }
    else
    {
        return YES;
    }
    [textview resignFirstResponder];
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView
{
    
}
//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}
-(SinaWeibo *)getSinaWB
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    weiBo = appDelegate.sinaWB;
    return weiBo;
}
-(void)getDataArrayandURL:(NSString *)URL andDictionary:(NSMutableDictionary*)params andMethod:(NSString *)hethod
{
    [weiBo requestWithURL:URL params:params httpMethod:hethod delegate:self];
}
- (void)request:(SinaWeiboRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}
- (void)request:(SinaWeiboRequest *)request didReceiveRawData:(NSData *)data{
    
}
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSMutableArray *array=[NSMutableArray array];
    NSLog(@"%@",result);
    if ([[[result objectForKey:@"trends"]allKeys]count]!=0)
    {
        NSDictionary *dic=[NSDictionary dictionaryWithDictionary:[result objectForKey:@"trends"]];
        for (int i=0;i<[[dic allValues] count];i++)
        {
            NSArray *arr=[NSArray arrayWithArray:[[dic allValues] objectAtIndex:i]];
            for (int j=0;j<[arr count];j++)
            {
                [array addObject:[arr objectAtIndex:j]];
            }
        }
        
    }
    else
    {
        for (NSDictionary *dic in [result objectForKey:@"users"])
        {
            [array addObject:dic];
        }
    }
    NSLog(@"%@",array);
    self.myBlock(array);
}
-(void)dealloc
{
    [textview release];
    [weiBo release];
    [viewbtn release];
    [l release];
    [fview release];
    [scrollView release];
    [super dealloc];
}

@end
