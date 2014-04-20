//
//  BaseTableViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "SinaWeibo.h"
#import "DataModel.h"
typedef void(^DataBlock) (NSMutableArray *);
@interface BaseTableViewController : UITableViewController<SinaWeiboRequestDelegate>
{
    UIImage *rowImage;
    SinaWeibo *weiBo;
    
}
@property(copy,nonatomic)DataBlock myBlock;
-(SinaWeibo *)getSinaWB;
-(void)getDataArrayandURL:(NSString *)URL andDictionary:(NSMutableDictionary*)params andMethod:(NSString *)hethod;
@property(nonatomic,retain)UIImage *rowImage;
@end
