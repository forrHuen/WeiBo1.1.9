//
//  EditCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum cellType
{
    firstTypeCell,
    secondTypeCell
}CellType;
@interface EditCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headImage;
@property(nonatomic,retain)UILabel *infoLabel;
@property(nonatomic,retain)UILabel *userInfoLabel;
@property(nonatomic,retain)UIImageView *separateImage;

@property(nonatomic,assign)CellType cellType;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier typeCell:(CellType)aType;
@end
