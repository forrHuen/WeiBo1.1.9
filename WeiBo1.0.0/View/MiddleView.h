//
//  MiddleView.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQRichTextView.h"
#import "DataModel.h"

typedef enum fourType
{
    NonAfAndHasPic = 1,
    NonAfAndNOPic,
    AfAndHasPic,
    AfAndNOPic,
    AfAndHasPic2,
    AfAndNOPic2
}FourType;

typedef void(^PersonBlock) (DataModel *);
typedef void(^BodyBlock) (DataModel *,FourType);
typedef void(^HttpBlock) (NSString *);
typedef void (^ShowBlock)(NSArray *,int,BOOL,CGFloat);
@interface MiddleView : UIView<TQRichTextViewDelegate>
@property(nonatomic,retain)UIView *bgView;
@property(nonatomic,retain)TQRichTextView *textView;
@property(nonatomic,retain)UIImageView *headImageView;
@property(nonatomic,retain)TQRichTextView *postsTextView;
@property(nonatomic,retain)UIImageView *postsImageView;
@property(nonatomic,retain)UIImageView *bodyImageView;
@property(nonatomic,retain)UIImageView *footImageView;
@property(nonatomic,assign)FourType myType;
///////////////
@property(nonatomic,retain)DataModel *data;
//////////////
@property(nonatomic,copy)BodyBlock myBodyBlock;
@property(nonatomic,copy)HttpBlock myHttpBlock;
@property(nonatomic,copy)PersonBlock personBlock;
@property(nonatomic,copy)ShowBlock showBlock;

@property(nonatomic,assign)CGSize size;
- (id)initWithFrame:(CGRect)frame andType:(FourType )aType andImageNumber:(int)a;
-(void)setContentData:(DataModel *)model;
-(CGFloat)setHeightWithCell:(DataModel *)model;
@end
