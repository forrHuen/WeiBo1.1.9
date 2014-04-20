//
//  CommentsCell.m
//  WeiBo1.0.0
//
//  Created by 梁康乐 on 14-4-13.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "CommentsCell.h"
#import "UIImageView+WebCache.h"
@implementation CommentsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(5,5,50,50)];
        [self.contentView addSubview:self.headImage];
        self.textview=[[TQRichTextView alloc]initWithFrame:CGRectZero];
        self.textview.lineSpace = 1.0f;
        self.textview.font = [UIFont systemFontOfSize:13.0f];
        self.textview.backgroundColor = [UIColor clearColor];
        self.textview.delegage = self;
        [self.contentView addSubview:self.textview];
        self.postsTextView=[[TQRichTextView alloc]initWithFrame:CGRectZero];
        self.postsTextView=[[TQRichTextView alloc]initWithFrame:CGRectZero];
        self.postsTextView.lineSpace = 1.0f;
        self.postsTextView.font = [UIFont systemFontOfSize:13.0f];
        self.postsTextView.backgroundColor = [UIColor clearColor];
        self.postsTextView.delegage = self;
        [self.contentView addSubview:self.postsTextView];
        self.commentsBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [self.commentsBtn setTitle:@"评论" forState:0];
        [self.commentsBtn addTarget:self action:@selector(comments:) forControlEvents:UIControlEventTouchUpInside];
        self.commentsBtn.frame=CGRectZero;
        [self.contentView addSubview:self.commentsBtn];
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeLabel];
        self.fromLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.fromLabel.font = [UIFont systemFontOfSize:10];
        self.fromLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.fromLabel];
    }
    return self;
}
-(void)setContentData:(CommentsData *)model
{
    [self.headImage setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.textview.text=model.text;
    self.postsTextView.text=model.reply_text;
    self.timeLabel.text =model.timer;
    self.fromLabel.text=[NSString stringWithFormat:@"来自：%@",model.source];
}

-(void)setHeightWithCell:(CommentsData *)model
{
    CGFloat f=5;
    CGRect rect1 = [TQRichTextView boundingRectWithSize:CGSizeMake(220, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.text] lineSpace:1.0f];
    self.textview.frame=CGRectMake(60,f, rect1.size.width, rect1.size.height);
    f+=self.textview.frame.size.height+5;
    CGRect rect2 = [TQRichTextView boundingRectWithSize:CGSizeMake(220, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.reply_text] lineSpace:1.0f];
    self.postsTextView.frame=CGRectMake(60,f, rect2.size.width, rect2.size.height);
    f+=self.postsTextView.frame.size.height+5;
    self.timeLabel.frame=CGRectMake(60,f,80,30);
    self.fromLabel.frame=CGRectMake(self.timeLabel.frame.size.width+60,f,80,30);
    self.commentsBtn.frame=CGRectMake(250, f, 60, 30);
    f+=40;
    self.frame=CGRectMake(0,0,320,f);
}
-(BOOL)comments:(NSString *)Wid
{
    return NO;
}

@end
