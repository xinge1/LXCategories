//
//  UIImage+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 水印方向 */
typedef NS_ENUM(NSUInteger, WYWatermarkDirection) {
    WYWatermarkDirectionTopLeft,        // 左上
    WYWatermarkDirectionTopRight,       // 右上
    WYWatermarkDirectionBottomLeft,     // 左下
    WYWatermarkDirectionBottomRight,    // 右下
    WYWatermarkDirectionCenter,         // 正中
};

/** 渐变颜色方向 */
typedef enum  {
    LXGradientTypeTopToBottom = 0,//从上到小
    LXGradientTypeLeftToRight = 1,//从左到右
    LXGradientTypeUpleftTolowRight = 2,//左上到右下
    LXGradientTypeUprightTolowLeft = 3,//右上到左下
}LXGradientType;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LXAdd)

/** 显示原图（避免被系统渲染成蓝色） */
+ (nullable UIImage *)lx_originalImage:(NSString *)imageName;

/** 用颜色返回一张图片 */
+ (nullable UIImage *)lx_imageWithColor:(UIColor *)color;

/** 用颜色返回一张图片（指定图片大小） */
+ (nullable UIImage *)lx_imageWithColor:(UIColor *)color size:(CGSize)size;

/** 为UIImage添加滤镜效果
 *滤镜名字：OriginImage(原图)、CIPhotoEffectNoir(黑白)、CIPhotoEffectInstant(怀旧)、CIPhotoEffectProcess(冲印)、CIPhotoEffectFade(褪色)、CIPhotoEffectTonal(色调)、CIPhotoEffectMono(单色)、CIPhotoEffectChrome(铬黄)
 *
 *  灰色：CIPhotoEffectNoir //黑白
 */
- (nullable UIImage *)lx_addFilter:(NSString *)filter;

/** 设置图片的透明度 */
- (nullable UIImage *)lx_alpha:(CGFloat)alpha;

/** 图片压缩 */
- (UIImage*)lx_imageByScalingAndCroppingForSize:(CGSize)targetSize;

/**
 *  自由拉伸一张图片
 *
 *  @param name 图片名字
 *  @param left 左边开始位置比例  值范围0-1
 *  @param top  上边开始位置比例  值范围0-1
 *
 *  @return 拉伸后的Image
 */
+ (UIImage *)lx_resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/** 根据图片和颜色返回一张加深颜色以后的图片 */
+ (UIImage *)lx_colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;


/** 自由改变Image的大小 */
- (UIImage *)lx_cropImageWithSize:(CGSize)size;

/** 从给定的UIView中截图：UIView转UIImage */
+ (UIImage *)lx_screenshotWithView:(UIView *)view;

/** 直接截屏 */
+ (UIImage *)lx_screencapture;

/** UIImage -> Base64图片 */
- (NSString *)lx_stringWithimageBase64URL:(UIImage *)image;

#pragma mark---圆角设置----
/**
 *  设置圆角图片
 *
 *  @param radius 圆角半径
 */
- (nullable UIImage *)lx_imageByRoundCornerRadius:(CGFloat)radius;


/**
 设置圆角图片(可选圆角位置)

 @param radius 圆角半径
 @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 */
- (UIImage *)lx_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners;

/**
 *  设置圆角图片（带边框）
 *
 *  @param radius 圆角半径
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (nullable UIImage *)lx_imageByRoundCornerRadius:(CGFloat)radius
                                      borderWidth:(CGFloat)borderWidth
                                      borderColor:(nullable UIColor *)borderColor;

#pragma mark---图片编辑----
/** 合并两个图片 */
+ (UIImage*)lx_mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

#pragma mark - 图片水印

/**
 *  给图片添加文字水印
 *
 *  @param text      文字水印
 *  @param direction 水印在图片中的位置
 *  @param fontColor 文字颜色
 *  @param fontPoint 位置中心点
 *  @param marginXY  间距
 *
 *  @return 有水印的图片
 */
- (UIImage *)lx_watermarkWithText:(NSString *)text
                     direction:(WYWatermarkDirection)direction
                     fontColor:(UIColor *)fontColor
                     fontPoint:(CGFloat)fontPoint
                      marginXY:(CGPoint)marginXY;

/**
 *  给图片添加图片水印
 *
 *  @param watermarkImage 图片水印
 *  @param direction      水印在图中的位置
 *  @param watermarkSize      水印大小
 *  @param marginXY       间距
 *
 *  @return 有水印的图片
 */
- (UIImage *)lx_watermarkWithWatermarkImage:(UIImage *)watermarkImage
                               direction:(WYWatermarkDirection)direction
                           watermarkSize:(CGSize)watermarkSize
                                marginXY:(CGPoint)marginXY;

/**
 *  本地图片毛玻璃效果处理
 *
 *  @param image  图片
 *  @param blur   虚化程度
 *
 *  @return 虚化后的UIImage
 */
+ (UIImage *)lx_boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;


/**
 *  本地图片高斯模糊效果处理
 *
 *  @param image  图片
 *  @param blur   虚化程度
 *
 *  @return 虚化后的UIImage
 */
+ (UIImage *)lx_coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;



/** 生成一张毛玻璃图片 */
- (UIImage *)lx_blur:(UIImage*)theImage;


/**
 生成一张渐变图片
 */
+ (UIImage *)lx_getGradientChangeColorFromColors:(NSArray*)colors
                                  ByGradientType:(LXGradientType)gradientType
                                           frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
