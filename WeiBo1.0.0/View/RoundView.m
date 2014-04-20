//
//  RoundView.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "RoundView.h"
#import "BaseTextViewController.h"
#import "StatusesViewController.h"
@implementation RoundView

-(void)dealloc
{
    [_roundBtn release];
    [_titleLabel release];
    [_tabBarController release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
           andImage:(UIImage *)aImage
           andTitle:(NSString *)aTitle
             andTag:(NSInteger )aTag
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.roundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.roundBtn.frame = CGRectMake(0, 0, aImage.size.width, aImage.size.height);
        [self.roundBtn setImage:aImage forState:0];
         self.roundBtn.layer.cornerRadius = (self.roundBtn.frame.size.width+10)/4;
        self.roundBtn.tag = aTag;
        [self.roundBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:7];
        [self addSubview:self.roundBtn];
       
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(18,self.roundBtn.frame.size.height+12,70, 14)]autorelease];
        self.titleLabel.text = aTitle;
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

-(void)btnClickAction:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1000:
        {
            StatusesViewController *senderController = [[StatusesViewController alloc]init];
            [self.tabBarController presentViewController:senderController animated:YES completion:^{
                
            }];
            [senderController release];
            break;
        }
        case 1001:
        {
            
            break;
        }
        case 1002:
        {
            
            break;
        }
        case 1003:
        {
            
            break;
        }
        case 1004:
        {
            break;
        }
        case 1005:
        {
            UIView *topView = self.tabBarController.topView;
            UIView *nextView = self.tabBarController.nextView;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:1];
            [UIView setAnimationDidStopSelector:@selector(showSecondPage)];
            topView.frame = CGRectMake(-SCREEN_WIDTH,20, SCREEN_WIDTH, SCREEN_HEIGHT);
            nextView.frame = CGRectMake(0,20, SCREEN_WIDTH, SCREEN_HEIGHT);
            nextView.alpha = 0.9;
            [UIView setAnimationDelegate:self];
            [UIView commitAnimations];
            break;
        }
        case 1006:
        {
            
            break;
        }
        case 1007:
        {
            
            break;
        }
        case 1008:
        {
            
            break;
        }
        case 1009:
        {
            
            break;
        }
        default:
            break;
    }
}
-(void)showSecondPage
{
    UIView *nextView = self.tabBarController.nextView;
    NSArray *arr = [nextView subviews];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [[arr objectAtIndex:0] setFrame:CGRectMake(24, 110, 80, 100)];
    [[arr objectAtIndex:1] setFrame:CGRectMake(124, 110, 80, 100)];
    [[arr objectAtIndex:2] setFrame:CGRectMake(224, 110, 80, 100)];
    [[arr objectAtIndex:3] setFrame:CGRectMake(24, 230, 80, 100)];
    [UIView commitAnimations];
}
@end
