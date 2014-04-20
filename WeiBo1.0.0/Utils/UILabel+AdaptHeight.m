//
//  UILabel+AdaptHeight.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "UILabel+AdaptHeight.h"

@implementation UILabel (AdaptHeight)

-(CGRect)setContentRect
{
    self.numberOfLines = 0;
        
    return [self.text boundingRectWithSize:CGSizeMake(303, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil];
}

-(CGSize)setContentSize
{
    self.numberOfLines = 0;
    
    return [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(303, 1000) lineBreakMode:NSLineBreakByWordWrapping];
}

//传入参数为文本起始点的坐标 ？
-(void)setFrameWithOriginIOS7:(CGPoint)o
{
    //判断用户当前系统版本
    if (IOS_VERSION>=7.0) {
        CGRect r = [self setContentRect];
        [self setFrame:CGRectMake(o.x, o.y, r.size.width, r.size.height)];
    }
    else{
        CGSize s = [self setContentSize];
        [self setFrame:CGRectMake(o.x, o.y, s.width, s.height)];
    }
}
@end
