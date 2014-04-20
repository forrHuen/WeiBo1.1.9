//
//  TopicData.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TopicData.h"

@implementation TopicData
-(id)initWithDictionary:(NSDictionary *)Topic
{
    if (self=[super init])
    {
        self.TopicName=[Topic objectForKey:@"name"];
    }
    return self;
}
@end
