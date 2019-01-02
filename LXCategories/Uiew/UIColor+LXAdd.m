//
//  UIColor+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "UIColor+LXAdd.h"
#import "NSString+LXCommon.h"
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(UIColor_LXAdd)
@implementation UIColor (LXAdd)

/** 随机颜色 */
+ (instancetype)lx_randomColor {
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - 创建颜色对象（16进制的RGB值）
+ (UIColor *)lx_colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

#pragma mark - 创建颜色对象（16进制的RGB值 + 不透明度值）
+ (UIColor *)lx_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

#pragma mark - 创建颜色对象（颜色的16进制字符串值）
// 有效格式：#RRGGBB、#RGB、#RRGGBBAA、#RGBA、0xRGB、RRGGBB ...（"#"和"0x"前缀可以省略不写）
+ (instancetype)lx_colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (lx_hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

static BOOL lx_hexStrToRGBA(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str lx_stringByTrim] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    // RGB, RGBA, RRGGBB, RRGGBBAA
    if (length < 5) {
        *r = lx_hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = lx_hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = lx_hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = lx_hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = lx_hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = lx_hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = lx_hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = lx_hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static inline NSUInteger lx_hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

+ (UIColor *)lx_gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(CGFloat)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}


@end
