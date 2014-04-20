//
//  ForwardCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "ForwardCell.h"
#import "UIImageView+WebCache.h"

@implementation ForwardCell
-(void)dealloc
{
    [_myBgView release];
    [_headView release];
    [_userImageView release];
    [_nameLabel release];
    [_timeLabel release];
    [_fromLabel release];
    [_collectBtn release];
    //
    
    //
    [_footView release];
    [_forwardBtn release];
    [_commentBtn release];
    [_praiseBtn release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
            andType:(CellType )cellType
            andImageNumber:(int)number
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.myBgView = [[[UIView alloc]initWithFrame:CGRectMake(7, 0, 306, 0)]autorelease];
        self.myBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.myBgView];
        
        /////////////////////////////头部////////////////////////////
        self.headView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-14,NavigationBar_HEIGHT+4)]autorelease];
        self.headView.backgroundColor = [UIColor whiteColor];
        self.headView.userInteractionEnabled = YES;
        [self.myBgView addSubview:self.headView];
        
        
        self.userImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 34, 34)]autorelease];
        self.userImageView.userInteractionEnabled = YES;
        [self.headView addSubview:self.userImageView];
        
        self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectMake(55,7,100, 17)]autorelease];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.userInteractionEnabled = YES;
        [self.headView addSubview:_nameLabel];
        
        //添加手势
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalTapAction:)];
        [_userImageView addGestureRecognizer:tap1];
        [tap1 release];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalTapAction:)];
        [_nameLabel addGestureRecognizer:tap2];
        [tap2 release];

        
        
        self.timeLabel = [[[UILabel alloc]initWithFrame:CGRectMake(55,7+14+5, 0, 17)]autorelease];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.headView addSubview:self.timeLabel];
        
        self.fromLabel = [[[UILabel alloc]initWithFrame:CGRectMake(self.timeLabel.frame.size.width+7, self.timeLabel.frame.origin.y, 0, 17)]autorelease];
        self.fromLabel.font = [UIFont systemFontOfSize:10];
         self.fromLabel.textColor = [UIColor grayColor];
        [self.headView addSubview:self.fromLabel];
        
        //收藏
        self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectBtn.frame = CGRectMake( SCREEN_WIDTH-14-34,0, 34, 34);
        [self.collectBtn setImage:[UIImage imageNamed:@"collectBtn"] forState:0];
        [self.collectBtn addTarget:self action:@selector(collectBtnClickAction:) forControlEvents:7];
        [self.headView addSubview:self.collectBtn];
        
        ////////////////////////////中部////////////////////////////////
        self.middleView = [[MiddleView alloc]initWithFrame:CGRectMake(0,50,320, 0) andType:cellType andImageNumber:number];
        self.middleView.userInteractionEnabled=YES;
        [self.myBgView addSubview:self.middleView];

        //底部视图
        self.footView = [[[UIView alloc]initWithFrame:CGRectZero]autorelease];
        self.footView.backgroundColor =[UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
        
        [self.myBgView addSubview:self.footView];
        
        //转发
        self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.forwardBtn.frame = CGRectMake(0, 0.5, 100, 32);
        self.forwardBtn.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
        [self.forwardBtn addTarget:self action:@selector(forwardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.forwardBtn setImage:[UIImage imageNamed:@"forward3"] forState:0];
        [self.forwardBtn setTitle:@"转发" forState:0];
        [self.forwardBtn setFont:[UIFont systemFontOfSize:12]];
        [self.forwardBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.footView addSubview:self.forwardBtn];
        
        //评论
        self.commentBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        self.commentBtn.frame = CGRectMake(100, 0.5, 103, 32);
        [self.commentBtn setTitle:@"评论" forState:0];
        [self.commentBtn setFont:[UIFont systemFontOfSize:12]];
        [self.commentBtn setTitleColor:[UIColor grayColor] forState:0];
        [self.commentBtn addTarget:self action:@selector(commmentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.commentBtn setImage:[UIImage imageNamed:@"comment3"] forState:0];
        
        self.commentBtn.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
        [self.footView addSubview:self.commentBtn];
        
        //赞
        self.praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.praiseBtn setImage:[UIImage imageNamed:@"praise3"] forState:0];
        [self.praiseBtn setTitle:@"赞" forState:0];
        [self.praiseBtn setFont:[UIFont systemFontOfSize:12]];
        [self.praiseBtn setTitleColor:[UIColor grayColor] forState:0];
        self.praiseBtn.frame = CGRectMake(203, 0.5, 103, 32);
        self.praiseBtn.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
        [self.praiseBtn addTarget:self action:@selector(praiseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView addSubview:self.praiseBtn];
        
        
        
        UIView *separate1 = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 0.5, 20)];
        separate1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
        [self.commentBtn addSubview:separate1];
        
        UIView *separate2 = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 0.5, 20)];
        separate2.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
        [self.praiseBtn addSubview:separate2];
        
        
    }
    return self;
}
-(void)setCountandData:(DataModel *)model
{
    [self.userImageView setImageWithURL:[NSURL URLWithString:model.HeadImage]placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.nameLabel.text = model.name;
    
    self.timeLabel.text = model.created_at;
    NSString *str = @"来自";
    if (model.source.length==0)
    {
     self.fromLabel.text = str;
    }
    else
    {
       str = [str stringByAppendingString:model.source];
    }
    self.fromLabel.text = str;
#pragma mark    -中部-
    self.middleView.data=model;
    [self.middleView setContentData:model];
#pragma mark    -底部-
    [self.forwardBtn setImage:[UIImage imageNamed:@"home_forward"] forState:0];
    [self.commentBtn setImage:[UIImage imageNamed:@"home_comment"] forState:0];
    [self.praiseBtn setImage:[UIImage imageNamed:@"home_praise"] forState:0];

}
-(void)setCellandContentHeightandData:(DataModel *)model
{
#pragma mark    -头部-
    CGSize nameSize = [self.nameLabel.text
                       sizeWithFont:self.nameLabel.font
                       constrainedToSize:CGSizeMake(self.nameLabel.frame.size.width,15)
                       lineBreakMode:NSLineBreakByClipping];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y , nameSize.width, nameSize.height);
    
    CGSize timeSize = [self.timeLabel.text sizeWithFont:self.timeLabel.font
                                      constrainedToSize:CGSizeMake(self.timeLabel.frame.size.width,15)
                                          lineBreakMode:NSLineBreakByClipping];
    self.timeLabel.frame = CGRectMake(self.timeLabel.frame.origin.x, self.timeLabel.frame.origin.y, timeSize.width, timeSize.height);
    
    
    CGSize fromSize = [self.fromLabel.text sizeWithFont:self.fromLabel.font
                                      constrainedToSize:CGSizeMake(self.fromLabel.frame.size.width,15)
                                          lineBreakMode:NSLineBreakByClipping];
    self.fromLabel.frame = CGRectMake(55+self.timeLabel.frame.size.width+7, self.fromLabel.frame.origin.y, fromSize.width, fromSize.height);
#pragma mark    -中部-
    CGFloat _f = [self.middleView setHeightWithCell:model];
#pragma mark    -尾部-
    _f  +=8+50;
    self.footView.frame = CGRectMake(0,_f,306,33);
    _f += 33;
    self.myBgView.frame = CGRectMake(7, 7, 306, _f);
    _f += 8;
    self.frame = CGRectMake(0, 0, 320, _f);
    self.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
    
    
    //===================转发数，评论数，赞数=================
    //转发
    if ([model.reposts_count integerValue]==0) {
        [self.forwardBtn setTitle:@" 转发" forState:0];
    }else{
        if ([model.reposts_count integerValue]<10000) {
            [self.forwardBtn setTitle:[NSString stringWithFormat:@" %@",model.reposts_count] forState:0];
        }else
        {
            int num = [model.reposts_count integerValue]/10000;
            [self.forwardBtn setTitle:[NSString stringWithFormat:@" %d万",num] forState:0];
        }
    }
    
    //评论
    if ([model.comments_count integerValue]==0) {
        [self.commentBtn setTitle:@" 评论" forState:0];
    }else{
        if ([model.comments_count integerValue]<10000) {
            [self.commentBtn setTitle:[NSString stringWithFormat:@" %@",model.comments_count] forState:0];
        }else
        {
            int num = [model.comments_count integerValue]/10000;
            [self.commentBtn setTitle:[NSString stringWithFormat:@" %d万",num] forState:0];
        }
    }
    
    //赞
    if ([model.attitudes_count integerValue]==0) {
        [self.praiseBtn setTitle:@" 赞" forState:0];
    }else{
        if ([model.attitudes_count integerValue]<10000) {
            [self.praiseBtn setTitle:[NSString stringWithFormat:@" %@",model.attitudes_count] forState:0];
        }else
        {
            int num = [model.attitudes_count integerValue]/10000;
            [self.praiseBtn setTitle:[NSString stringWithFormat:@" %d万",num] forState:0];
        }
    }

}

#pragma mark =================BtnAction===================
-(void)collectBtnClickAction:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"取消关注",@"屏蔽",@"举报",nil];
    [actionSheet showInView:self.contentView];
    [actionSheet release];
}
-(void)praiseBtnAction:(UIButton *)sender
{
    NSLog(@"赞");
}
-(void)commmentBtnAction:(UIButton *)sender
{
    self.myCommentCellBlock(self.model);
}
-(void)personalTapAction:(UITapGestureRecognizer *)sender{
    if (sender.view == _userImageView) {
       self.myPresionBlock(self.model);
    }else{
        self.myPresionBlock(self.model);
    }
}
#pragma mark actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            
        }break;
        case 1:
        {
            
        }break;
        case 2:
        {
            
        }break;
        case 3:
        {
            
        }break;
        default: break;
    }
}


@end
