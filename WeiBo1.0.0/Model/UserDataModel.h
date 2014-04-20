//
//  UserDataModel.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject
@property(retain,nonatomic)NSNumber *Uid; 	// 	用户UID
@property(retain,nonatomic)NSString *screen_name; 	// 	用户昵称
@property(retain,nonatomic)NSString *location; 	// 	用户所在地
@property(retain,nonatomic)NSString *description; 	// 	用户个人描述
@property(retain,nonatomic)NSString *profile_image_url; 	// 	用户头像地址（中图），50×50像素
@property(retain,nonatomic)NSString *gender; 	// 	性别，m：男、f：女、n：未知
@property(retain,nonatomic)NSNumber *followers_count; 	// 	粉丝数
@property(retain,nonatomic)NSNumber *friends_count; 	// 	关注数
@property(retain,nonatomic)NSNumber *statuses_count; 	// 	微博数
@property(retain,nonatomic)NSNumber *favourites_count; 	// 	收藏数
@property(retain,nonatomic)NSString *created_at; 	// 	用户创建（注册）时间
@property(retain,nonatomic)NSNumber *verified; 	// 	是否是微博认证用户，即加V用户，true：是，false：否
@property(retain,nonatomic)NSString *verified_reason; 	// 	认证原因
@property(retain,nonatomic)NSNumber *follow_me; 	// 	该用户是否关注当前登录用户，true：是，false：否

-(id)initWithDictionary:(NSDictionary *)UserData;
@end
