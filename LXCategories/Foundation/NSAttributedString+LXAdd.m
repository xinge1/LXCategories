//
//  NSAttributedString+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/26.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "NSAttributedString+LXAdd.h"
#import <CoreText/CoreText.h>
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(NSAttributedString_LXAdd)
@implementation NSAttributedString (LXAdd)

- (CGFloat)lx_heightWithContainWidth:(CGFloat)width
{
    int total_height = 0;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    if(linesArray.count == 0)return 0;
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    int line_y = (int) origins[[linesArray count] -1].y;
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;
    CFRelease(textFrame);
    return total_height;
}


@end
