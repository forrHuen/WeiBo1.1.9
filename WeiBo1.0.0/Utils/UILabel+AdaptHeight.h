//
//  UILabel+AdaptHeight.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AdaptHeight)
//===============自适应文本高度==============

-(CGRect)setContentRect;//ios7之后的方法,包括ios7.

-(CGSize)setContentSize;//ios7之前用的方法

-(void)setFrameWithOriginAfterIOS7:(CGPoint)o;
@end
