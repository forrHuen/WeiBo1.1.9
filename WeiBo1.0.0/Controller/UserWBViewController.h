//
//  UserWBViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserWBViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *UserWBSource;
}
@property(nonatomic,retain)UITableView *UserWBTable;
@end
