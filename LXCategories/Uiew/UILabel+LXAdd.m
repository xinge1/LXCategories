//
//  UILabel+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "UILabel+LXAdd.h"
#import "NSAttributedString+LXAdd.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(UILabel_LXAdd)

@interface UILabel()

@property (nonatomic , strong) NSMutableAttributedString *attributedString;

@end


@implementation UILabel (LXAdd)

-(NSMutableAttributedString *)attributedString{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setAttributedString:(NSMutableAttributedString *)attributedString{
    objc_setAssociatedObject(self, @selector(attributedString), attributedString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)characterSpace{
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

-(void)setCharacterSpace:(CGFloat)characterSpace{
    objc_setAssociatedObject(self, @selector(characterSpace), @(characterSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(CGFloat)lineSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSString *)keywords{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywords:(NSString *)keywords{
    objc_setAssociatedObject(self, @selector(keywords), keywords, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIFont *)keywordsFont{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsFont:(UIFont *)keywordsFont{
    objc_setAssociatedObject(self, @selector(keywordsFont), keywordsFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)keywordsColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsColor:(UIColor *)keywordsColor{
    objc_setAssociatedObject(self, @selector(keywordsColor), keywordsColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)underlineStr{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineStr:(NSString *)underlineStr{
    objc_setAssociatedObject(self, @selector(underlineStr), underlineStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIColor *)underlineColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineColor:(UIColor *)underlineColor{
    objc_setAssociatedObject(self, @selector(underlineColor), underlineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSString *)middlelineStr{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMiddlelineStr:(NSString *)middlelineStr{
    objc_setAssociatedObject(self, @selector(middlelineStr), middlelineStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)middlelineColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMiddlelineColor:(UIColor *)middlelineColor{
    objc_setAssociatedObject(self, @selector(middlelineColor), middlelineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 *  根据最大宽度计算label宽，高
 *
 *  @param maxWidth 最大宽度
 *
 *  @return size
 */
- (CGSize)getLableSizeWithMaxWidth:(CGFloat)maxWidth{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,self.text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment=self.textAlignment;
    paragraphStyle.lineBreakMode=self.lineBreakMode;
    // 行间距
    if(self.lineSpace > 0){
        [paragraphStyle setLineSpacing:self.lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    // 字间距
    if(self.characterSpace > 0){
        long number = self.characterSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
        
        CFRelease(num);
    }
    
    //关键字
    if (self.keywords) {
        NSRange itemRange = [self.text rangeOfString:self.keywords];
        if (self.keywordsFont) {
            [attributedString addAttribute:NSFontAttributeName value:self.keywordsFont range:itemRange];
            
        }
        
        if (self.keywordsColor) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:self.keywordsColor range:itemRange];
            
        }
    }
    
    //下划线
    if (self.underlineStr) {
        NSRange itemRange = [self.text rangeOfString:self.underlineStr];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
        if (self.underlineColor) {
            [attributedString addAttribute:NSUnderlineColorAttributeName value:self.underlineColor range:itemRange];
        }
    }
    
    //中线
    if (self.middlelineStr) {
        NSRange itemRange = [self.text rangeOfString:self.middlelineStr];
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:itemRange];
        if (self.middlelineColor) {
            [attributedString addAttribute:NSStrikethroughColorAttributeName value:self.middlelineColor range:itemRange];
        }
    }
    
    
    self.attributedText = attributedString;
    
    //计算方法一
    //计算文本rect，但是发现设置paragraphStyle.lineBreakMode=NSLineBreakByTruncatingTail;后高度计算不准确
    //    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    //    CGSize expectSize = rect.size;
    
    //计算方法二
    CGSize maximumLabelSize = CGSizeMake(maxWidth, MAXFLOAT);//labelsize的最大值
    CGSize expectSize = [self sizeThatFits:maximumLabelSize];
    
    return expectSize;
}




- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    NSString *str = self.text;
    
    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading |
                      NSStringDrawingUsesDeviceMetrics
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}

#pragma mark---方法---
-(void)lx_setLineSpace:(CGFloat)lineSpace{
    [self lx_setLineSpace:lineSpace
           characterSpace:0.0
                  keyword:nil
              keywordFont:nil
             keywordColor:nil
             underlineStr:nil
           underlineColor:nil
            middlelineStr:nil
          middlelineColor:nil];
}

-(void)lx_setCharacterSpace:(CGFloat)characterSpace{
    [self lx_setLineSpace:0.0
           characterSpace:characterSpace
                  keyword:nil
              keywordFont:nil
             keywordColor:nil
             underlineStr:nil
           underlineColor:nil
            middlelineStr:nil
          middlelineColor:nil];
}

-(void)lx_setLineSpace:(CGFloat)lineSpace
        characterSpace:(CGFloat)characterSpace{
    [self lx_setLineSpace:lineSpace
           characterSpace:characterSpace
                  keyword:nil
              keywordFont:nil
             keywordColor:nil
             underlineStr:nil
           underlineColor:nil
            middlelineStr:nil
          middlelineColor:nil];
}

-(void)lx_setKeywords:(NSString * __nullable)keywords
          keywordFont:(UIFont * __nullable)keyFont
         keywordColor:(UIColor * __nullable)keywordColor{
    [self lx_setLineSpace:0
           characterSpace:0
                  keyword:keywords
              keywordFont:keyFont
             keywordColor:keywordColor
             underlineStr:nil
           underlineColor:nil
            middlelineStr:nil
          middlelineColor:nil];
}

-(void)lx_setUnderlineStr:(NSString *__nullable)underlineStr
           underlineColor:(UIColor *__nullable)underlineColor{
    [self lx_setLineSpace:0
           characterSpace:0
                  keyword:nil
              keywordFont:nil
             keywordColor:nil
             underlineStr:underlineStr
           underlineColor:underlineColor
            middlelineStr:nil
          middlelineColor:nil];
}

-(void)lx_setMiddlelineStr:(NSString *__nullable)middlelineStr
           middlelineColor:(UIColor *__nullable)middlelineColor{
    [self lx_setLineSpace:0
           characterSpace:0
                  keyword:nil
              keywordFont:nil
             keywordColor:nil
             underlineStr:nil
           underlineColor:nil
            middlelineStr:middlelineStr
          middlelineColor:middlelineColor];
}

-(void)lx_setLineSpace:(CGFloat)lineSpace
        characterSpace:(CGFloat)characterSpace
               keyword:(NSString * __nullable)keyword
           keywordFont:(UIFont * __nullable)keyFont
          keywordColor:(UIColor * __nullable)keywordColor
          underlineStr:(NSString * __nullable)underlineStr
        underlineColor:(UIColor * __nullable)underlineColor
         middlelineStr:(NSString * __nullable)middlelineStr
       middlelineColor:(UIColor * __nullable)middlelineColor{
    
//    if (!self.attributedString) {
        self.attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
        [self.attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,self.text.length)];
//    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment=self.textAlignment;
    paragraphStyle.lineBreakMode=self.lineBreakMode;
    // 行间距
    if(lineSpace > 0){
        [paragraphStyle setLineSpacing:lineSpace];
        [self.attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    // 字间距
    if(characterSpace > 0){
        long number = characterSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [self.attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[self.attributedString length])];
        
        CFRelease(num);
    }
    
    //关键字
    if (keyword) {
        NSRange itemRange = [self.text rangeOfString:keyword];
        if (keyFont) {
            [self.attributedString addAttribute:NSFontAttributeName value:keyFont range:itemRange];
            
        }
        
        if (keywordColor) {
            [self.attributedString addAttribute:NSForegroundColorAttributeName value:keywordColor range:itemRange];
            
        }
    }
    
    //下划线
    if (underlineStr) {
        NSRange itemRange = [self.text rangeOfString:underlineStr];
        [self.attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
        if (underlineColor) {
            [self.attributedString addAttribute:NSUnderlineColorAttributeName value:underlineColor range:itemRange];
        }
    }
    
    //中线
    if (middlelineStr) {
        NSRange itemRange = [self.text rangeOfString:middlelineStr];
        [self.attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:itemRange];
        if (middlelineColor) {
            [self.attributedString addAttribute:NSStrikethroughColorAttributeName value:middlelineColor range:itemRange];
        }
    
    }
    
    self.attributedText = self.attributedString;
    

}



@end
