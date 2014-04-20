//
//  EditViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"
#import "UserDataModel.h"
@interface EditViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
}
@property(nonatomic,retain)UITableView *editTable;
@property(nonatomic,retain)UserDataModel *userData;
@end
