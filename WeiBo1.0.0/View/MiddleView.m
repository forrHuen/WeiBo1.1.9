//
//  MiddleView.m
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-12.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "MiddleView.h"
#import "UIImageView+WebCache.h"
@interface MiddleView()
{
    UIView *imageBgView;
}
@end

@implementation MiddleView
-(void)dealloc
{
    [_headImageView release];
    [_bodyImageView release];
    [_footImageView release];
    [_postsImageView release];
    [_bgView release];
    [imageBgView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame andType:(FourType )aType andImageNumber:(int)a
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initWithMiddleView:aType andImageNumber:a];
        self.myType = aType;
    }
    return self;
}
-(void)initWithMiddleView:(FourType )aType andImageNumber:(int)a
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(7,0, 306, 0)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    //实现这个第三方的方法
    self.textView = [[TQRichTextView alloc]initWithFrame:CGRectZero];
    self.textView.lineSpace = 1.0f;
    self.textView.font = [UIFont systemFontOfSize:13.0f];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.userInteractionEnabled = YES;
    self.textView.delegage = self;
    
    [self.bgView addSubview:self.textView];
    switch (aType)
    {
        //非转发
        case 1://有图片
        {
            switch (a)
            {
                case 1:
                {
                    self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                    self.postsImageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                    [self.postsImageView addGestureRecognizer:tap];
                    self.postsImageView.userInteractionEnabled=YES;
                    [tap release];
                    [self.bgView addSubview:self.postsImageView];
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
                            [self.bgView addSubview:self.postsImageView];
                            
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
                            self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                            self.postsImageView.contentMode=    UIViewContentModeScaleToFill;
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                            [self.postsImageView addGestureRecognizer:tap];
                            self.postsImageView.userInteractionEnabled=YES;
                            [tap release];
                            self.postsImageView.tag=i*3+j+2000+1;
                            [self.bgView addSubview:self.postsImageView];
                            
                        }
                    }
                }break;
                default:
                    break;
            }
            break;
        }
        case 2://没图片
        {
            //空.......
            break;
        }
        //转发
        case 3://有图片
        {
            self.headImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.headImageView.userInteractionEnabled = YES;
            [self.bgView addSubview:self.headImageView];
            
            self.bodyImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.bodyImageView.userInteractionEnabled = YES;
            self.bodyImageView.backgroundColor = [UIColor whiteColor];
            
            
            [self.bgView addSubview:self.bodyImageView];
            self.postsTextView = [[TQRichTextView alloc]initWithFrame:CGRectZero];
            self.postsTextView.backgroundColor = [UIColor clearColor];
            self.postsTextView.lineSpace = 1.0f;
            self.postsTextView.font = [UIFont systemFontOfSize:13.0f];
            self.postsTextView.delegage = self;
            [self.bodyImageView addSubview:self.postsTextView];
            
            imageBgView = [[UIView alloc]initWithFrame:CGRectZero];
            [self.bodyImageView addSubview:imageBgView];
            imageBgView.backgroundColor = [UIColor whiteColor];
            UITapGestureRecognizer *tap53 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(postsMainBodyAction:)];
            [imageBgView addGestureRecognizer:tap53];
            [tap53 release];
            switch (a)
            {
                case 1:
                {
                    self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                    self.postsImageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                    self.postsImageView.userInteractionEnabled=YES;
                    [self.postsImageView addGestureRecognizer:tap];
                    [tap release];
                    [self.bodyImageView addSubview:self.postsImageView];
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
                            [self.bodyImageView addSubview:self.postsImageView];
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
                            self.postsImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
                            self.postsImageView.contentMode = UIViewContentModeScaleToFill;
                            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
                            [self.postsImageView addGestureRecognizer:tap];
                            self.postsImageView.userInteractionEnabled=YES;
                            [tap release];
                            self.postsImageView.tag=i*3+j+2000+1;
                            [self.bodyImageView addSubview:self.postsImageView];
                            
                        }
                    }
                }break;
                default:
                    break;
            }
            self.footImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.footImageView.userInteractionEnabled = YES;
            [self.bgView addSubview:self.footImageView];
            break;
        }
        case 4://没图片
        {
            self.headImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.headImageView.userInteractionEnabled = YES;
            [self.bgView addSubview:self.headImageView];
            self.bodyImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.bodyImageView.userInteractionEnabled = YES;
            [self.bgView addSubview:self.bodyImageView];
            
            
            self.postsTextView = [[TQRichTextView alloc]initWithFrame:CGRectZero];
            self.postsTextView.backgroundColor = [UIColor clearColor];
            self.postsTextView.lineSpace = 1.0f;
            self.postsTextView.font = [UIFont systemFontOfSize:13.0f];
            self.postsTextView.delegage = self;
            [self.bodyImageView addSubview:self.postsTextView];
            self.footImageView = [[[UIImageView alloc]initWithFrame:CGRectZero]autorelease];
            self.footImageView.userInteractionEnabled = YES;
            [self.bgView addSubview:self.footImageView];
            break;
        }
        default:
            break;
    }
}
-(void)setContentData:(DataModel *)model
{
    switch (self.myType)
    {
            //非转发
        case 1://有图片
        {
          self.textView.text = [TQURLString URLStr:model.text];
            [self loadImages:model];
        }break;
        case 2://没图片
        {
          self.textView.text = [TQURLString URLStr:model.text];
        }break;
        //转发
        case 3://有图片
        {
            self.textView.text = [TQURLString URLStr:model.text];
            self.postsTextView.text = [TQURLString URLStr:model.retweeted_text];
            [self loadpostsImages:model];
            self.headImageView.image = [UIImage imageNamed:@"bubble_head"];
            self.bodyImageView.image = [UIImage imageNamed:@"bubble_body"];
            self.footImageView.image = [UIImage imageNamed:@"bubble_foot"];
        }break;
        case 4://没图片
        {
            self.textView.text = [TQURLString URLStr:model.text];
            self.postsTextView.text = [TQURLString URLStr:model.retweeted_text];
            self.headImageView.image = [UIImage imageNamed:@"bubble_head"];
            self.bodyImageView.image = [UIImage imageNamed:@"bubble_body"];
            self.footImageView.image = [UIImage imageNamed:@"bubble_foot"];
        }break;
        default:break;
    }
}
-(CGFloat )setHeightWithCell:(DataModel *)model
{
    CGFloat _f = 0.0f;
    switch (self.myType)
    {
        //非转发
        case 1://有图片
        {
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(292, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.text] lineSpace:1.0f];
            self.textView.frame = CGRectMake(7,_f,rect.size.width,rect.size.height);
            _f += rect.size.height+13;
            _f = [self handleShowImages:model andHeight:_f];
            self.bgView.frame = CGRectMake(0, 0, 306, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            return _f+7;
            break;
        }
        case 2://没图片
        {
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(292, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.text] lineSpace:1.0f];
            self.textView.frame = CGRectMake(7,_f,rect.size.width,rect.size.height);
            _f += rect.size.height;
            self.bgView.frame = CGRectMake(0, 0, 306, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            return _f;
            break;
        }
        //转发
        case 3://有图片
        {
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(292, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.text] lineSpace:1.0f];
            self.textView.frame = CGRectMake(0,_f,rect.size.width,rect.size.height);
            _f += rect.size.height;
            self.headImageView.frame = CGRectMake(0,_f, 292, 17);
            _f += 17;
            
            
            CGRect rect2 = [TQRichTextView boundingRectWithSize:CGSizeMake(280, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.retweeted_text] lineSpace:1.0f];
            self.postsTextView.frame = CGRectMake(5,0,rect2.size.width,rect2.size.height);
           CGFloat q=[self handleShowpostsImages:model andHeight:rect2.size.height];
            self.bodyImageView.frame = CGRectMake(0,17+self.headImageView.frame.origin.y, 292,q);
            _f+=q;
            self.footImageView.frame = CGRectMake(0,_f, 292, 18);
            _f += 18;
            self.bgView.frame = CGRectMake(7, 0, 292, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            return _f+7;
            break;
        }
        case 4://没图片
        {
            NSString *str=[TQURLString URLStr:model.text];
            CGRect rect = [TQRichTextView boundingRectWithSize:CGSizeMake(292, 9999) font:[UIFont systemFontOfSize:13] string:str lineSpace:1.0f];
            self.textView.frame = CGRectMake(7,_f,rect.size.width,rect.size.height);
            _f += rect.size.height;
            self.headImageView.frame = CGRectMake(7,_f, 292, 17);
            _f += 17;
            CGRect rect2 = [TQRichTextView boundingRectWithSize:CGSizeMake(280, 9999) font:[UIFont systemFontOfSize:13] string:[TQURLString URLStr:model.retweeted_text] lineSpace:1.0f];
            self.postsTextView.frame = CGRectMake(5,0,rect2.size.width,rect2.size.height);
            self.bodyImageView.frame = CGRectMake(7, _f, 292, rect.size.height);
            _f += rect2.size.height;
            self.footImageView.frame = CGRectMake(7,_f, 292, 18);
            _f += 18;
            self.bgView.frame = CGRectMake(0, 0, 292, _f);
            self.frame = CGRectMake(0, 50, 320, _f);
            return _f;
            break;
        }
        default:
            break;
    }
    return _f;
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
                    UIImageView *image=(UIImageView *)[self.bgView viewWithTag:i*2+j+2000+1];
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
                    UIImageView *image=(UIImageView *)[self.bgView viewWithTag:i*3+j+2000+1];
                    [image setImageWithURL:[model.Images objectAtIndex:i*2+j] placeholderImage:[UIImage imageNamed:@"head_null"]];
                }
            }
        }break;
        default:
            break;
    }
    
}
-(void)loadpostsImages:(DataModel *)model
{
    ///////////////////////////////转发多图/////////////////////////////////////////
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
                    UIImageView *image=(UIImageView *)[self.bodyImageView viewWithTag:i*2+j+2000+1];
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
                    UIImageView *image=(UIImageView *)[self.bodyImageView viewWithTag:i*3+j+2000+1];
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
        self.size = size;
        if (size.height>100)//长微博
        {
            self.postsImageView.frame = CGRectMake(7,lf+16,100,100);
            _f +=100+16;
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
                UIImageView *image=(UIImageView *)[self.bgView viewWithTag:i*2+j+2000+1];
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
                UIImageView *image=(UIImageView *)[self.bgView viewWithTag:i*3+j+2000+1];
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
-(CGFloat )handleShowpostsImages:(DataModel *)model
                  andHeight:(CGFloat )_f
{
    CGFloat lf=_f;
    ////////////////////原创图片///////////////////////
    int a=model.Images.count;
    if (a==1)
    {
        _size = self.postsImageView.image.size;
        if (_size.height>100)//长微博
        {
            self.postsImageView.frame = CGRectMake(7,lf+16,100,100);
            _f +=100+16;
            imageBgView.frame = CGRectMake(150,lf+16, 270-150,100);
            return _f;
        }
        self.postsImageView.frame = CGRectMake(7,lf+16,100,100);
        imageBgView.frame = CGRectMake(150,lf+16, 270-150,100);
    }
    else if (a==4)
    {
        for (int i=0;i<2;i++)
        {
            for (int j=0;j<2;j++)
            {
                UIImageView *image=(UIImageView *)[self.bodyImageView viewWithTag:i*2+j+2000+1];
                image.frame=CGRectMake(7+j*80,lf+i*80,75,75);
                imageBgView.frame = CGRectMake((7+j*80)+(270-160)-30,lf, 270-155, 160);
            }
        }
        
    }
    else
    {
        int x;
        for (int i=0;i<3;i++)//控制行
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
                UIImageView *image=(UIImageView *)[self.bodyImageView viewWithTag:i*3+j+2000+1];
                image.frame=CGRectMake(7+j*80,lf+i*80,75,75);
                imageBgView.frame = CGRectMake((7+j*80)+80,lf,270-77*(j+1),75*(i+1)+5);
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
            return _f+=160;
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
#pragma mark -TQRichTextView代理方法-
-(void)richTextView:(TQRichTextView *)view
{
    if (self.myType == 3)
    {
        self.myType = 5;
    }
    else if (self.myType == 4)
    {
        self.myType = 6;
    }
    //跳转到微博正文
    self.myBodyBlock(self.data,self.myType);
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
            self.personBlock(self.data);
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
        self.myHttpBlock(str);
    }
}
-(void)richTextView:(TQRichTextView *)view touchCanceledRun:(TQRichTextRun *)run{

}
#pragma mark -图片点击事件-
-(void)clickImageAction:(UITapGestureRecognizer *)sender
{
    int a = 0;
    BOOL b = 0;
    if (sender.view.tag-2000<0)
    {
        a = 1;
        NSLog(@"_HEIGHT = %f",_size.height);
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
//        NSLog(@"%d",a);
    }
    self.showBlock(self.data.original_pic,a,b,_size.height);
}
//跳转到微博正文
-(void)postsMainBodyAction:(UITapGestureRecognizer *)sender
{
    if (self.myType == 3)
    {
        self.myType = 5;
    }
    else if (self.myType == 4)
    {
        self.myType = 6;
    }
    self.myBodyBlock(self.data,self.myType);
}
@end
