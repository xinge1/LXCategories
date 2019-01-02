//
//  LXCategoryMacro.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/26.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#ifndef LXCategoryMacro_h
#define LXCategoryMacro_h


// 动态Get方法
#define wy_categoryPropertyGet(property) return objc_getAssociatedObject(self, @#property);
// 动态Set方法
#define wy_categoryPropertySet(property) objc_setAssociatedObject(self,@#property, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

/**
 静态库中编写 Category 时的便利宏，用于解决 Category 方法从静态库中加载需要特别设置的问题。
 加入这个宏后，不需要再在 Xcode 的 Other Liker Fliags 中设置链接库参数（-Objc / -all_load / -force_load）
 *******************************************************************************
 使用:在静态库中每个分类的 @implementation 前添加这个宏
 Example:
     #import "NSString+LXAdd.h"
 
     BRSYNTH_DUMMY_CLASS(NSString_LXAdd)
     @implementation NSString (LXAdd)
     @end
 */
#ifndef LXSYNTH_DUMMY_CLASS

    #define LXSYNTH_DUMMY_CLASS(_name_) \
    @interface LXSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
    @implementation LXSYNTH_DUMMY_CLASS_ ## _name_ @end

#endif








#pragma mark - 快速实现单例设计模式


/** 单例模式 .h文件的实现 */
#define SingletonH(methodName) + (instancetype)shared##methodName;


/** 单例模式 .m文件的实现 */
#if __has_feature(objc_arc) // 是ARC
#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#else // 不是ARC

#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#endif



#endif /* LXCategoryMacro_h */
