//
//  NSString+UUID.m
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+UUID.h"
#import "SSKeychain.h"
#import "GWLogUtility.h"

#define KEY_CHAIN_GROUP_NAME    @"com.GamwWorks.Sdk.haima"
#define KEY_CHAIN_IDENTIFY      @"uuid"

@implementation NSString (UUID)



+(NSString *)achieveUUIDWithArchives:(BOOL) isArchives
{
    if (isArchives) {
        NSString *uuid = [SSKeychain passwordForService:KEY_CHAIN_GROUP_NAME account:KEY_CHAIN_IDENTIFY];
        if (uuid && ![uuid isEqualToString:@""])
            return uuid;
        else
        {
            NSString *new_uuid = [self achieveUUID];
            [SSKeychain setPassword: new_uuid
                         forService:KEY_CHAIN_GROUP_NAME account:KEY_CHAIN_IDENTIFY];
            return new_uuid;
        }
    }else
       return [self achieveUUID];
}

+ (void)cleanUUID
{
    [SSKeychain deletePasswordForService:KEY_CHAIN_GROUP_NAME account:KEY_CHAIN_IDENTIFY];
}


+(NSString *)achieveUUID
{
    DLog(@"%@",[[UIDevice currentDevice].identifierForVendor UUIDString]);
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

@end
