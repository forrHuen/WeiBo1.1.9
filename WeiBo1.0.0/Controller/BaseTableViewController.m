//
//  BaseTableViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AppDelegate.h"
@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize rowImage;
-(void)dealloc
{
    [rowImage release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSMutableArray *arr=[NSMutableArray array];
    NSArray *a=[result allKeys];
    if ([a containsObject:@"comments"])
    {
        for (int i=0;i<[[result objectForKey:@"comments"]count]; i++)
        {
            [arr addObject:[[result objectForKey:@"comments"] objectAtIndex:i]];
            
        }
    }
    else if ([a containsObject:@"reposts"])
    {
        for (int i=0;i<[[result objectForKey:@"reposts"]count]; i++)
        {
            [arr addObject:[[result objectForKey:@"reposts"] objectAtIndex:i]];
        }
        
    }
    else
    {
        [arr addObject:result];
    }
    self.myBlock(arr);

}

@end
