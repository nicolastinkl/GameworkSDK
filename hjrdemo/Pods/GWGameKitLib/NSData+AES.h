//
//  NSData+AES.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

/**
 *   Data数据的aes 256位加密
 *
 *  @param key 钥匙
 *
 *  @return 加密后的数据
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/**
 *  aes数据数据解密
 *
 *  @param key 钥匙
 *
 *  @return 解密后字符串
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;



@end
