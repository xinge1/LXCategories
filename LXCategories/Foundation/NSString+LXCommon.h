//
//  NSString+LXCommon.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LXCommon)

/** 过滤HTML标签 */
+ (NSString *)lx_removeStringIntheHTML:(NSString *)html;

/** 随机验证码字符串 */
+ (NSString *)lx_randomString:(double)number;

/** 判断用户输入是否含有emoji表情 */
+ (BOOL)lx_stringContainsEmoji:(NSString *)string;

/** 过滤emoji表情 */
+ (NSString *)lx_removeStringIntheEmoji:(NSString *)string;

/** 查看当前版本号 */
+ (NSString *)lx_getAppVersion;

/** 获取App的build版本 */
+ (NSString *)lx_getAppBuildVersion;

/** 获取App名称 */
+ (NSString *)lx_getAppName;

/** UIimage装base64的字符串 */
+ (NSString*)lx_UIImageToBase64Str:(UIImage*)image;

/**
 *  返回一个新的UUID字符串（随机字符串，每次获取都不一样）
 *  如："3FE15217-D71E-4B4F-9919-B388A8D13914"
 */
+ (NSString *)lx_UUID;

/** 转UTF8字符串（UTF-8编码）*/
- (NSString *)lx_utf8String;

/** 通过身份证获取性别（1:男, 2:女） */
- (nullable NSNumber *)lx_getGenderFromIDCard;

/** 隐藏证件号指定位数字（如：360723********6341） */
- (nullable NSString *)lx_hideCharacters:(NSUInteger)location length:(NSUInteger)length;

#pragma mark - 修剪字符串（去掉头尾两边的空格和换行符）
- (NSString *)lx_stringByTrim;
/**
 去除多余的0
 */
-(NSString *)lx_removeFloatAllZero:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
