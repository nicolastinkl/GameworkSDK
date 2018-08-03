//
//  GWCommonUtility.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWDefine.h"
#import "NSData+AES.h"
#import "NSString+MD5.h"
#import "NSString+Base64.h"
#import "NSString+Device.h"
#import "NSString+UUID.h"

@interface GWCommonUtility : NSObject

#pragma mark - AES加密
+ (NSData*)encrypt_AES256Data:(NSString*)string withKey:(NSString *)key;//将string转成带密码的data
+ (NSString*)decrypt_AES256Data:(NSData*)data withKey:(NSString *)key;  //将带密码的data转成string

+ (NSString *)encryptAES_128_CBC_Data:(const char *)string;//CBC模式下得128位加密
+ (NSString *)decryptAES_128_CBC_Data:(const char *)string;//CBC模式下得128位解密


#pragma mark - 读取配置文件
+ (NSString *)configerCpName; //获取配置文件中的cp名称
+ (NSString *)iOSPlatformFlag;//获取iOS平台标识
+ (NSString *)sdkVersion;     // sdk 版本
+ (NSString *)gameworksPayBackUrl;//获取整合平台充值回调地址
#pragma mark - 设备信息
+ (NSString *)achieveUniqueIdentifier;//获取ios设备唯一标示符

#pragma mark - 其他
+ (NSMutableDictionary *)achieveSharedSendInfo; //获取请求的共有信息
+ (NSString *) getGameKey;//获取gameKey
+ (BOOL)isPureInt:(NSString *)string;//判断字符串是否可以转化为数字
+ (BOOL)acceptZip;//数据是否压缩
+ (BOOL)gameSessionExist;//是否已经取到gamesession
+ (NSString *)gameSession;//获取gamesession
+ (void) setGameSession:(NSString *)gameSession;//保存获取到得gameSession

@end
