//
//  SetUserViewController.h
//  WeiBo1.0.0
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "UserPhotoViewController.h"
#import "UserMainViewController.h"
#import "BaseViewController.h"
#import "UserDataModel.h"
#import "PersonViewController.h"
@interface SetUserViewController :BaseViewController <UIScrollViewDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataSource;
    CGFloat separateX;
}
@property(nonatomic,retain)UITableView *userTable;
@property(nonatomic,retain)UIImageView *userImageView;
@property(nonatomic,retain)UIScrollView * userScrollView;

@property(nonatomic,retain)UIImageView *userHead;
@property(nonatomic,retain)UILabel *userName;
@property(nonatomic,retain)UILabel *followerLabel;
@property(nonatomic,retain)UILabel *fansLabel;
@property(nonatomic,retain)UILabel *briefLabel;

@property(nonatomic,retain)UIView *userView;
@property(nonatomic,retain)UIImageView *footSeparate;
@property(nonatomic,retain)UIImageView *topSeparate;
@property(nonatomic,retain)UIButton *leftBtn;
@property(nonatomic,retain)UIButton *rightBtn;
@property(nonatomic,retain)UIImageView *moveTopView;

@property(nonatomic,retain)UIScrollView *showScrollView;
@property(nonatomic,retain)DataModel *myData;
@property(nonatomic,retain)UserDataModel *UserData;
@property(nonatomic,retain)UserPhotoViewController *userPhotoViewController;
@property(nonatomic,retain)UserMainViewController *userMainViewController;
@end
