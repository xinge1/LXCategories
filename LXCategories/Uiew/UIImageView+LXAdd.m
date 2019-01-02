//
//  UIImageView+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/28.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "UIImageView+LXAdd.h"
#import "LXCategoryMacro.h"

LXSYNTH_DUMMY_CLASS(UIImageView_LXAdd)

@implementation UIImageView (LXAdd)

#pragma mark - 通过 Graphics 和 BezierPath 设置圆角（推荐用这个）
- (void)lx_setGraphicsCornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] addClip];
    [self drawRect:self.bounds];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束
    UIGraphicsEndImageContext();
}

@end
