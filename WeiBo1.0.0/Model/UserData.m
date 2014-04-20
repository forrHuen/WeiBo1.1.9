//
//  UserData.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "UserData.h"

@implementation UserData
-(id)initWithDictionary:(NSDictionary *)User
{
    if (self=[super init])
    {
        self.name=[User objectForKey:@"name"];
        self.headImageURL=[User objectForKey:@"profile_image_url"];
    }
    return self;
}
@end
