//
//  MyHeader.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//
//---------------------键盘高度--------------------------
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define  keyboardHeight 216-30
#define  facialViewWidth 300
#define facialViewHeight 170

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//----------------------系统----------------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//----------------------授权信息-------------------------
#define kAppKey @"2481313678"
#define kAppSecret @"5f8d7e24747468cbd05df5695268b8f4"
//授权回调页
#define kRedirectURL @"http://api.weibo.com/oauth2/default.html"

//---------------------SinaWeibo------------------------
#define SINA_Name @"AstroBoy1993"

