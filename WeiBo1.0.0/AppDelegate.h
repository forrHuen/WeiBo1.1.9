//
//  AppDelegate.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "TabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    TabBarController *myTabBarController;
}
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SinaWeibo *sinaWB;
@end
