//
//  StatusesViewController.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-18.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "StatusesViewController.h"

@interface StatusesViewController ()

@end

@implementation StatusesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loing];
    UIView *viewi=[[UIView alloc]initWithFrame:CGRectMake(0,20,320,64)];
    viewi.backgroundColor=[UIColor grayColor];
    [self.view addSubview:viewi];
    textview.frame=CGRectMake(0,84,SCREEN_WIDTH,180);
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






@end
