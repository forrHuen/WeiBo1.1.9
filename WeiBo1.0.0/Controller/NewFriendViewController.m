//
//  NewFriendViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController ()

@end

@implementation NewFriendViewController

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
    self.title = @"新的好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义BarButtom
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 25, 25);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"returnBack"] forState:0];
    [backBtn setTitleColor:[UIColor orangeColor] forState:0];
    [backBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:backBtn] autorelease];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark =========leftBtnAction======
-(void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
