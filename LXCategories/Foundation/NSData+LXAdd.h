//
//  NSData+LXAdd.h
//  LXCategoriesDemo
//
//  Created by liuxin on 2018/12/26.
//  Copyright © 2018年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LXAdd)

/** AES加密 */
- (NSData *)AES256EncryptWithKey:(NSData *)key;

/** AES解密 */
- (NSData *)AES256DecryptWithKey:(NSData *)key;

/** Base64加密 */
- (NSString *)base64EncodedStringFrom:(NSData *)data;

/** Base64解密 */
- (NSData *)dataWithBase64EncodedString:(NSString *)string;

/** Base64解密 + AES解密 */
- (NSString *)dataBase64AndAESWithEncodedString:(NSString *)string keyData:(NSData *)keyData;

/** 创建一个密匙(Data类的密匙) */
- (NSData *)ctreatAKeyData;

@end

NS_ASSUME_NONNULL_END
