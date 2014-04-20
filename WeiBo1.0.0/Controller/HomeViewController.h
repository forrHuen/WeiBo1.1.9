//
//  HomeViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-5.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "UIImageView+WebCache.h"
#import "TabelView.h"
#import "ForwardCell.h"

@class TabBarController;

@interface HomeViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *dataSource;
    EGORefreshTableHeaderView *refreshView;
    BOOL isLoading;
    int totalCount;
}
@property(nonatomic,retain)UITableView *homeTableView;
@property(nonatomic,retain)DataModel *myDataModel;
@property(nonatomic,retain)UIScrollView *showScrollView;
@property(nonatomic,retain)TabBarController *tabBarController;
@property(nonatomic,assign)CellType myType;

@end
