//
//  Data.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-8.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
-(id)initWithDictionary:(NSDictionary *)status
{
    NSDictionary *user=[status objectForKey:@"user"];
    NSDictionary *retweeted=[status objectForKey:@"retweeted_status"];
    NSDictionary *retweeted_user=[retweeted objectForKey:@"user"];
    self.fourTypeDic=[NSMutableDictionary dictionary];
    if (self=[super init])
    {
        self.Uid=[user objectForKey:@"id"];
        self.HeadImage=[user objectForKey:@"profile_image_url"];
        self.name=[user objectForKey:@"screen_name"];
        self.text=[status objectForKey:@"text"];
        if ([[retweeted allKeys]count]==0)//非转发
        {
            [self.fourTypeDic setValue:[NSNumber numberWithInt:0] forKey:@"retweeted"];
            if ([[status objectForKey:@"pic_urls"] count]!=0)//有配图
            {
                [self.fourTypeDic setValue:[NSNumber numberWithInt:1] forKey:@"pic"];
                self.Images =[[NSMutableArray alloc]init];
                self.original_pic =[[NSMutableArray alloc]init];
                for (int i=0;i<[[status objectForKey:@"pic_urls"] count];i++)
                {
                    [self.Images addObject:[[[status objectForKey:@"pic_urls"]objectAtIndex:i] objectForKey:@"thumbnail_pic"]];//得到缩略图
                }
                for (int i=0;i<[self.Images count];i++)
                {
                    NSString *URL=[[self.Images objectAtIndex:i]stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];//将缩略图转换为原始图,因为原始图只有1张,因此需要生产多张原始图
                    [self.original_pic addObject:URL];
                }
                
            }
            else
            {
              [self.fourTypeDic setValue:[NSNumber numberWithInt:0] forKey:@"pic"];
            }
           

        }
        else//有转发的时候,原创者微博信息
        {
            [self.fourTypeDic setValue:[NSNumber numberWithInt:1] forKey:@"retweeted"];
            self.retweeted_Uid=[retweeted_user objectForKey:@"id"];
            self.retweeted_name=[retweeted_user objectForKey:@"screen_name"];
            self.retweeted_text=[NSString stringWithFormat:@"@%@:%@",[retweeted_user objectForKey:@"screen_name"],[retweeted objectForKey:@"text"]];
            self.retweeted_headImage = [retweeted_user objectForKey:@"avatar_large"];
            
            if ([[retweeted objectForKey:@"pic_urls"] count]!=0)
            {
                [self.fourTypeDic setValue:[NSNumber numberWithInt:1] forKey:@"pic"];
                self.Images =[[NSMutableArray alloc]init];
                 self.original_pic =[[NSMutableArray alloc]init];
                for (int i=0;i<[[retweeted objectForKey:@"pic_urls"] count];i++)
                {
                    [self.Images addObject:[[[retweeted objectForKey:@"pic_urls"]objectAtIndex:i] objectForKey:@"thumbnail_pic"]];
                }
                for (int i=0;i<[self.Images count];i++)
                {
                    NSString *URL=[[self.Images objectAtIndex:i]stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
                    [self.original_pic addObject:URL];
                }
            }
            else
            {
              [self.fourTypeDic setValue:[NSNumber numberWithInt:0] forKey:@"pic"];
            }
        }
        
        NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[status objectForKey:@"source"]];
      
        [str deleteCharactersInRange:[str rangeOfString:@"</a>"]];
        [str deleteCharactersInRange:NSMakeRange(0,[str rangeOfString:@">"].location+1)];
        self.source=str;
        self.created_at=[self getTimer:status];
        self.Wid=[status objectForKey:@"id"];
        self.reposts_count=[status objectForKey:@"reposts_count"];
        self.comments_count=[status objectForKey:@"comments_count"];
        self.attitudes_count=[status objectForKey:@"attitudes_count"];
        NSNumber *v =[user objectForKey:@"verified"];
        if ([v intValue] == 1)
        {
            [self.fourTypeDic setValue:[NSNumber numberWithInt:1] forKey:@"verified"];
        }
        else
        {
             [self.fourTypeDic setValue:[NSNumber numberWithInt:0] forKey:@"verified"];
        }
    }
    return self;
}
-(NSString *)getTimer:(NSDictionary*)dic
{
    //-----------------------------------------------------------------------------------------------------------------//
    NSDateFormatter *formatter1 =[[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyyMMddHHmmss"];
    NSString *TimerData = [formatter1 stringFromDate:[NSDate date]];
    NSRange nd={0,4};
    NSRange yd={4,4};
    NSRange sd={8,2};
    NSRange md={10,2};
    NSRange ssd={12,2};
    NSString *year=[TimerData substringWithRange:nd];
    
    NSString *month=[TimerData substringWithRange:yd];
    int H=[[TimerData substringWithRange:sd] intValue];
    int m=[[TimerData substringWithRange:md] intValue];
    int s=[[TimerData substringWithRange:ssd]intValue];
    NSInteger second=((H*60+m)*60)+s;
    NSArray *timerArr=[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    NSMutableString *timer=[NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"created_at"]];
    //-----------------------------------------------------------------------------------------------------------------//
    NSRange n={timer.length-4,4};
    NSString *nian=[timer substringWithRange:n];
    //-----------------------------------------------------------------------------------------------------------------//
    NSRange y={4,3};
    NSRange r={8,2};
    NSString *yue=[timer substringWithRange:y];
    for (int i=0;i<[timerArr count];i++)
    {
        if ([yue isEqualToString:[timerArr objectAtIndex:i]])
        {
            yue=[NSString stringWithFormat:@"0%d",i+1];
        }
    }
    NSString *ri=[timer substringWithRange:r];
    NSString *yr=[yue stringByAppendingString:ri];
    //-----------------------------------------------------------------------------------------------------------------//
    NSRange ss={11,8};
    NSString *shi=[timer substringWithRange:ss];
    NSArray *si=[shi componentsSeparatedByString:@":"];
    NSInteger str=(([[si objectAtIndex:0] intValue]*60+[[si objectAtIndex:1] intValue])*60)+[[si objectAtIndex:2] intValue];
    //-----------------------------------------------------------------------------------------------------------------//
    timer=[NSMutableString stringWithFormat:@"%@年%@月%@日%@",nian,yue,ri,shi];
    NSInteger differ=second-str;
    if ([nian isEqualToString:year])
    {
        if ([yr isEqualToString:month])
        {
            if (differ ==0)
            {
                NSString *timerStr=[NSString stringWithFormat:@"1秒前"];
                return timerStr;
            }
            else if (differ<=60)
            {
                NSString *timerStr=[NSString stringWithFormat:@"%d秒前",differ];
                return timerStr;
            }
            else if(differ/60<=60)
            {
                differ=differ/60;
                NSString *timerStr=[NSString stringWithFormat:@"%d分钟前",differ];
                return timerStr;
            }
            else
            {
                differ=(differ/60)/60;
                NSString *timerStr=[NSString stringWithFormat:@"%d小时前",differ];
                return timerStr;
            }
        }
        else
        {
            return timer;
        }
    }
    else
    {
        return timer;
    }
    return nil;
}
-(void)dealloc
{
    [_name release];
    [_HeadImage release];
    [_text release];
    [_Images release];
    [_original_pic release];
    [_created_at release];
    [_source release];
    [_reposts_count release];
    [_comments_count release];
    [_attitudes_count release];
    [_Wid release];
    [_Uid release];
    [_retweeted_Uid release];
    [_retweeted_name release];
    [_retweeted_text release];
    [_fourTypeDic release];
    [super dealloc];
}
@end
