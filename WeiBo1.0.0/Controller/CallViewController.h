//
//  CellViewController.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-15.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^StringBlock) (NSString *);
@interface CallViewController : BaseViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabelview;
    UISearchBar *Search;
    UISearchDisplayController *SDC;
    NSMutableArray *array;
    NSArray *Index;
}
@property(retain,nonatomic)NSMutableArray *data;
@property(copy,nonatomic)StringBlock Block;
@end
