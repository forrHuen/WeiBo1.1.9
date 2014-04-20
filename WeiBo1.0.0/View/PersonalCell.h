//
//  PersonalCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataModel.h"
typedef enum cellType
{
    firstTypeCell,
    secondTypeCell,
    thirdTypeCell,
    fourTypeCell
}CellType;

@interface PersonalCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headImageView;
@property(nonatomic,retain)UILabel *userNameLabel;
@property(nonatomic,retain)UILabel *abstractLabel;
@property(nonatomic,retain)UIImageView *vipView;

@property(nonatomic,retain)UIView *btnView;
@property(nonatomic,retain)UIButton *microblogBtn;
@property(nonatomic,retain)UIButton *followerBtn;
@property(nonatomic,retain)UIButton *fansBtn;
@property(nonatomic,retain)UILabel *microblogNum;
@property(nonatomic,retain)UILabel *followerNum;
@property(nonatomic,retain)UILabel *fansNum;

@property(nonatomic,retain)UIImageView *titleImage;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *titleNum;

@property(nonatomic,retain)UserDataModel *userModel;
@property(nonatomic,assign)CellType cellType;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCell:(CellType )aType;
-(void)setDataWithCell:(UserDataModel *)model;
-(void)setSizeWithCell:(UserDataModel *)modelSize;
@end
