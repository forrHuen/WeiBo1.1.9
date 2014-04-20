//
//  HttpManager.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <Foundation/Foundation.h>
/*单例,解析数据*/
@interface HttpManager : NSObject
+(HttpManager *)shareInstance;
@end
