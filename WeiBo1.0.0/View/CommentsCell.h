//
//  CommentsCell.h
//  WeiBo1.0.0
//
//  Created by 梁康乐 on 14-4-13.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"
#import "CommentsData.h"
#import "BaseCell.h"
@interface CommentsCell : BaseCell<TQRichTextViewDelegate>
@property(nonatomic,retain)UIImageView *headImage;
@property(nonatomic,retain)TQRichTextView *textview;
@property(nonatomic,retain)TQRichTextView *postsTextView;
@property(nonatomic,retain)UIButton *commentsBtn;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *fromLabel;
-(void)setContentData:(CommentsData *)model;
-(void)setHeightWithCell:(CommentsData *)model;
@end
