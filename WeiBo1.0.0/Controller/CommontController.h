//
//  AViewController.h
//  WeiBo1.0.0
//
//  Created by 梁康乐 on 14-4-13.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
@interface CommontController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *dataSource;
    EGORefreshTableHeaderView *refreshView;
    BOOL isLoading;
}
@property(nonatomic,retain)UITableView *homeTableView;
@end
