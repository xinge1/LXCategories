//
//  NSString+LXSize.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "NSString+LXSize.h"
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(NSString_LXSize)
@implementation NSString (LXSize)

#pragma mark - 获取文本的大小
- (CGSize)br_getTextSize:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)lineBreakMode {
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    attributes[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    // 计算文本的的rect
    CGRect rect = [self boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

#pragma mark - 获取文本的宽度
- (CGFloat)br_getTextWidth:(UIFont *)font height:(CGFloat)height {
    CGSize size = [self br_getTextSize:font maxSize:CGSizeMake(MAXFLOAT, height) mode:NSLineBreakByWordWrapping];
    return size.width;
}

#pragma mark - 获取文本的高度
- (CGFloat)br_getTextHeight:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self br_getTextSize:font maxSize:CGSizeMake(width, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    return size.height;
}


@end
