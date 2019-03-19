//
//  UIColor+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef UIColorHex
#define UIColorHex(_hex_) [UIColor br_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

typedef enum  {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftTolowRight = 2,//左上到右下
    GradientTypeUprightTolowLeft = 3,//右上到左下
}GradientType;

@interface UIColor (LXAdd)

/** 随机颜色 */
+ (instancetype)lx_randomColor;

/**
 *  创建颜色对象
 *
 *  @param rgbValue  16进制的RGB值（如：0x66ccff）
 *
 *  @return 颜色对象
 */
+ (UIColor *)lx_colorWithRGB:(uint32_t)rgbValue;

/**
 *  创建颜色对象
 *
 *  @param rgbValue  16进制的RGB值（如：0x66ccff）
 *  @param alpha     不透明度值（值范围：0.0 ~ 1.0）
 *
 *  @return 颜色对象
 */
+ (UIColor *)lx_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 *  创建颜色对象
 *
 *  @param hexStr  颜色的16进制字符串值（格式如：@"#66ccff", @"#6cf", @"#66ccff88", @"#6cf8", @"0x66ccff", @"66ccff"...）
 *
 *  @return 颜色对象
 */
+ (nullable UIColor *)lx_colorWithHexString:(NSString *)hexStr;

/**
 *  @brief  渐变颜色
 *
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)lx_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;


/**
 获取渐变色

 @param colors 颜色集合
 @param gradientType 渐变方向
 @param frame frame
 @return 渐变颜色
 */
+ (UIColor *)lx_getGradientChangeColorFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
