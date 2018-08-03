//
//  NSString+Base64.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  字符串的Base 64编码
 *
 *  @param input 源字符串
 *
 *  @return 结果字符串
 */
+ (NSString*)encodeBase64String:(NSString *)input;


/**
 *  字符串的Base 64解码
 *
 *  @param input 源字符串
 *
 *  @return 结果字符串
 */
+ (NSString*)decodeBase64String:(NSString *)input;


/**
 *  data的Base 64编码
 *
 *  @param input 源字符串
 *
 *  @return 结果字符串
 */
+ (NSString*)encodeBase64Data:(NSData *)data;


/**
 *  data的Base 64解码
 *
 *  @param input 源字符串
 *
 *  @return 结果字符串
 */
+ (NSString*)decodeBase64Data:(NSData *)data;

@end
