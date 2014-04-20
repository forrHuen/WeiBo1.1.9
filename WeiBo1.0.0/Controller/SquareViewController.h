//
//  SquareViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"


@interface SquareViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *dataVC;
}
@property(nonatomic,retain)UITableView *tableView;
@end
