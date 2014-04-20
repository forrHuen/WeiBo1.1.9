//
//  UserPhotoViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPhotoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *UserPhotoSource;
}
@property(nonatomic,retain)UITableView *UserPhotoTable;

-(void)initWithSubViewUserPhoto;
-(void)initWithUserPhotoSource;
@end
