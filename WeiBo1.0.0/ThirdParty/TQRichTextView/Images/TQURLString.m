//
//  TQURLString.m
//  TQRichTextViewDemo
//
//  Created by 3004 on 14-4-9.
//  Copyright (c) 2014年 fuqiang. All rights reserved.
//

#import "TQURLString.h"

@implementation TQURLString
+(NSString *)URLStr:(NSString*)URL
{
    if (URL.length == 0)
    {
        return @"转发微博";
    }
    NSString *string =[NSMutableString stringWithString: URL];
    NSMutableArray *arr=[NSMutableArray array];
    NSError *error = nil;
    NSString *regulaStr = @"((http[s]{0,1})://[a-zA-Z0-9]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error == nil)
    {
        NSArray *arrayOfAllMatches = [regex matchesInString:string
                                                    options:0
                                                      range:NSMakeRange(0, [string length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            NSString* substringForMatch = [string substringWithRange:match.range];
            [arr addObject:substringForMatch];
        }
        for (int i=0;i<[arr count];i++)
        {
            if ([[arr objectAtIndex:i] length]==0)
            {
                break ;
            }
            NSString *url=[NSString stringWithFormat:@"[%@]",[arr objectAtIndex:i]];
            NSLog(@"%@",url);
            string=[string stringByReplacingOccurrencesOfString:[arr objectAtIndex:i] withString:url];
        }
    }
    NSLog(@"%@",string);
    return string;
}
@end
