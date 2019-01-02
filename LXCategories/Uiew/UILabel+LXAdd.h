//
//  UILabel+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//
//  2种方法修改UILabel部分文字颜色大小等属性
//  注意：使用方法一时，设置完属性后必须调用 getLableSizeWithMaxWidth 方法


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LXAdd)

#pragma mark ---方法1：属性---
/**
 *  字间距
 */
@property (nonatomic,assign)CGFloat characterSpace;

/**
 *  行间距
 */
@property (nonatomic,assign)CGFloat lineSpace;

/**
 *  关键字
 */
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,strong)UIFont *keywordsFont;
@property (nonatomic,strong)UIColor *keywordsColor;

/**
 *  下划线
 */
@property (nonatomic,copy)NSString *underlineStr;
@property (nonatomic,strong)UIColor *underlineColor;

/**
 *  中线
 */
@property (nonatomic,copy)NSString *middlelineStr;
@property (nonatomic,strong)UIColor *middlelineColor;

/**
 *  计算label宽高，必须调用
 *
 *  @param maxWidth 最大宽度
 *
 *  @return label的size
 */
- (CGSize)getLableSizeWithMaxWidth:(CGFloat)maxWidth;


/**
 计算lab的宽/高
 
 @param size lab的size 计算高度（w,0）;计算宽度（0,h）
 @return 新的size (w,h)
 */
- (CGSize)boundingRectWithSize:(CGSize)size;

#pragma mark ---方法2：调用方法---
-(void)lx_setLineSpace:(CGFloat)lineSpace;

-(void)lx_setCharacterSpace:(CGFloat)characterSpace;

-(void)lx_setLineSpace:(CGFloat)lineSpace
        characterSpace:(CGFloat)characterSpace;

-(void)lx_setKeywords:(NSString * __nullable)keywords
          keywordFont:(UIFont * __nullable)keyFont
         keywordColor:(UIColor * __nullable)keywordColor;

-(void)lx_setUnderlineStr:(NSString *__nullable)underlineStr
           underlineColor:(UIColor *__nullable)underlineColor;

-(void)lx_setMiddlelineStr:(NSString *__nullable)middlelineStr
           middlelineColor:(UIColor *__nullable)middlelineColor;

-(void)lx_setLineSpace:(CGFloat)lineSpace
        characterSpace:(CGFloat)characterSpace
               keyword:(NSString * __nullable)keyword
           keywordFont:(UIFont * __nullable)keyFont
          keywordColor:(UIColor * __nullable)keywordColor
          underlineStr:(NSString * __nullable)underlineStr
        underlineColor:(UIColor * __nullable)underlineColor
         middlelineStr:(NSString * __nullable)middlelineStr
       middlelineColor:(UIColor * __nullable)middlelineColor;

@end

NS_ASSUME_NONNULL_END
