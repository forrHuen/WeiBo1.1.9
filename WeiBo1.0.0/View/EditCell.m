//
//  EditCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "EditCell.h"

@implementation EditCell
-(void)dealloc
{
    [_headImage release];
    [_infoLabel release];
    [_separateImage release];
    [_userInfoLabel release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeCell:(CellType)aType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = aType;
        switch (_cellType) {
            case firstTypeCell:
                
                
                self.headImage = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)]autorelease];
                self.headImage.image = [UIImage imageNamed:@"head_null"];
                [self.contentView addSubview:self.headImage];
                
                self.userInfoLabel = [[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 80, 20)]autorelease];
                self.userInfoLabel.text = @"修改头像";
                self.userInfoLabel.font = [UIFont systemFontOfSize:14];
                self.userInfoLabel.textAlignment = NSTextAlignmentLeft;
                self.userInfoLabel.textColor = [UIColor blackColor];
                [self.contentView addSubview:self.userInfoLabel];
                
                self.frame = CGRectMake(0, 0, 300, 60);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                break;
            case secondTypeCell:
            {
                self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
                self.infoLabel.font = [UIFont systemFontOfSize:14];
                self.infoLabel.textColor = [UIColor grayColor];
                self.infoLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:self.infoLabel];
                
                self.userInfoLabel = [[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 220, 20)]autorelease];
                self.userInfoLabel.font = [UIFont systemFontOfSize:14];
                self.userInfoLabel.textAlignment = NSTextAlignmentLeft;
                self.userInfoLabel.textColor = [UIColor blackColor];
                [self.contentView addSubview:self.userInfoLabel];
                
                self.separateImage = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, 300, 0.5)]autorelease];
                self.separateImage.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                
                self.frame = CGRectMake(0, 0, 300, 40);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:self.separateImage];
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
