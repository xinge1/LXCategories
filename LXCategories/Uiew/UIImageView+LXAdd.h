//
//  UIImageView+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LXAdd)

/** 通过 Graphics 和 BezierPath 设置圆角（推荐用这个）*/
- (void)lx_setGraphicsCornerRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
