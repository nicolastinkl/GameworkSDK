//
//  GWUtility.h
//  GameWorksSDK
//
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GWUtility : NSObject

// AES
+ (NSString *)AESStingWithString:(NSString *)str;
+ (NSString *)stringWithAESString:(NSString *)aesStr;

// BASE64
+ (NSString *)base64Encode:(NSString *)string;
+ (NSString *)base64Decode:(NSString *)string;

// MD5
+(NSString *)md5:(NSString *)str;

// IOS Device platformString
+ (NSString *)platformString;

//是否越狱
+ (BOOL)isJailBreak;

//屏幕分辨率
+ (NSString *)resolutionScreen;

//系统版本信息
+ (NSString *) systemVersionApp;

//系统UDID
+ (NSString *) systemUDID;

//当前网络环境
+ (NSString *) sysytemCurrentReachabilityStatus;

//当前运营商
+ (NSString *) sysytemCellularProviderName;

//当前国家号
+ (NSString *) sysytemCellularCountryCode;

//当前系统语言
+ (NSString *) systemLanguages;

//打印日志信息
+ (void) printSystemLog:(id) log;

//服务接口地址
+ (NSString *) systemDOMAINURL;

//string字符串安全处理 
+ (NSString *) stringSafeOperation:(NSString *) string;

//判断字符串是否空
+ (BOOL)IsNilOrEmpty:(NSString *)str;

//时间戳
+ (NSString*) timestampFromIntDate:(NSDate*)date;

//获取xib
+ (NSString *) stringByViewController:(NSString *) classname;

//获取手机号正则表达式
+(BOOL)isValidatePhoneNumber:(NSString *)phonenumber;

// 邮箱正则表达式
+(BOOL)isValidateEmail:(NSString *)email;

//是否是可用密码
+(BOOL)isValidatePwd:(NSString *)pwd;

//从bundle读取图片
+ (NSString *)getFilePathFromBound:(NSString *)fileNameAndType;

//修复ios8之前的系统屏幕旋转适配
+ (CGSize)fixedScreenSize;
@end
