//
//  TopicData.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicData : NSObject
@property(retain,nonatomic)NSString *TopicName;
-(id)initWithDictionary:(NSDictionary *)Topic;
@end
