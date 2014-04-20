//
//  CommentCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
@implementation CommentCell
-(void)dealloc
{
    [_myBgView release];
  
    [_userImageView release];
    [_nameLabel release];
    [_timeLabel release];
    [_replyText release];
    [_collectBtn release];
    
    [_commentsData release];
    [_repostData release];
    [super dealloc];
    
}
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.myBgView = [[[UIView alloc]initWithFrame:CGRectZero]autorelease];
        [self.contentView addSubview:self.myBgView];
        
        self.userImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
        [self.myBgView addSubview:self.userImageView];
        
        self.nameLabel = [[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self.myBgView addSubview:self.nameLabel];
        
        self.timeLabel = [[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
        self.timeLabel.font = [UIFont systemFontOfSize:9];
        [self.myBgView addSubview:self.timeLabel];
        
        self.replyText = [[[TQRichTextView alloc]initWithFrame:CGRectZero]autorelease];
        self.replyText.font = [UIFont systemFontOfSize:15];
        self.replyText.backgroundColor=[UIColor clearColor];
        [self.myBgView addSubview:self.replyText];
        
        self.collectBtn = [[[UIButton alloc]initWithFrame:CGRectZero]autorelease];
        [self.myBgView addSubview:self.collectBtn];
        [self.collectBtn addTarget:self action:@selector(replayClickAction:) forControlEvents:7];
        //交互
        self.userInteractionEnabled = YES;
        self.myBgView.userInteractionEnabled = YES;
        self.userImageView.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personTapAction:)];
        [self.userImageView addGestureRecognizer:tap1];
        [tap1 release];
       
    }
    return self;
}

-(void)setCellData:(CommentsData *)commentsModel
{
    [self.userImageView setImageWithURL:[NSURL URLWithString:commentsModel.headImage] placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.nameLabel.text = commentsModel.name;
    self.replyText.text = [TQURLString URLStr:commentsModel.text];
    self.timeLabel.text = commentsModel.timer;
}
-(void)setCellHeight:(CommentsData *)commentsModel
{
    
    /////////////////////////////头部////////////////////////////

    self.userImageView.frame = CGRectMake(7, 7, 34, 34);
    
    self.nameLabel.frame = CGRectMake(34+14,7,100, 17);
    self.collectBtn.frame = CGRectMake(SCREEN_WIDTH-14-34-5,7, 34,20);
    
    //
    CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(240, 9999) font:[UIFont systemFontOfSize:15] string:[TQURLString URLStr:commentsModel.text] lineSpace:1.0f];
    NSLog(@"%f",rect.size.height);
    self.replyText.frame = CGRectMake(34+16,28,240,rect.size.height);
    self.timeLabel.frame = CGRectMake(34+16, rect.size.height+30, 150, 13);
    self.myBgView.frame = CGRectMake(7, 0, 306, rect.size.height+50);
    self.frame = CGRectMake(0, 0, 320, rect.size.height+55);
}
#pragma mark -回复按钮事件-
-(void)replayClickAction:(UIButton *)sender
{
    DLog(@"回复按钮");
}
-(void)personTapAction:(UITapGestureRecognizer *)sender
{
    DLog(@"头像");
}
#pragma mark -TQRichTextView代理方法-
-(void)richTextView:(TQRichTextView *)view
{
//    CommentsData *d=self.commentsData;
//    self.myBlock(d);
}
- (void)richTextView:(TQRichTextView *)view touchBeginRun:(TQRichTextRun *)run
{
    
}
- (void)richTextView:(TQRichTextView *)view touchEndRun:(TQRichTextRun *)run
{
    if ([run isKindOfClass:[TQRichTextRunURL class]])
    {
        if ([run.text characterAtIndex:0]=='@')
        {
//            self.personBlock(self.data);
        }
        else if([run.text characterAtIndex:0]=='#')
        {
            NSLog(@"话题=%@",run.text);
        }
        else
        {
            NSLog(@"%@",run.text);
        }
    }
    else
    {
        NSString *str=[NSMutableString string];
        NSRange r1={1,run.text.length-2};
        str=[run.text substringWithRange:r1];
        NSLog(@"%@",run.text);
        NSLog(@"%@",str);
//        self.myHttpBlock(str);
    }
}
-(void)richTextView:(TQRichTextView *)view touchCanceledRun:(TQRichTextRun *)run{
    
}

@end
