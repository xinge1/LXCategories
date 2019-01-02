//
//  NSAttributedString+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/26.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (LXAdd)

/** 由于系统计算富文本的高度不正确，自己写了方法 */
- (CGFloat)lx_heightWithContainWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
