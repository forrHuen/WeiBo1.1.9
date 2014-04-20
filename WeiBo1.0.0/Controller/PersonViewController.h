//
//  PersonViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UserDataModel.h"
@interface PersonViewController : BaseTableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
    UIButton * navBtn;
}
@property (nonatomic,retain)UITableView *myTable;
@property(nonatomic,retain)UserDataModel *userDataModel;
@end
