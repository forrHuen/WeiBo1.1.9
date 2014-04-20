//
//  HTMLViewController.h
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "BaseViewController.h"

@interface HTMLViewController : BaseViewController<UIWebViewDelegate>
@property(retain,nonatomic)UIWebView *web;
@property(retain,nonatomic)NSString *webURL;
@end
