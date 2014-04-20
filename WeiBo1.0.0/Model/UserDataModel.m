//
//  UserDataModel.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel
-(id)initWithDictionary:(NSDictionary *)UserData
{
    if (self=[super init])
    {
        self.Uid=[UserData objectForKey:@"id"]; 	// 	用户UID
        
        self.screen_name=[UserData objectForKey:@"screen_name"]; 	// 	用户昵称
        
        self.location=[UserData objectForKey:@"location"]; 	// 	用户所在地
        
        self.description=[UserData objectForKey:@"description"]; 	// 	用户个人描述
        
        self.profile_image_url=[UserData objectForKey:@"profile_image_url"]; 	// 	用户头像地址（中图），50×50像素
        
        self.gender=[UserData objectForKey:@"gender"]; 	// 	性别，m：男、f：女、n：未知
        
        self.followers_count=[UserData objectForKey:@"followers_count"]; 	// 	粉丝数
        
        self.friends_count=[UserData objectForKey:@"friends_count"]; 	// 	关注数
        
        self.statuses_count=[UserData objectForKey:@"statuses_count"]; 	// 	微博数
        
        self.favourites_count=[UserData objectForKey:@"favourites_count"]; 	// 	收藏数
        
        self.created_at=[UserData objectForKey:@"created_at"]; 	// 	用户创建（注册）时间
        
        self.verified=[UserData objectForKey:@"verified"]; 	// 	是否是微博认证用户，即加V用户，true：是，false：否
        
        self.verified_reason=[UserData objectForKey:@"verified_reason"]; 	// 	认证原因
        
        self.follow_me=[UserData objectForKey:@"follow_me"]; 	// 	该用户是否关注当前登录用户，true：是，false：否
    }
    return self;
}

@end
