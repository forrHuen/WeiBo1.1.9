//
//  TQRichTextRunEmoji.m
//  TQRichTextViewDemo
//
//  Created by fuqiang on 2/28/14.
//  Copyright (c) 2014 fuqiang. All rights reserved.
//

#import "TQRichTextRunEmoji.h"

@implementation TQRichTextRunEmoji

/**
 *  返回表情数组
 */
+ (NSArray *) emojiStringArray
{
    NSString *str =[[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSMutableArray *array=[NSMutableArray array];
    NSArray *arr=[NSArray arrayWithContentsOfFile:str];
    for (int i=0;i<[arr count];i++)
    {
        [array addObject:[[arr objectAtIndex:i] objectForKey:@"cht"]];
    }
    return array;
}

/**
 *  解析字符串中url内容生成Run对象
 *
 *  @param attributedString 内容
 *
 *  @return TQRichTextRunURL对象数组
 */
+ (NSArray *)runsForAttributedString:(NSMutableAttributedString *)attributedString
{
    NSString *markL       = @"[";
    NSString *markR       = @"]";
    NSString *string      = attributedString.string;
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    for (int i = 0; i < string.length; i++)
    {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
//        NSLog(@"%@",s);
        if (([s isEqualToString:markL]) || ((stack.count > 0) && [stack[0] isEqualToString:markL]))
        {
            if (([s isEqualToString:markL]) && ((stack.count > 0) && [stack[0] isEqualToString:markL]))
            {
                [stack removeAllObjects];
            }
            
            [stack addObject:s];
            
            if ([s isEqualToString:markR] || (i == string.length - 1))
            {
                NSMutableString *emojiStr = [[NSMutableString alloc] init];
                for (NSString *c in stack)
                {
                    [emojiStr appendString:c];
                }
                if ([[TQRichTextRunEmoji emojiStringArray] containsObject:emojiStr])
                {
                    
                    NSRange range = NSMakeRange(i + 1 - emojiStr.length, emojiStr.length);
                    
                    [attributedString replaceCharactersInRange:range withString:@" "];
                    TQRichTextRunEmoji *run = [[TQRichTextRunEmoji alloc] init];
                    run.range    = NSMakeRange(i + 1 - emojiStr.length,1);
                    run.text     = emojiStr;
                    run.drawSelf = YES;
                    [run decorateToAttributedString:attributedString range:run.range];
                    i-=emojiStr.length-1;
                    [array addObject:run];
                }
                else if(emojiStr.length>6)
                {
                    if ([[emojiStr substringWithRange:NSMakeRange(1,4)]isEqualToString:@"http"])
                    {
                        NSRange range = NSMakeRange(i + 1 - emojiStr.length, emojiStr.length);
                        
                        [attributedString replaceCharactersInRange:range withString:@"     "];
                        TQRichTextRunEmoji *run = [[TQRichTextRunEmoji alloc] init];
                        run.range    = NSMakeRange(i + 1 - emojiStr.length,5);
                        run.text     = emojiStr;
                        run.drawSelf = YES;
                        [run decorateToAttributedString:attributedString range:run.range];
                        i-=emojiStr.length-5;
                        [array addObject:run];
                    }

                }
            [stack removeAllObjects];
            }
        }
    }
    
    return array;
}

/**
 *  绘制Run内容
 */
- (void)drawRunWithRect:(CGRect)rect
{
    if (self.text.length>6)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSString *emojiString = [NSString stringWithFormat:@"[网络连接].png"];
        UIImage *image = [UIImage imageNamed:emojiString];
        if (image)
        {
            CGContextDrawImage(context, rect, image.CGImage);
        }

    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        NSString *str =[[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
        NSArray *array=[NSArray arrayWithContentsOfFile:str];
        NSString *emojiString = nil;
        for (NSDictionary *d in array)
        {
            if ([[d objectForKey:@"cht"]isEqualToString:self.text])
            {
                emojiString=[d objectForKey:@"gif"];
            }
        }
        UIImage *image = [UIImage imageNamed:emojiString];
        if (image)
        {
            CGContextDrawImage(context, rect, image.CGImage);
        }
    }
}

@end
