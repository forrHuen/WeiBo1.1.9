//
//  TabelView.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-10.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TabelView.h"

@implementation TabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0,-64,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        tab.backgroundColor=[UIColor blackColor];
        tab.alpha = 0.8;
        tab.separatorStyle=UITableViewCellSeparatorStyleNone;
        tab.dataSource=self;
        tab.delegate=self;
        [self addSubview:tab];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellStr=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:CellStr];
    if (!cell)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellStr]autorelease];
    }
    cell.backgroundColor=[UIColor blackColor];
    return cell;
}
@end
