//
//  NSString+UUID.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UUID)

/**
 *  获取uuid
 *
 *  @param isArchives 是否存档：yes->将UUID保存到keychain中  NO->不存档，直接返回
 *
 *  @return 返回UUID
 */
+ (NSString *)achieveUUIDWithArchives:(BOOL) isArchives;


/**
 *  清除钥匙串中保存的uuid
 */
+ (void)cleanUUID;


/**
 *  直接获取uuid
 *
 *  @return 返回uuid
 */
+(NSString *)achieveUUID;

@end
