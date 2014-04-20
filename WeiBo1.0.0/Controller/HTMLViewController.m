//
//  HTMLViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "HTMLViewController.h"

@interface HTMLViewController ()

@end

@implementation HTMLViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:self.webURL];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    self.web=[[[UIWebView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)]autorelease];
    self.web.userInteractionEnabled=YES;
    [self.web loadRequest:request];
    [self.view addSubview:self.web];
}
@end
