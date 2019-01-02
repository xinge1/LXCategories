//
//  UINavigationBar+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (LXAdd)

- (void)lx_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lx_setElementsAlpha:(CGFloat)alpha;
- (void)lx_setTranslationY:(CGFloat)translationY;
- (void)lx_reset;

@end

NS_ASSUME_NONNULL_END
