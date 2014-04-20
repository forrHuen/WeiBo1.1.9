//
//  RemindModel.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel
@synthesize status = _status;
@synthesize follower = _follower;
@synthesize cmt = _cmt;
@synthesize dm = _dm;
-(id)initWithDictionary:(NSDictionary *)Remind
{
    if (self=[super init])
    {
        self.status=[Remind objectForKey:@"status"];
        self.follower=[Remind objectForKey:@"follower"];
        self.cmt=[Remind objectForKey:@"cmt"];
        self.dm=[Remind objectForKey:@"dm"];
    }
    return self;
}
@end
