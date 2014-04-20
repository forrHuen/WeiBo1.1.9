//
//  CommentViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-10.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseTextViewController.h"
#import "DataModel.h"
#import "BodyCell.h"
#import "CommentCell.h"
#import "ForwardBodyCell.h"
#import "BaseTableViewController.h"
#import "TabBarController.h"

@interface BodyViewController : BaseTableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
}
@property(nonatomic,retain)UITableView *commentTable;

@property(nonatomic,retain)UIButton *forwardBtn;
@property(nonatomic,retain)UIButton *commentBtn;
@property(nonatomic,retain)UIButton *praiseBtn;

@property(nonatomic,assign)FourType mytype;
@property(nonatomic,retain)DataModel *myDataModel;

@property(nonatomic,retain)UIScrollView *showScrollView;

-(id)initWithType:(FourType )aType;
@end
