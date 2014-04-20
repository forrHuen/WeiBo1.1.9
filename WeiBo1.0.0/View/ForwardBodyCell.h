//
//  ForwardBodyCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseCell.h"
#import "TQRichTextView.h"
#import "DataModel.h"
#import "MiddleView.h"

typedef void (^MyCommentBlock)(DataModel *);
typedef void (^MyForwardBlock)(DataModel *);
typedef void (^MyPresionBlock)(DataModel *);
typedef void (^ShowBlock)(NSArray *,int,BOOL,CGFloat);

@interface ForwardBodyCell : BaseCell<TQRichTextViewDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)UIView *myBgView;

////////////////////头///////////////////////////////
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UIImageView *userImageView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *fromLabel;
@property(nonatomic,retain)UIButton *collectBtn;

@property(nonatomic,retain)TQRichTextView *textView;
@property(nonatomic,retain)UIImageView *postsImageView;


@property(nonatomic,assign)FourType aType;
@property(nonatomic,assign)int a;
@property(nonatomic,assign)CGSize size;
///////////////////数据//////////////////////////
@property(nonatomic,retain)DataModel *model;
//---------评论Block---------
@property(nonatomic,copy)MyCommentBlock myCommentCellBlock;
@property(nonatomic,copy)MyForwardBlock myForwardCellBlock;
@property(nonatomic,copy)MyPresionBlock myPresionBlock;
@property(nonatomic,copy)ShowBlock showBlock;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
            andType:(FourType )cellType
     andImageNumber:(int)number;

-(void)setCountandData:(DataModel *)model
;
-(void)setCellandContentHeightandData:(DataModel *)model
;
@end
