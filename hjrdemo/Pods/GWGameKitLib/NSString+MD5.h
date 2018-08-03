//
//  NSString+MD5.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  md5 32位 大写 处理
 *
 *  @param string 源字符串
 *
 *  @return 加密结果
 */
- (NSString *)md5_32_uppercasecase:(NSString *) string;

/**
 *  md5 32位 小写 处理
 *
 *  @param string 源字符串
 *
 *  @return 加密结果
 */
- (NSString *)md5_32_lowercase:(NSString *) string;

/**
 *  md5 64位 小写处理
 *
 *  @param string 源字符串
 *
 *  @return 加密结果
 */
- (NSString *)md5_64_uppercasecase:(NSString *) string;

/**
 *  md5 64位 小写处理
 *
 *  @param string 源字符串
 *
 *  @return 加密结果
 */
- (NSString *)md5_64_lowercase:(NSString *) string;

@end
