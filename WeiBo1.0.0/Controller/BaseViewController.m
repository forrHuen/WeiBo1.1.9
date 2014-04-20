//
//  BaseViewController.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@implementation BaseViewController

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
    NSMutableArray *arr=[NSMutableArray array];
    NSArray *a=[result allKeys];
    if ([a containsObject:@"comments"])
    {
        for (int i=0;i<[[result objectForKey:@"comments"]count]; i++)
        {
            [arr addObject:[[result objectForKey:@"comments"] objectAtIndex:i]];
        }
    }
    else if([a containsObject:@"statuses"])
    {
        for (int i=0;i<[[result objectForKey:@"statuses"]count]; i++)
        {
            //数组装有n条微博
            [arr addObject:[[result objectForKey:@"statuses"] objectAtIndex:i]];
        }
    }
    else
    {
        [arr addObject:result];
    }
    self.myBlock(arr);
}
@end
