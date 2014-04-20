//
//  SetCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum cellType
{
    firstTypeCell,
    secondTypeCell,
    thirdTypeCell

}CellType;
@interface SetCell : UITableViewCell
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UIImageView *rightImage;
@property(nonatomic,assign)CellType cellType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier CellTypeCell:(CellType)aType;
@end
