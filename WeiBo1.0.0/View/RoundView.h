//
//  RoundView.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarController.h"
@interface RoundView : UIView

@property(nonatomic,retain)UIButton *roundBtn;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)TabBarController *tabBarController;
- (id)initWithFrame:(CGRect)frame
           andImage:(UIImage *)aImage
           andTitle:(NSString *)aTitle
             andTag:(NSInteger )aTag;
@end
