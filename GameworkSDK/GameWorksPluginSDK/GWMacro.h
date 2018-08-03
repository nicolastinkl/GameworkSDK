//
//  GWMacro.h
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GW_NETWORK_KEY                   "c6*#e2&(g*UjX!h*"
#define GW_KEYCHAIN_SERVER              @"RWW489PPV6.com.youxigongchang.key.SDK"
#define GW_SOURCE_PARAMS                @"9e304d4e8df1b74cfa009913198428ab"
#define ISPRIVATE                       @"appstore" //是否专服 appstore是iap专服 0是非专
#define ISAPPSTORE                      @"0"        //是否越狱  1是越 0是iap
#define ISSANDBOX                       @"1"        //1是使用沙盒测试帐号0是不使用

//正式环境
#define GW_DOMAIN_RELEASE               @"http://api.mobile.youxigongchang.com/"
//测试环境
#define GW_DOMAIN_DEBUG                 @"http://test.api.mobile.youxigongchang.com/";

/*!
 *  自定义名
 */
#define KeyChain_GW_SYSTEM_UDID              @"KeyChain_GW_SYSTEM_UDID"
#define KeyChain_GW_USER_UID                 @"KeyChain_GW_USER_UIDSS"
#define KeyChain_GW_USER_USERNAME            @"KeyChain_GW_USER_USERNAME"
#define KeyChain_GW_USER_PASSWORD            @"KeyChain_GW_USER_PASSWORD"
#define KeyChain_GW_USER_NICKNAME            @"KeyChain_GW_USER_NICKNAME"
#define KeyChain_GW_USER_SESSIONTOKEN        @"KeyChain_GW_USER_SESSIONTOKEN"
#define KeyChain_GW_USER_LOGINTYPE           @"KeyChain_GW_USER_LOGINTYPE"
#define KeyChain_GW_USER_STATUS_TEMP         @"KeyChain_GW_USER_STATUS_TEMP"

#define KeyChain_GW_USERCURRENTLOGIN_UID     @"KeyChain_GW_USERCURRENTLOGIN_UID"
#define KeyChain_GW_ORDERID                  @"KeyChain_GW_ORDERID"
#define KeyChain_GW_CURRENT_AUTOREEMEBERUSRE @"KeyChain_GW_CURRENT_AUTOREEMEBERUSRE" //是否自动登录


#pragma mark NOTIFICATION

///---------------------------------------------------------------------------------------
/// @name  通知函数.常用通知...
///---------------------------------------------------------------------------------------


//进入（退出）SDK需要暂停（继续）游戏的可监听下面两个通知
#define kGWSDKOpenNotification          @"kGWSDKOpenNotification"//SDK开启通知
#define kGWSDKCloseNotification         @"kGWSDKCloseNotification"//SDK关闭通知

#define kGWtoastShowTAG                     1002

//-------------------------------PARAM-----------------------------------//
// common
#define GP_PACKAGE_ID @"package_id"
#define GP_REQUEST_NAME @"request_name"
#define GP_OPEN_ID @"openid"
#define GP_GAMEID @"gameid"
#define GP_CATEGORY @"category"
#define GP_VERSION @"version"
#define GP_RESULT @"result"
#define GP_ERROR_INFO @"errorinfo"
#define GP_OTHER_DATA @"data"
#define GP_PASSWORD @"password"
#define GP_LANGUAGE @"lang"
#define GP_SUPPORT_GZIP @"accept"
#define GP_PLATFORM @"platform"
#define GP_INFO @"info"
#define GP_PARAMS @"param"
#define GP_DATA @"data"
#define GP_SELF @"self"
#define GP_ERROR_INFO @"errorinfo"
#define GP_ERROR_INFO_RE @"exception"
#define GP_SYSTEM_OS @"os"
#define GP_SYSTEM_OS_VERSION @"osver"
#define GP_COOKIE @"cookie"
#define GP_MAC_ADDRESS @"wlan"
#define GP_SESSION_ID @"sessionid"
#define GP_CREATE_TIME @"createtime"
#define GP_CONTENT @"content"
#define GP_ID @"id"
#define GP_MOLD @"mold"
#define GP_CHANNEL @"channel"
#define GP_ROOT @"root"
#define GP_DEVICE @"device"
#define GP_GAME_KEY @"gamekey"
#define GP_DEVICETOKEN @"devicetoken"
#define GP_COOD @"cood"
#define GP_RESOLUTION @"resolution"
#define GP_SOURCE @"source"
#define GP_NETWORK @"network"
#define GP_SERVERID @"serverid"
#define GP_TEMPUSER @"tmpUser"
#define GP_SESSION @"session"

/*!
 *  宏定义函数
 */
#define F(string, args...)              [NSString stringWithFormat:string, args]

#define GWLog(xx, ...)   NSLog(xx, ##__VA_ARGS__)

#define GWInfoLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define GWDefaultLog(xx, ...)  NSLog(@"%s: " xx, __PRETTY_FUNCTION__, ##__VA_ARGS__)


///---------------------------------------------------------------------------------------
/// @name  单例函数
///---------------------------------------------------------------------------------------
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif


///---------------------------------------------------------------------------------------
/// @name  资源处理                               stringByAppendingPathComponent:@"GameWorksSDK.framework"]
///---------------------------------------------------------------------------------------


#define GWSDKBUNDLE_NAME_FRAMEWORK @"Frameworks"
#define GWSDKBUNDLE_NAME_GWFRAMEWORK @"GameWorksSDK.framework"
#define GWSDKBUNDLE_NAME_PATH @"GameWorksPluginSDK.framework"
#define GWSDKBUNDLE_NAME @"GameWorksSDKBundle.bundle"
#define GWSDKBUNDLE_PATH [[[[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: GWSDKBUNDLE_NAME_FRAMEWORK] stringByAppendingPathComponent: GWSDKBUNDLE_NAME_GWFRAMEWORK]  stringByAppendingPathComponent: GWSDKBUNDLE_NAME_PATH] stringByAppendingPathComponent: GWSDKBUNDLE_NAME]

#define GWSDKBUNDLE [NSBundle bundleWithPath: GWSDKBUNDLE_PATH]




///---------------------------------------------------------------------------------------
/// @name  PUBLIC
///---------------------------------------------------------------------------------------
#define ios7BlueColor                        [UIColor colorWithRed:0.188 green:0.655 blue:1.000 alpha:1.000]

@interface GWMacro : NSObject

@end
