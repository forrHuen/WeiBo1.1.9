//
//  SetCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell
-(void)dealloc
{
    [_titleLabel release];
    [_rightImage release];
    [super dealloc];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier CellTypeCell:(CellType)aType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = aType;
        
        switch (_cellType) {
            case firstTypeCell:
            {
                self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 10, 100, 22.5)];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                self.titleLabel.textColor = [UIColor blackColor];
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                
                self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(275, 32.5/2, 10, 10)];
                
                UIImageView *separateImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 42, 300, 0.5)];
                separateImage.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                
                self.frame = CGRectMake(0, 0, 300, 42.5);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:separateImage];
                [self.contentView addSubview:self.rightImage];
                [self.contentView addSubview:self.titleLabel];
            
            
            }
                break;
            case secondTypeCell:
            {
                self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12.5, 10, 100, 22.5)];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                self.titleLabel.textColor = [UIColor blackColor];
                self.titleLabel.textAlignment = NSTextAlignmentLeft;
                
                self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(255, 23.5/2, 35, 19)];
                
                self.frame = CGRectMake(0, 0, 300, 42.5);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:self.rightImage];
                [self.contentView addSubview:self.titleLabel];
            
            }
                break;
            case thirdTypeCell:
            {
                
                self.rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, 302, 44)];
                self.rightImage.layer.cornerRadius = 30;
                
                
                self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 100, 22.5)];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                self.titleLabel.textColor = [UIColor whiteColor];
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
                
                
                self.frame = CGRectMake(0, 0, 300, 42.5);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:self.rightImage];
                [self.contentView addSubview:self.titleLabel];
            }
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
