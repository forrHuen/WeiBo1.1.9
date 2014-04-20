//
//  HttpManager.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "HttpManager.h"
#import "AppDelegate.h"
static HttpManager *instance = nil;

@implementation HttpManager

+(HttpManager *)shareInstance
{
    if (!instance)
    {
        instance = [[HttpManager alloc]init];
    }
    return instance;
}

@end
