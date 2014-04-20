//
//  BaseTextViewController.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "DataModel.h"
#import "FacialView.h"
#import "MyHeader.h"
typedef void(^DataBlock) (NSMutableArray *);
@interface BaseTextViewController : UIViewController<SinaWeiboRequestDelegate,UITextViewDelegate,facialViewDelegate>
{
    UITextView *textview;
    SinaWeibo *weiBo;
    UIView *viewbtn;
    UILabel *l;
    UIScrollView *scrollView;//表情滚动视图
    FacialView *fview;
}
@property(assign,nonatomic)BOOL E;
@property(assign,nonatomic)BOOL Y;
@property(copy,nonatomic)DataBlock myBlock;
-(SinaWeibo *)getSinaWB;
-(void)getDataArrayandURL:(NSString *)URL andDictionary:(NSMutableDictionary*)params andMethod:(NSString *)hethod;
@end
