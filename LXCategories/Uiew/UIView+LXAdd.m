//
//  UIView+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "UIView+LXAdd.h"
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(UIView_LXAdd)

@implementation UIView (LXAdd)

/// frame 快捷访问
- (CGFloat)lx_left {
    return self.frame.origin.x;
}

-(void)setLx_left:(CGFloat)lx_left{
    CGRect frame = self.frame;
    frame.origin.x = lx_left;
    self.frame = frame;
}

-(CGFloat)lx_top{
    return self.frame.origin.y;
}

-(void)setLx_top:(CGFloat)lx_top{
    CGRect frame = self.frame;
    frame.origin.y = lx_top;
    self.frame = frame;
}

- (CGFloat)lx_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setLx_right:(CGFloat)lx_right{
    CGRect frame = self.frame;
    frame.origin.x = lx_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lx_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setLx_bottom:(CGFloat)lx_bottom{
    CGRect frame = self.frame;
    frame.origin.y = lx_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lx_width {
    return self.frame.size.width;
}

-(void)setLx_width:(CGFloat)lx_width{
    CGRect frame = self.frame;
    frame.size.width = lx_width;
    self.frame = frame;
}

- (CGFloat)lx_height {
    return self.frame.size.height;
}

-(void)setLx_height:(CGFloat)lx_height{
    CGRect frame = self.frame;
    frame.size.height = lx_height;
    self.frame = frame;
}

- (CGFloat)lx_centerX {
    return self.center.x;
}

-(void)setLx_centerX:(CGFloat)lx_centerX{
    self.center = CGPointMake(lx_centerX, self.center.y);
}

- (CGFloat)lx_centerY {
    return self.center.y;
}

- (void)setLx_centerY:(CGFloat)lx_centerY {
    self.center = CGPointMake(self.center.x, lx_centerY);
}

- (CGPoint)lx_origin {
    return self.frame.origin;
}

-(void)setLx_origin:(CGPoint)lx_origin{
    CGRect frame = self.frame;
    frame.origin = lx_origin;
    self.frame = frame;
}

- (CGSize)lx_size {
    return self.frame.size;
}

- (void)setLx_size:(CGSize)lx_size {
    CGRect frame = self.frame;
    frame.size = lx_size;
    self.frame = frame;
}

#pragma mark - 返回视图的视图控制器
- (UIViewController *)lx_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 设置视图view的部分圆角(绝对布局)
// corners(枚举类型，可组合使用)：UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
- (void)lx_setRoundedCorners:(UIRectCorner)corners
                  withRadius:(CGSize)radius {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

#pragma mark - 设置视图view的部分圆角(相对布局)
// corners(枚举类型，可组合使用)：UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
- (void)lx_setRoundedCorners:(UIRectCorner)corners
                  withRadius:(CGSize)radius
                    viewRect:(CGRect)rect {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

#pragma mark - 设置视图view的阴影
- (void)lx_setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

#pragma mark - 删除所有子视图
- (void)lx_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

#pragma mark - 返回视图的视图控制器
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 创建屏幕快照
- (UIImage *)lx_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

#pragma mark - 创建屏幕快照pdf
- (NSData *)lx_snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

#pragma mark - 设置view的渐变色
- (void)lx_setGradientColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(LXDirectionType)direction {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    if (direction == LXDirectionTypeTopToBottom) {
        gradientLayer.endPoint = CGPointMake(0, 1.0);
    } else {
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}


@end
