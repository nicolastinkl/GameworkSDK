//
//  NSString+Device.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/13.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import  <netinet6/in6.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if_dl.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import  <netinet/in.h>
#import  <arpa/inet.h>
#import  <ifaddrs.h>
#import  <netdb.h>
#include <net/if.h>

typedef enum : NSUInteger
{
    GWNetWork_4G   = 0,
    GWNetWork_3G   = 1,
    GWNetWork_WIFI = 2,
    GWNetWork_2G   = 3,
    GWNetWork_NotReachable = -1,
    
} GWNetWorkType;


@interface NSString (Device)

// 获取网络连接状态
+ (GWNetWorkType) getNetWorkStates;
+ (GWNetWorkType) getDeviceNetworkState;
+ (GWNetWorkType) getDeviceNetWorkState_4G_Version;//支持4G检测

+ (BOOL) connectedToNetwork; // 手机是否可以联网
+ (BOOL) iOSHaveJailbreaking;// 手机是否越狱

+ (NSString *) achieveMacAddress;      //获取mac
+ (NSString *) getCurrentDeviceModel;  //获取硬件型号
+ (NSString *) iOSCurrnetLangage;      //获取手机语言设置
+ (NSString *) iOSCurrnetResolution;   //手机分辨率
+ (NSString *) iOSCurrnetSystemName;   //操作系统名称
+ (NSString *) iOSCurrnetSystemVersion;//操作系统版本
+ (CTCarrier *)iOSCarrieroperator;     //获取手机运营商

@end
