//
//  Data.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(retain,nonatomic)NSString *name;//用户昵称
@property(retain,nonatomic)NSString *HeadImage;//头像
@property(retain,nonatomic)NSString *text;//正文
@property(retain,nonatomic)NSMutableArray *Images;//微博配图地址。多图时返回多图链接。无配图返回“[]”
@property(retain,nonatomic)NSMutableArray *original_pic;//原始图片数组

@property(retain,nonatomic)NSString *created_at;//创建时间
@property(retain,nonatomic)NSString *source;//来自
@property(retain,nonatomic)NSNumber *reposts_count;//转发数
@property(retain,nonatomic)NSNumber *comments_count;//评论数
@property(retain,nonatomic)NSNumber *attitudes_count;//点赞数
@property(retain,nonatomic)NSNumber *Wid;//微博id
@property(retain,nonatomic)NSNumber *Uid;//用户id
////////////////////原微博信息//////////////////////
@property(retain,nonatomic)NSNumber *retweeted_Uid;//原作者的id
@property(retain,nonatomic)NSString *retweeted_name;//原作者
@property(retain,nonatomic)NSString *retweeted_text;//转发微博的正文
@property(retain,nonatomic)NSString *retweeted_headImage;



@property(retain,nonatomic)NSMutableDictionary *fourTypeDic;//是否加V,达人,转发,图片4种状态

-(id)initWithDictionary:(NSDictionary *)status;
@end
