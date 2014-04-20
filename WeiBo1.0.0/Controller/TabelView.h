//
//  TabelView.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-10.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TabelView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
}
@end
