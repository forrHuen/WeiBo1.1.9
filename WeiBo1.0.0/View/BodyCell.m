//
//  BodyCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BodyCell.h"

@implementation BodyCell


-(void)setCellandContentHeightandData:(DataModel *)model
{
    [super setCellandContentHeightandData:model];
    //改变收藏按钮样式
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake( SCREEN_WIDTH-14-75,5,70, 20);
    [self.collectBtn setTitle:@"收藏" forState:0];
    self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.collectBtn.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
    [self.collectBtn setTitleColor:[UIColor grayColor] forState:0];
    [self.collectBtn addTarget:self action:@selector(collectBtnClickAction:) forControlEvents:7];
    [self.headView addSubview:self.collectBtn];
    //隐藏底部按钮
    self.footView.frame = CGRectMake(0,SCREEN_HEIGHT, 0, 0);
    CGRect orgFrame = self.frame;
    self.frame = CGRectMake(orgFrame.origin.x, orgFrame.origin.y-33, orgFrame.size.width, orgFrame.size.height-33);
}
-(void)collectBtnClickAction:(UIButton *)sender
{
    NSLog(@"收藏");
}
@end
