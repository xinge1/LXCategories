//
//  NSString+Verify.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Verify)

///==================================================
///             正则表达式
///==================================================
/** 判断是否是有效的(非空/非空白)字符串 */
- (BOOL)lx_isValidString;

/** 修剪字符串（去掉头尾两边的空格和换行符）*/
- (NSString *)lx_stringByTrim;

/** 判断是否是有效的手机号 */
- (BOOL)lx_isValidPhoneNumber;

/** 判断是否是有效的用户密码 */
- (BOOL)lx_isValidPassword;

/** 判断是否是有效的用户名（20位的中文或英文）*/
- (BOOL)lx_isValidUserName;

/** 判断是否是有效的邮箱 */
- (BOOL)lx_isValidEmail;

/** 判断是否是有效的URL */
- (BOOL)lx_isValidUrl;

/** 判断是否是有效的银行卡号 */
- (BOOL)lx_isValidBankNumber;

/** 判断是否是有效的身份证号 */
- (BOOL)lx_isValidIDCardNumber;

/** 判断是否是有效的IP地址 */
- (BOOL)lx_isValidIPAddress;

/** 判断是否是纯汉字 */
- (BOOL)lx_isValidChinese;

/** 判断是否是邮政编码 */
- (BOOL)lx_isValidPostalcode;

/** 判断是否是工商税号 */
- (BOOL)lx_isValidTaxNo;

/** 判断是否是车牌号 */
- (BOOL)lx_isCarNumber;

/** 匹配英文字母 */
- (BOOL)lx_isLetter;

/** 匹配大写英文字母 */
- (BOOL)lx_isCapitalLetter;

/** 匹配小写英文字母 */
- (BOOL)lx_isSmallLetter;

/** 匹配数字+英文字母 */
- (BOOL)lx_isLetterAndNumbers;

/** 匹配中文，英文字母和数字及_ */
- (BOOL)lx_isChineseAndLetterAndNumberAndBelowLine;

/** 匹配中文，英文字母和数字及_ 并限制字数 */
- (BOOL)lx_isChineseAndLetterAndNumberAndBelowLine4to10;

/** 匹配含有汉字、数字、字母、下划线不能以下划线开头和结尾 */
- (BOOL)lx_isChineseAndLetterAndNumberAndBelowLineNotFirstOrLast;

/** 是否含有汉字 */
- (BOOL)lx_containsChineseCharacter;

@end

NS_ASSUME_NONNULL_END
