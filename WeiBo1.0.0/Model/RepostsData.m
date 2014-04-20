//
//  repostsData.m
//  WeiBo1.0.0
//
//  Created by 3004 on 14-4-17.
//  Copyright (c) 2014年 iBokanWisdom. All rights reserved.
//

#import "RepostsData.h"

@implementation RepostsData
-(id)initWithDictionary:(NSDictionary *)comments
{
    if (self=[super init])
    {
        
        self.Wid=[comments objectForKey:@"id"];
        self.text=[comments objectForKey:@"text"];
        if (self.text.length == 0)
        {
            self.text = @"转发微博";
        }
        self.name=[[comments objectForKey:@"user"] objectForKey:@"name"];
        self.headImage=[[comments objectForKey:@"user"]objectForKey:@"profile_image_url"];
        NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[comments objectForKey:@"source"]];
        [str deleteCharactersInRange:[str rangeOfString:@"</a>"]];
        [str deleteCharactersInRange:NSMakeRange(0,[str rangeOfString:@">"].location+1)];
        self.source=[NSString stringWithFormat:@"来自：%@",str];
        self.timer=[self getTimer:comments];
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
@end
