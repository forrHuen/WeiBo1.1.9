//
//  PrivateLetterViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "PrivateLetterViewController.h"

@interface PrivateLetterViewController ()

@end

@implementation PrivateLetterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"联系人";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:@"更新" style:UIBarButtonItemStyleDone target:self action:@selector(reloadData)]autorelease];
}

- (void)reloadData
{
    
}

@end
