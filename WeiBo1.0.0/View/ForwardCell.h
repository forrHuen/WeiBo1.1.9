//
//  ForwardCell.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "BaseCell.h"
#import "MiddleView.h"
typedef enum cellType
{
    NonAFAndHasPic = 1,
    NonAFAndNOPic,
    AFAndHasPic,
    AFAndNOPic,
    AFAndHasPic2,
    AFAndNOPic2
}CellType;

typedef void (^MyCommentBlock)(DataModel *);
typedef void (^MyForwardBlock)(DataModel *);
typedef void (^MyPresionBlock)(DataModel *);

@interface ForwardCell : BaseCell<UIActionSheetDelegate>

@property(nonatomic,retain)UIView *myBgView;

////////////////////头///////////////////////////////
@property(nonatomic,retain)UIView *headView;
@property(nonatomic,retain)UIImageView *userImageView;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *fromLabel;
@property(nonatomic,retain)UIButton *collectBtn;


#pragma mark ---------中部-------------------
@property(nonatomic,retain)MiddleView *middleView;



///////////////////底部按钮//////////////////////////////
@property(nonatomic,retain)UIView *footView;
@property(nonatomic,retain)UIButton *forwardBtn;
@property(nonatomic,retain)UIButton *commentBtn;
@property(nonatomic,retain)UIButton *praiseBtn;
///////////////////数据//////////////////////////
@property(nonatomic,retain)DataModel *model;
//---------评论Block---------
@property(nonatomic,copy)MyCommentBlock myCommentCellBlock;
@property(nonatomic,copy)MyForwardBlock myForwardCellBlock;
@property(nonatomic,copy)MyPresionBlock myPresionBlock;
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
            andType:(CellType )cellType
            andImageNumber:(int)number;

-(void)setCountandData:(DataModel *)model
;
-(void)setCellandContentHeightandData:(DataModel *)model
;
@end
