//
//  UIButton+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BRButtonEdgeInsetsStyle) {
    /** image在上，label在下 */
    BRButtonEdgeInsetsStyleTop,
    /** image在左，label在右 */
    BRButtonEdgeInsetsStyleLeft,
    /** image在下，label在上 */
    BRButtonEdgeInsetsStyleBottom,
    /** image在右，label在左 */
    BRButtonEdgeInsetsStyleRight
};

@interface UIButton (LXAdd)

/**
 *  设置button的文字和图片的布局样式，及间距
 *
 *  @param style 文字和图片的布局样式
 *  @param space 文字和图片的间距
 */
- (void)lx_layoutButtonWithEdgeInsetsStyle:(BRButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space;

/**
 *  倒计时按钮
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)lx_startWithTime:(NSInteger)timeLine
                   title:(NSString *)title
          countDownTitle:(NSString *)subTitle
               mainColor:(UIColor *)mColor
              countColor:(UIColor *)color;

#pragma mark ---快速创建UIButton---
/**
 *  设置带图片的 Button (带方法)
 *  @param title                文字
 *  @param nomalColor           默认文字颜色
 *  @param hiehlightedColor     高亮文字颜色
 *  @param nomalImg             默认图片
 *  @param hiehlightedImg       高亮图片
 *  @param action              点击后做的事情
 */
+ (instancetype)lx_buttonWithTitletext:(NSString *)title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                         nomalImage:(NSString *)nomalImg
                   hiehlightedImage:(NSString *)hiehlightedImg
                             target:(id)target
                             action:(SEL)action;


/**
 *  设置带图片的 Button （不带方法）
 *  @param title                文字
 *  @param nomalColor           默认文字颜色
 *  @param hiehlightedColor     文字高亮颜色
 *  @param nomalImg             默认图片
 *  @param hiehlightedImg       高亮图片
 */
+ (instancetype)lx_buttonWithTitletext:(NSString *)title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                         nomalImage:(NSString *)nomalImg
                   hiehlightedImage:(NSString *)hiehlightedImg;



/**
 *  设置只有图片的Button
 *  @param nomalImg       默认图片
 *  @param hiehlightedImg 高亮图片
 */
+ (instancetype)lx_buttonWithnomalImage:(NSString *)nomalImg
                    hiehlightedImage:(NSString *)hiehlightedImg;


/**
 *  设置带图片图片按下状态的Button
 *  @param nomalImg       默认图片
 *  @param selectedImg    按下过后的图片
 */
+ (instancetype)lx_buttonWithnomalImage:(NSString *)nomalImg
                       selectedImage:(NSString *)selectedImg;


/**
 *  带图片文字按下状态的 Button
 *  @param title       默认文字
 *  @param nomalImg    默认图片
 *  @param selectedImg 按下图片
 *
 */
+ (instancetype)lx_buttonWithTitle:(NSString *)title
                     nomalImage:(NSString *)nomalImg
                  selectedImage:(NSString *)selectedImg
                         target:(id)target
                         action:(SEL)action;


/**
 *  带图片文字按下状态的 Button
 *  @param title       默认文字
 *  @param nomalImg    默认图片
 *  @param heightImg   高亮图片
 *
 */
+ (instancetype)lx_buttonWithTitle:(NSString *)title
                     nomalImage:(NSString *)nomalImg
                    HeightImage:(NSString *)heightImg
                         target:(id)target
                         action:(SEL)action;


/**
 *  设置带背景的 Button (带方法)
 *  @param title                文字
 *  @param nomalColor           默认文字颜色
 *  @param hiehlightedColor     高亮文字颜色
 *  @param nomalImg             默认背景图片
 *  @param hiehlightedImg       高亮背景图片
 *  @param action              点击后做的事情
 */
+ (instancetype)lx_buttonWithTitletext:(NSString *)title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                 nomalBackGroundImg:(NSString *)nomalImg
               hiehlightedGroundImg:(NSString *)hiehlightedImg
                             target:(id)target
                             action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
