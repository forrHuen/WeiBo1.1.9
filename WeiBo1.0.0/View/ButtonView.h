//
//  ButtonView.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-16.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIView
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)NSArray *labelsArr;
@property(nonatomic,retain)NSArray *imagesArr;
- (id)initWithFrame:(CGRect)frame andTitlesArr:(NSArray *)aTitlesArr
       andImagesArr:(NSArray *)aImagesArr;
@end
