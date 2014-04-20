//
//  CommentCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseCell.h"
#import "CommentsData.h"
#import "RepostsData.h"
#import "TQRichTextView.h"

@interface CommentCell : BaseCell<TQRichTextViewDelegate>

@property(nonatomic,retain)UIView *myBgView;
@property(nonatomic,retain)UIImageView *userImageView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UIButton *collectBtn;
@property(nonatomic,retain)TQRichTextView *replyText;

@property(nonatomic,retain)CommentsData *commentsData;
@property(nonatomic,retain)RepostsData *repostData;

-(void)setCellData:(CommentsData *)commentsModel;
-(void)setCellHeight:(CommentsData *)commentsModel;

@end
