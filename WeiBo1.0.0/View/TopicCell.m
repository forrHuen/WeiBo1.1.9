//
//  topicCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell
-(void)dealloc
{
    [_bgView release];
    [_topicBtn1 release];
    [_topicBtn2 release];
    [_topicBtn3 release];
    [_topicBtn4 release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgView = [[[UIView alloc]initWithFrame:CGRectMake(7,7, 306,100)]autorelease];
       
        [self.contentView addSubview:self.bgView];
        
        self.topicBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.topicBtn1 setTitle:@"#广州房屋倒塌#" forState:0];
        self.topicBtn1.frame = CGRectMake(0, 0, 153, 44);
        [self.bgView addSubview:self.topicBtn1];
        
        self.topicBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.topicBtn2 setTitle:@"#我的闺蜜是逗比#" forState:0];
        self.topicBtn2.frame = CGRectMake(153, 0, 153, 44);
        [self.bgView addSubview:self.topicBtn2];
        
        self.topicBtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.topicBtn3 setTitle:@"#多久换一次床单#" forState:0];
        self.topicBtn3.frame = CGRectMake(0,44, 153, 44);
        [self.bgView addSubview:self.topicBtn3];
        
        self.topicBtn4 = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.topicBtn4 setTitle:@"热门话题" forState:0];
        self.topicBtn4.frame = CGRectMake(153,44, 153, 44);
        [self.bgView addSubview:self.topicBtn4];
    }
    return self;
}


@end
