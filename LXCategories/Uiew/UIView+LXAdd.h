//
//  UIView+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LXDirectionType) {
    LXDirectionTypeLeftToRight = 0,
    LXDirectionTypeTopToBottom
};

@interface UIView (LXAdd)

#pragma mark ---frame，size---
/** left: frame.origin.x */
@property (nonatomic) CGFloat lx_left;
/** top: frame.origin.y */
@property (nonatomic) CGFloat lx_top;
/** right: frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat lx_right;
/** bottom: frame.origin.y + frame.size.height */
@property (nonatomic) CGFloat lx_bottom;
/** width: frame.size.width */
@property (nonatomic) CGFloat lx_width;
/** height: frame.size.height */
@property (nonatomic) CGFloat lx_height;
/** centerX: center.x */
@property (nonatomic) CGFloat lx_centerX;
/** centerY: center.y */
@property (nonatomic) CGFloat lx_centerY;
/** origin: frame.origin */
@property (nonatomic) CGPoint lx_origin;
/** size: frame.size */
@property (nonatomic) CGSize  lx_size;

/** 返回视图的视图控制器(可能为nil) */
@property (nullable, nonatomic, readonly) UIViewController *lx_viewController;


/**
 *  设置视图view的部分圆角(绝对布局)
 *
 *  @param corners  需要设置为圆角的角(枚举类型)
 *  @param radius   需要设置的圆角大小
 */
- (void)lx_setRoundedCorners:(UIRectCorner)corners
                  withRadius:(CGSize)radius;

/**
 *  设置视图view的部分圆角(相对布局)
 *
 *  @param corners  需要设置为圆角的角(枚举类型)
 *  @param radius   需要设置的圆角大小
 *  @param rect     需要设置的圆角view的rect
 */
- (void)lx_setRoundedCorners:(UIRectCorner)corners
                  withRadius:(CGSize)radius
                    viewRect:(CGRect)rect;

/**
 *  设置视图view的阴影
 *
 *  @param color  阴影颜色
 *  @param offset 阴影偏移量
 *  @param radius 阴影半径
 */
- (void)lx_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

/** 删除所有子视图 */
- (void)lx_removeAllSubviews;

/** 创建屏幕快照 */
- (nullable UIImage *)lx_snapshotImage;

/** 创建屏幕快照pdf */
- (nullable NSData *)lx_snapshotPDF;

/** 设置view的渐变色 */
- (void)lx_setGradientColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(LXDirectionType)direction;

@end

NS_ASSUME_NONNULL_END
