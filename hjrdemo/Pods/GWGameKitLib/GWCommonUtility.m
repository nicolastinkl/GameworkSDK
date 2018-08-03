//
//  GWCommonUtility.m
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "GWCommonUtility.h"
#import "GWLogUtility.h"
#import "GWAESUtility.h"
#import "GWDefine.h"
#import "GameWorksSDK.h"

#define GP_NETWORK_KEY "c6*#e2&(g*UjX!h*"

@implementation GWCommonUtility


+ (NSString *)encryptAES_128_CBC_Data:(const char *)string
{
    return [[[GWAESUtility alloc] initWithKey:GP_NETWORK_KEY] Encryption:string len:(int)strlen(string)];
    
}


+ (NSString *)decryptAES_128_CBC_Data:(const char *)string
{
    return [[[GWAESUtility alloc] initWithKey:GP_NETWORK_KEY] Decryption:string len:(int)strlen(string)];
}

+ (NSData*)encrypt_AES256Data:(NSString*)string withKey:(NSString *)key
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [data AES256EncryptWithKey:key];
    return encryptedData;
}


+ (NSString*)decrypt_AES256Data:(NSData*)data withKey:(NSString *)key
{
    NSData *decryData = [data AES256DecryptWithKey:key];
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}


+(NSString *)achieveUniqueIdentifier
{
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    CGFloat version = [sysVersion floatValue];
    if (version >= 7.0)
        return [NSString stringWithFormat:@"%@",[NSString achieveUUIDWithArchives:YES]];//返回UDID+KeyChain
    else
        return [NSString stringWithFormat:@"%@",[NSString achieveMacAddress]];//返回mac地址信息
    return @"";
}

+ (NSString *)configerCpName
{
   return [GameKitSDK defaultSdk].gameKitConfigure.CPName;
}


+ (NSString *)iOSPlatformFlag
{
    return CONFING_IOS_PLANFORM;
}


+ (BOOL) acceptZip
{
    return (CONFING_ACCEPT_ZIP == 1)?YES:NO;
}


+(NSString *)sdkVersion
{
    return [GameKitSDK defaultSdk].gameKitConfigure.CPVersion;
}

+ (NSString *) getGameKey
{
    return [GameKitSDK defaultSdk].gameKitConfigure.PTGameKey;
}

+ (NSString *)gameworksPayBackUrl
{
    return [@"http://anyapi.mobile.youxigongchang.com/notify/" stringByAppendingFormat:@"%@/%@",[GameKitSDK defaultSdk].gameKitConfigure.CPName,[self getGameKey]];
}

+ (NSString *) getGameChannel
{
    return [GameKitSDK defaultSdk].gameKitConfigure.PTGameChannel?STRING_NULL:[GameKitSDK defaultSdk].gameKitConfigure.PTGameChannel;
}

+ (BOOL)gameSessionExist
{
    return ([GameKitSDK defaultSdk].gameKitConfigure.sessionId == nil) ? NO : YES;
}

+ (NSString *)gameSession
{
    return [self gameSessionExist]?[[GameKitSDK defaultSdk].gameKitConfigure sessionId]:STRING_NULL;
}

+ (void) setGameSession:(NSString *)gameSession
{
    [[GameKitSDK defaultSdk].gameKitConfigure setSessionId:gameSession];
}

+ (NSString *)buildCookieString
{
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    [cookieString appendString:[self getGameChannel]];                                //渠道号
    [cookieString appendFormat:@"|%d",[NSString iOSHaveJailbreaking]?1:0];            //是否越狱
    [cookieString appendFormat:@"|%@",[NSString iOSCurrnetResolution]];               //设备分辨率
    [cookieString appendFormat:@"|%@",[NSString iOSCurrnetSystemVersion]];            //系统版本
    [cookieString appendFormat:@"|apple"];                                            //设备类型
    [cookieString appendFormat:@"|%@",[self sdkVersion]];                             //sdk 版本
    [cookieString appendFormat:@"|%@",[self achieveUniqueIdentifier]];                //客户端唯一标示
    [cookieString appendFormat:@"|%d",(int)[NSString getDeviceNetWorkState_4G_Version]];   //网络类型
    [cookieString appendFormat:@"|%@",[[NSString iOSCarrieroperator] carrierName]];   //运营商名
    [cookieString appendFormat:@"|%@",[NSString getCurrentDeviceModel]];              //当前设备型号
    [cookieString appendFormat:@"|%@",[[NSString iOSCarrieroperator] isoCountryCode]];//国家码
    [cookieString appendFormat:@"|%@",[NSString iOSCurrnetLangage]];                  //当前语言
    [cookieString appendFormat:@"|%@",[NSString stringWithFormat:@"%d", YES]];        //上线越狱版本（苹果专用）
    [cookieString appendFormat:@"|%@",[NSString stringWithFormat:@"%d", NO]];         //专服
    return [NSString encodeBase64String:cookieString];                                //Base64 加密
}

#pragma mark -  构建发送到服务器的公共info数据

+ (NSMutableDictionary *)achieveSharedSendInfo
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self getGameKey],GW_GAME_KEY,
                                                                                       STRING_NULL,GW_DEVICE_TOKEN,
                                                                      [NSString iOSCurrnetLangage],GW_LANG,
                                                                                 [self sdkVersion],GW_VERSION,
                                                                   [NSString iOSCurrnetSystemName],GW_OS,
                                                                [NSString iOSCurrnetSystemVersion],GW_OSVER,
                                                                    [self achieveUniqueIdentifier],GW_WLAN,
                                                    @([NSString getDeviceNetWorkState_4G_Version]),GW_NETWORK,
                                                          [NSString iOSHaveJailbreaking]?@(1):@(0),GW_ROOT,
                                                                  [NSString getCurrentDeviceModel],GW_DEVICE,
                                                                                [self gameSession],GW_SESSION,
                                                                        [self acceptZip]?@"1":@"0",GW_ACCEPT,
                                                                          [self buildCookieString],GW_COOKIE,
                                                                   [NSString iOSCurrnetResolution],GW_RESOLUTION,
                                                                              CONFING_IOS_PLANFORM,GW_SOURCE,
                                                                             [self configerCpName],GW_CP,
                                                                                                         nil];
    
    return dic;
}

+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

@end
