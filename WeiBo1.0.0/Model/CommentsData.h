//
//  CommentsData.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-11.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsData : NSObject

@property(retain,nonatomic)NSString *name;
@property(retain,nonatomic)NSString *text;
@property(retain,nonatomic)NSString *headImage;
@property(retain,nonatomic)NSString *timer;
@property(retain,nonatomic)NSNumber *Wid;
@property(retain,nonatomic)NSString *source;
@property(retain,nonatomic)NSString *reply_text;
-(id)initWithDictionary:(NSDictionary *)comments;
@end
