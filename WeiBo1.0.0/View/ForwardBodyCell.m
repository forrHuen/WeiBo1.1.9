//
//  ForwardBodyCell.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-19.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "ForwardBodyCell.h"
#import "UIImageView+WebCache.h"

@implementation ForwardBodyCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
            andType:(FourType )cellType
     andImageNumber:(int)number
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.a = number;
        self.aType = cellType;
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
        self.textView = [[TQRichTextView alloc]initWithFrame:CGRectZero];
        self.textView.lineSpace = 1.0f;
        self.textView.font = [UIFont systemFontOfSize:13.0f];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.userInteractionEnabled = YES;
        self.textView.delegage = self;
        
        switch (self.aType)
        {
                //非转发
            case 5://有图片
            {
                switch (_a)
                {
                    case 1:
                    {
                        self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                        self.postsImageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                        [self.postsImageView addGestureRecognizer:tap];
                        self.postsImageView.userInteractionEnabled=YES;
                        [tap release];
                        [self.myBgView addSubview:self.postsImageView];
                    }break;
                        
                    case 4:
                    {
                        for (int i=0;i<2;i++)
                        {
                            for (int j=0;j<2;j++)
                            {
                                self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                                [self.postsImageView addGestureRecognizer:tap];
                                self.postsImageView.userInteractionEnabled=YES;
                                [tap release];
                                self.postsImageView.tag=i*2+j+2000+1;
                                [self.myBgView addSubview:self.postsImageView];
                                
                            }
                        }
                    }break;
                    case 2:
                    case 3:
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                    {
                        int x;
                        for (int i=0;i<3;i++)
                        {
                            if (i==x)
                            {
                                break;
                            }
                            for (int j=0;j<3;j++)
                            {
                                if (i*3+j==_a)
                                {
                                    x=i+1;
                                    break;
                                }
                                self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                                self.postsImageView.contentMode=    UIViewContentModeScaleToFill;
                                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                                [self.postsImageView addGestureRecognizer:tap];
                                self.postsImageView.userInteractionEnabled=YES;
                                [tap release];
                                self.postsImageView.tag=i*3+j+2000+1;
                                [self.myBgView addSubview:self.postsImageView];
                                
                            }
                        }
                    }break;
                    default:
                        break;
                }
                break;
            }
            case 6://没图片
            {
                break;
            }
            default:
                break;
        }
        
        [self.myBgView addSubview:self.textView];
    }
    return self;
}
-(void)setCountandData:(DataModel *)model
{
    self.model=model;
    [self.userImageView setImageWithURL:[NSURL URLWithString:model.retweeted_headImage]placeholderImage:[UIImage imageNamed:@"head_null"]];
    self.nameLabel.text = model.retweeted_name;
    
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
    self.textView.text = model.retweeted_text;
    [self loadImages:model];
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
    CGFloat _f = 50;
    switch (self.aType)
    {
        case 5://有图片
        {
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(285, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.retweeted_text] lineSpace:1.0f];
            self.textView.frame = CGRectMake(14,_f,rect.size.width,rect.size.height);
            _f += rect.size.height+13;
            _f = [self handleShowImages:model andHeight:_f];
            self.myBgView.frame = CGRectMake(0, 0, 306, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            _f += 10;
            break;
        }
        case 6://没图片
        {
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(285, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.retweeted_text] lineSpace:1.0f];
            self.textView.frame = CGRectMake(14,_f,rect.size.width,rect.size.height);
            _f += rect.size.height;
            self.myBgView.frame = CGRectMake(0, 0, 306, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            break;
        }
        default:
            break;
    }
#pragma mark    -尾部-
    self.myBgView.frame = CGRectMake(7, 7, 306, _f);
    _f += 8;
    self.frame = CGRectMake(0, 0, 320, _f);
    self.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1];
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
-(void)forwardBtnAction:(UIButton *)sender
{
    
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

#pragma mark -多图处理-
-(void)loadImages:(DataModel *)model
{
    ///////////////////////////////原创多图/////////////////////////////////////////
    int a=model.Images.count;
    switch (a)
    {
        case 1:
        {
            [self.postsImageView setImageWithURL:[model.Images objectAtIndex:0] placeholderImage:[UIImage imageNamed:@"head_null"]];
        }break;
            
        case 4:
        {
            for (int i=0;i<2;i++)
            {
                for (int j=0;j<2;j++)
                {
                    UIImageView *image=(UIImageView *)[self.myBgView viewWithTag:i*2+j+2000+1];
                    [image setImageWithURL:[model.Images objectAtIndex:i*2+j] placeholderImage:[UIImage imageNamed:@"head_null"]];
                }
            }
        }break;
        case 2:
        case 3:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        {
            int x;
            for (int i=0;i<3;i++)
            {
                if (i==x)
                {
                    break;
                }
                for (int j=0;j<3;j++)
                {
                    if (i*3+j==a)
                    {
                        x=i+1;
                        break;
                    }
                    UIImageView *image=(UIImageView *)[self.myBgView viewWithTag:i*3+j+2000+1];
                    [image setImageWithURL:[model.Images objectAtIndex:i*2+j] placeholderImage:[UIImage imageNamed:@"head_null"]];
                }
            }
        }break;
        default:
            break;
    }
    
}

-(CGFloat )handleShowImages:(DataModel *)model
                  andHeight:(CGFloat )_f
{
    CGFloat lf=_f;
    ////////////////////原创图片///////////////////////
    int a=model.Images.count;
    if (a==1)
    {
        CGSize size = self.postsImageView.image.size;
        if (size.height>100)//长微博
        {
            self.postsImageView.frame = CGRectMake(7,lf,100,100);
            _f +=100+7;
            return _f;
        }
        self.postsImageView.frame = CGRectMake(7,lf,100,100);
    }
    else if (a==4)
    {
        for (int i=0;i<2;i++)
        {
            for (int j=0;j<2;j++)
            {
                UIImageView *image=(UIImageView *)[self.myBgView viewWithTag:i*2+j+2000+1];
                image.frame=CGRectMake(7+j*80,lf+i*80,75,75);
            }
        }
        
    }
    else
    {
        int x;
        for (int i=0;i<3;i++)
        {
            if (i==x+1)
            {
                break;
            }
            for (int j=0;j<3;j++)
            {
                if (i*3+j==a)
                {
                    x=i;
                    break;
                }
                UIImageView *image=(UIImageView *)[self.myBgView viewWithTag:i*3+j+2000+1];
                image.frame=CGRectMake(7+j*80,lf+i*80,75,75);
            }
        }
    }
    switch (a)
    {
        case 1:
        {
            
            _f +=100+13;
            return _f;
            
        }break;
            
        case 4:
        {
            return _f+160;
        }break;
        case 2:
        case 3:
        {
            return _f+=80;
        }break;
        case 5:
        case 6:
        {
            return _f+=160;
        }break;
        case 7:
        case 8:
        case 9:
        {
            return _f+=240;
        }break;
        default:
            break;
    }
    return _f;
}

#pragma mark -图片点击事件-
-(void)clickImageAction:(UITapGestureRecognizer *)sender
{
    int a = 0;
    BOOL b = 0;
    if (sender.view.tag-2000<0)
    {
        a = 1;
        if ( _size.height>_size.width*2+10)//长图
        {
            b = 1;
        }
        else
        {
            b = 0;
        }
    }
    else
    {
        a = sender.view.tag-2000;
        NSLog(@"%d",a);
    }
    self.showBlock(self.model.original_pic,a,b,_size.height);
}

@end
