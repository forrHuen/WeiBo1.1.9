//
//  TQRichTextRunURL.m
//  TQRichTextViewDemo
//
//  Created by 3004 on 14-4-9.
//  Copyright (c) 2014年 fuqiang. All rights reserved.
//

#import "TQRichTextRunURL.h"

@implementation TQRichTextRunURL
/**
 *  向字符串中添加相关Run类型属性
 */
- (void)decorateToAttributedStringURL:(NSMutableAttributedString *)attributedString range:(NSRange)range
{
    [super decorateToAttributedStringURL:attributedString range:range];
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:range];
}
- (void)decorateToAttributedStringCell:(NSMutableAttributedString *)attributedString range:(NSRange)range
{
    [super decorateToAttributedStringCell:attributedString range:range];
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor greenColor].CGColor range:range];
}
- (void)decorateToAttributedStringTopic:(NSMutableAttributedString *)attributedString range:(NSRange)range
{
    [super decorateToAttributedStringTopic:attributedString range:range];
    [attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor redColor].CGColor range:range];
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
    NSString *string = attributedString.string;
    NSMutableArray *array = [NSMutableArray array];
    
    NSError *error = nil;;
    NSString *regulaStr = @"(#[^#]+#)|(@[\u4e00-\u9fa5a-zA-Z0-9_-]{2,30})";
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
            TQRichTextRunURL *run = [[TQRichTextRunURL alloc] init];
            run.range    = match.range;
            run.text     = substringForMatch;
            run.drawSelf = NO;
            if ([run.text  characterAtIndex:0]=='#')
            {
                [run decorateToAttributedStringTopic:attributedString range:match.range];
                [array addObject:run ];
            }
            else if([run.text  characterAtIndex:0]=='@')
            {
                [run decorateToAttributedStringCell:attributedString range:match.range];
                [array addObject:run ];
            }
            else
            {
                TQRichTextRunURL *run = [[TQRichTextRunURL alloc] init];
                run.range    = [string rangeOfString:substringForMatch];
                run.text     = @"    ";
                run.drawSelf = YES;
                [run decorateToAttributedString:attributedString range:run.range];
                [array addObject:run ];
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *emojiString = [NSString stringWithFormat:@"ceshi"];
    UIImage *image = [UIImage imageNamed:emojiString];
    if (image)
    {
        CGContextDrawImage(context, rect, image.CGImage);
    }
}

@end
