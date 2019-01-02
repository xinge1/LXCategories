//
//  UIButton+LXAdd.m
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/27.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import "UIButton+LXAdd.h"
#import "LXCategoryMacro.h"


LXSYNTH_DUMMY_CLASS(UIButton_LXAdd)
@implementation UIButton (LXAdd)

- (void)lx_layoutButtonWithEdgeInsetsStyle:(BRButtonEdgeInsetsStyle)style
                           imageTitleSpace:(CGFloat)space {
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case BRButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space / 2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - space / 2.0, 0);
        }
            break;
        case BRButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        }
            break;
        case BRButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - space / 2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - space / 2.0, -imageWith, 0, 0);
        }
            break;
        case BRButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space / 2.0, 0, -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space / 2.0, 0, imageWith + space / 2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)lx_startWithTime:(NSInteger)timeLine
                   title:(NSString *)title
          countDownTitle:(NSString *)subTitle
               mainColor:(UIColor *)mColor
              countColor:(UIColor *)color{
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.enabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                [weakSelf setTitle:[NSString stringWithFormat:@"(%@) %@",timeStr,subTitle] forState:UIControlStateNormal];
                weakSelf.enabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark ---快速创建UIButton---
//  设置带图片的button （带方法）
+ (instancetype)lx_buttonWithTitletext:title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                         nomalImage:(NSString *)nomalImg
                   hiehlightedImage:(NSString *)hiehlightedImg
                             target:(id)target
                             action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:nomalColor forState:UIControlStateNormal];
    [button setTitleColor:hiehlightedColor forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hiehlightedImg] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//  设置带图片的button （不带方法）
+ (instancetype)lx_buttonWithTitletext:(NSString *)title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                         nomalImage:(NSString *)nomalImg
                   hiehlightedImage:(NSString *)hiehlightedImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:nomalColor forState:UIControlStateNormal];
    [button setTitleColor:hiehlightedColor forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hiehlightedImg] forState:UIControlStateHighlighted];
    button.clipsToBounds = YES;
    return button;
}

// 只有图片的button
+ (instancetype)lx_buttonWithnomalImage:(NSString *)nomalImg
                    hiehlightedImage:(NSString *)hiehlightedImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hiehlightedImg] forState:UIControlStateHighlighted];
    button.clipsToBounds = YES;
    return button;
}

// 带图片按下状态的button
+ (instancetype)lx_buttonWithnomalImage:(NSString *)nomalImg
                       selectedImage:(NSString *)selectedImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    button.clipsToBounds = YES;
    return button;
}

// 带图片文字按下状态的button
+ (instancetype)lx_buttonWithTitle:(NSString *)title
                     nomalImage:(NSString *)nomalImg
                  selectedImage:(NSString *)selectedImg
                         target:(id)target
                         action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    return button;
}

// 带图片文字高亮状态的button
+ (instancetype)lx_buttonWithTitle:(NSString *)title
                     nomalImage:(NSString *)nomalImg
                    HeightImage:(NSString *)heightImg
                         target:(id)target
                         action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:heightImg] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    return button;
}


//  带背景的button
+ (instancetype)lx_buttonWithTitletext:(NSString *)title
                    nomalTitleColor:(UIColor *)nomalColor
              highlightedTitleColor:(UIColor *)hiehlightedColor
                 nomalBackGroundImg:(NSString *)nomalImg
               hiehlightedGroundImg:(NSString *)hiehlightedImg
                             target:(id)target
                             action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:nomalColor forState:UIControlStateNormal];
    [button setTitleColor:hiehlightedColor forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:nomalImg] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hiehlightedImg] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds = YES;
    return button;
}


@end
