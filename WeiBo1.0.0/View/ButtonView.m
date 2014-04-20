//
//  ButtonView.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-16.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView
-(void)dealloc
{
    [_button release];
    [_imageView release];
    [_label release];
    [_imagesArr release];
    [_labelsArr release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame andTitlesArr:(NSArray *)aTitlesArr
           andImagesArr:(NSArray *)aImagesArr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        for (int i = 0; i< aTitlesArr.count;i++)
        {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button.frame = CGRectMake(0+i*75, 0, 75, 75);
            self.button.tag = 1000+i;
            [self.button addTarget:self action:@selector(btnClickAction:) forControlEvents:7];
            self.button.backgroundColor = [UIColor orangeColor];
            [self addSubview:self.button];
            
            self.imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:[aImagesArr objectAtIndex:i]]]autorelease];
            self.imageView.userInteractionEnabled = YES;
            self.imageView.frame = CGRectMake(15,10,35, 35);
            [self.button addSubview:self.imageView];
            
            self.label = [[[UILabel alloc]initWithFrame:CGRectMake(0,45,75,25)]autorelease];
            self.label.center =  CGPointMake((self.button.bounds.size.width)/2,60);
            
            self.label.text = [aTitlesArr objectAtIndex:i];
            [self.button addSubview:self.label];
        }
    }
    return self;
}
-(void)btnClickAction:(UIButton *)sender
{
    
}
@end
