//
//  TQRichTextRunURL.h
//  TQRichTextViewDemo
//
//  Created by 3004 on 14-4-9.
//  Copyright (c) 2014年 fuqiang. All rights reserved.
//

#import "TQRichTextRunDelegate.h"

@interface TQRichTextRunURL : TQRichTextRunDelegate
/**
 *  解析字符串中url内容生成Run对象
 *
 *  @param attributedString 内容
 *
 *  @return TQRichTextRunURL对象数组
 */
+ (NSArray *)runsForAttributedString:(NSMutableAttributedString *)attributedString;
@end
