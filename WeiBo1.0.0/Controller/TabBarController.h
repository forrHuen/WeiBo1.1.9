//
//  TabBarController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface TabBarController : UITabBarController<SinaWeiboDelegate>
{
    UIView *topView;
    UIView *nextView;
}
@property(nonatomic,retain)UIView *topView;
@property(nonatomic,retain)UIView *nextView;
@property(nonatomic,retain)UIImageView *tabBarImageView;
@end
