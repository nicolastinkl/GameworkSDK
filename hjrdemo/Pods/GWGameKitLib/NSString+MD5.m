//
//  NSString+MD5.m
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import "NSString+MD5.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (MD5)

- (NSString *)md5_32_uppercasecase:(NSString *) string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result uppercaseString];
}


- (NSString *)md5_32_lowercase:(NSString *) string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result lowercaseString];
}


- (NSString *)md5_64_uppercasecase:(NSString *) string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result uppercaseString];
}


- (NSString *)md5_64_lowercase:(NSString *) string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, (CC_LONG)self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result lowercaseString];
}

@end
