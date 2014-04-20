//
//  BaseViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h" 
#import "DataModel.h"
typedef void(^DataBlock) (NSMutableArray *);
@interface BaseViewController : UIViewController<SinaWeiboRequestDelegate>
{
    SinaWeibo *weiBo;
}
@property(copy,nonatomic)DataBlock myBlock;
-(SinaWeibo *)getSinaWB;
-(void)getDataArrayandURL:(NSString *)URL andDictionary:(NSMutableDictionary*)params andMethod:(NSString *)hethod;
@end
