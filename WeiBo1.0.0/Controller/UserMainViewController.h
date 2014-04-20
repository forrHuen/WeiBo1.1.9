//
//  UserMainViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *UserMainSource;
}
@property(nonatomic,retain)UITableView *UserMainTable;
-(void)initWithSubViewUserMain;
-(void)initWithUserMainData;
@end
