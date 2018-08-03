//
//  GWApp.h
//  GameworkSDK
//  Copyright (c) 2014年 ___GAMEWORKS___. All rights reserved .
//

#pragma mark import
///---------------------------------------------------------------------------------------
/// @name  引入所有public类
///---------------------------------------------------------------------------------------
//#import <GameworkSDK/GWObject.h>

@class GWUser;

//! Project version number for GameworkSDK.
FOUNDATION_EXPORT double GameworkSDKVersionNumber;

//! Project version string for GameworkSDK.
FOUNDATION_EXPORT const unsigned char GameworkSDKVersionString[];

// Version
#define GAMEWORK_VERSION @"1.2.3"

// Platform
#define PARSE_IOS_ONLY (TARGET_OS_IPHONE)
#define PARSE_OSX_ONLY (TARGET_OS_MAC && !(TARGET_OS_IPHONE))

#if PARSE_IOS_ONLY
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

//Deprecated operation
#define GWDeprecated(explain) __attribute__((deprecated(explain)))

typedef void (^PFBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^PFIntegerResultBlock)(NSInteger number, NSError *error);
typedef void (^PFArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^PFDataResultBlock)(NSData *data, NSError *error);
typedef void (^PFImageResultBlock)(UIImage * image, NSError *error);
typedef void (^PFDataStreamResultBlock)(NSInputStream *stream, NSError *error);
typedef void (^PFStringResultBlock)(NSString *string, NSError *error);
typedef void (^PFIdResultBlock)(id object, NSError *error);
typedef void (^PFProgressBlock)(NSInteger percentDone);
typedef void (^PFDictionaryResultBlock)(NSDictionary * dict, NSError *error);
typedef void (^PFUserResultBlock)(GWUser *user, NSError *error);

typedef PFBooleanResultBlock        GWBooleanResultBlock;
typedef PFIntegerResultBlock        GWIntegerResultBlock;
typedef PFArrayResultBlock          GWArrayResultBlock;
typedef PFDataResultBlock           GWDataResultBlock;
typedef PFImageResultBlock          GWImageResultBlock;
typedef PFDataStreamResultBlock     GWDataStreamResultBlock;
typedef PFStringResultBlock         GWStringResultBlock;
typedef PFIdResultBlock             GWIdResultBlock;
typedef PFProgressBlock             GWProgressBlock;
typedef PFDictionaryResultBlock     GWDictionaryBlock;
typedef PFUserResultBlock           GWUserResultBlock;




#pragma mark NOTIFICATION

///---------------------------------------------------------------------------------------
/// @name  通知函数.常用通知...
///---------------------------------------------------------------------------------------
#define kGWSDKInitSuccessNotification   @"kGWSDKInitSuccessNotification"    //游戏初始化成功
#define kGWSDKInitFailNotification      @"kGWSDKInitFailNotification"       //游戏初始化失败


#define kGWSDKLoginResultNotification   @"kGWSDKLoginResultNotification"    //登录成功通知
#define kGWSDKRigisterNotification      @"kGWSDKRigisterNotification"       //注册成功通知
#define kGWSDKLogoutResultNotification  @"kGWSDKLogoutResultNotification"   //登出完成后通知
#define kGWSDKPaymentCheckResultNotification @"kGWSDKPaymentCheckResultNotification"//支付结果检测
#define kGWSDKPaymentResultNotification @"kGWSDKPaymentResultNotification"  //支付结果通知
#define kGWSDKRechargeResultNotification @"kGWSDKRechargeResultNotification"//充值结果通知

#define kGWSDKCHANGEPWDNotification      @"kGWSDKCHANGEPWDNotification"     //SDK修改密码成功

