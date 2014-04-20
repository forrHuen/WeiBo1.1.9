//
//  PersonalCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "PersonalCell.h"
#import "PersonViewController.h"
#import "UIImageView+WebCache.h"
@implementation PersonalCell

-(void)dealloc
{
    [_headImageView release];
    [_userNameLabel release];
    [_abstractLabel release];
    [_btnView release];
    [_microblogBtn release];
    [_microblogNum release];
    [_followerBtn release];
    [_followerNum release];
    [_fansBtn release];
    [_fansNum release];
    [_titleImage release];
    [_titleLabel release];
    [_titleNum release];
    [_vipView release];
    [super dealloc];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCell:(CellType )aType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = aType;
        switch (_cellType) {
                
            //第一种cell
            case firstTypeCell:
            {
               self.headImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(7.5, 7.5, 60, 60)]autorelease];;
                
                self.userNameLabel = [[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
                _userNameLabel.textColor = [UIColor blackColor];
                _userNameLabel.textAlignment = NSTextAlignmentLeft;
                _userNameLabel.font = [UIFont boldSystemFontOfSize:15];
                
                _vipView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                _vipView.image = [UIImage imageNamed:@"personal_isVip"];
                
                self.abstractLabel = [[[UILabel alloc]initWithFrame:CGRectMake(80, 37, 200, 30)]autorelease];
                _abstractLabel.textColor = [UIColor grayColor];
                _abstractLabel.textAlignment = NSTextAlignmentLeft;
                _abstractLabel.font = [UIFont systemFontOfSize:12];
                
                

                
                UIImageView *separateImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 74.5, 306, 0.5)];
                separateImage.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                
                self.frame = CGRectMake(7, 0, 306, 75);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:separateImage];
                [self.contentView addSubview:_headImageView];
                [self.contentView addSubview:_userNameLabel];
                [self.contentView addSubview:_abstractLabel];
            
                [self.contentView addSubview:_vipView];
                
                
            }
                break;
                
            //第二种cell
            case secondTypeCell:
            {
                //微博数
                self.microblogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.microblogBtn.frame = CGRectMake(0, 0, 100, 50);
                [self.microblogBtn setTitleEdgeInsets:UIEdgeInsetsMake(35, 23, 15, 23)];
                [self.microblogBtn setTitleColor:[UIColor grayColor]
                                    forState:0];
                [self.microblogBtn setTitle:@"微博" forState:0];
                self.microblogBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                
                self.microblogNum = [[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 100, 25)]autorelease];
                self.microblogNum.textAlignment = NSTextAlignmentCenter;
                self.microblogNum.textColor = [UIColor blackColor];
                self.microblogNum.font = [UIFont boldSystemFontOfSize:15];

                //关注数
                self.followerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _followerBtn.frame = CGRectMake(100, 0, 103, 50);
                [self.followerBtn setTitleEdgeInsets:UIEdgeInsetsMake(35, 23, 15, 23)];
                [_followerBtn setTitle:@"关注" forState:0];
                [self.followerBtn setTitleColor:[UIColor grayColor] forState:0];
                _followerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                [_followerBtn setTitleColor:[UIColor grayColor] forState:0];
                
                self.followerNum = [[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 103, 25)]autorelease];
                self.followerNum.textAlignment = NSTextAlignmentCenter;
                self.followerNum.textColor = [UIColor blackColor];
                self.followerNum.font = [UIFont boldSystemFontOfSize:15];
                
                UIImageView *separateImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 0.5, 30)];
                separateImage1.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                [self.followerBtn addSubview:separateImage1];
                
                
                //粉丝数
                self.fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _fansBtn.frame = CGRectMake(203, 0, 103, 50);
                [self.fansBtn setTitleEdgeInsets:UIEdgeInsetsMake(35, 23, 15, 23)];
                [_fansBtn setTitle:@"粉丝" forState:0];
                [_fansBtn setTitleColor:[UIColor grayColor] forState:0];
                _fansBtn.titleLabel.font = [UIFont systemFontOfSize:13];
                
                
                self.fansNum = [[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 103, 25)]autorelease];
                self.fansNum.textAlignment = NSTextAlignmentCenter;
                self.fansNum.textColor = [UIColor blackColor];
                self.fansNum.font = [UIFont boldSystemFontOfSize:15];
                
                UIImageView *separateImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 0.5, 30)];
                separateImage2.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                [self.fansBtn addSubview:separateImage2];
                
                self.frame = CGRectMake(0, 0, 306, 50);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.microblogBtn addSubview:self.microblogNum];
                [self.followerBtn addSubview:self.followerNum];
                [self.fansBtn addSubview:self.fansNum];
                [self.contentView addSubview:_fansBtn];
                [self.contentView addSubview:_followerBtn];
                [self.contentView addSubview:_microblogBtn];
            }
                break;
                
            //第三种cell
            case thirdTypeCell:
            {
                self.titleImage = [[[UIImageView alloc]initWithFrame:CGRectMake(7.5,10.5,24,24)]autorelease];
                
                self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(39, 10.5, 100, 24)]autorelease];
                 self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                
                
                
                
                UIImageView *separateImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44.5, 306, 0.5)];
                separateImage.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                self.frame = CGRectMake(0, 0, 306, 45);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:separateImage];
                [self.contentView addSubview:_titleImage];
                [self.contentView addSubview:_titleLabel];
                
            }
                break;
            //第四种cell
            case fourTypeCell:
            {
                self.titleImage = [[[UIImageView alloc]initWithFrame:CGRectMake(7.5,10.5,24,24)]autorelease];
                
                self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(39, 10.5, 60, 24)]autorelease];
                self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                
                self.titleNum = [[UILabel alloc]initWithFrame:CGRectMake(105, 10.5, 50, 24)];
                self.titleNum.textAlignment = NSTextAlignmentLeft;
                self.titleNum.textColor = [UIColor grayColor];
                self.titleNum.text = @"(0)";
                self.titleNum.font = [UIFont systemFontOfSize:13];
                
                
                UIImageView *separateImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44.5, 306, 0.5)];
                separateImage.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
                self.frame = CGRectMake(0, 0, 306, 45);
                self.backgroundColor = [UIColor colorWithRed:252.0/255 green:252.0/255 blue:252.0/255 alpha:1];
                [self.contentView addSubview:separateImage];
                [self.contentView addSubview:_titleNum];
                [self.contentView addSubview:_titleImage];
                [self.contentView addSubview:_titleLabel];
            
            }
                break;
            default:
                break;
        }
       
    }
    return self;
}


//===========请求数据的方法==============
-(void)setDataWithCell:(UserDataModel *)model
{
    //头像，昵称，简介
    [self.headImageView setImageWithURL:[NSURL URLWithString:model.profile_image_url] placeholderImage:[UIImage imageNamed:@"head_null"]];
    
    self.userNameLabel.text = model.screen_name;
    if (model.description.length ==0) {
        self.abstractLabel.text = @"简介:暂无介绍";
    }else
    {
    self.abstractLabel.text = [NSString stringWithFormat:@"简介:%@",model.description];
    }
    
    //微博，关注，粉丝数
    self.microblogNum.text = [model.statuses_count stringValue];
    self.fansNum.text = [model.followers_count stringValue];
    self.followerNum.text = [model.friends_count stringValue];
    
    
}
//==============计算数据Size==================
-(void)setSizeWithCell:(UserDataModel *)modelSize
{
    CGSize userNameSize = [modelSize.screen_name sizeWithFont:self.userNameLabel.font constrainedToSize:CGSizeMake(self.userNameLabel.frame.size.width, 30) lineBreakMode:NSLineBreakByCharWrapping];
    self.userNameLabel.frame = CGRectMake(80, 7, userNameSize.width, 30);
    self.vipView.frame = CGRectMake(userNameSize.width+87, 15, 14, 14);
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
