//
//  SearchViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


-(void)loadView
{
    self.view = [[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
    UITextField *SearchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 27, SCREEN_WIDTH-80, 35)];
    SearchTextField.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:SearchTextField]autorelease];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backClickAction)];
    [SearchTextField release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)backClickAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
