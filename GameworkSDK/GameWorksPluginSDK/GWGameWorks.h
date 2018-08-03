//
//  GWGameworks.h
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  屏幕适配模式：
    0 横屏自动旋转
    1 竖屏自动旋转
    2 横屏居右
    3 横屏居左
    4 竖屏正常
    5 竖屏反方向
 */
typedef enum GWRotateMode : NSUInteger {
    GWRotateModeLandscapeAuto       = 0,
    GWRotateModePortraitAuto        = 1,
    GWRotateModeLandscapeRight      = 2,
    GWRotateModeLandscapeLeft       = 3,
    GWRotateModePortrait            = 4,
    GWRotateModePortraitUpsideDown  = 5
    
} GWRotateMode;

/*!
 * 日志级别
 */
typedef enum GWLogLevel : NSUInteger {
    GWLogLevelNone      = 0,
    GWLogLevelError     = 1 << 0,
    GWLogLevelWarning   = 1 << 1,
    GWLogLevelInfo      = 1 << 2,
    GWLogLevelVerbose   = 1 << 3,
    GWLogLevelDefault   = GWLogLevelError | GWLogLevelWarning
} GWLogLevel;


typedef enum GWSDKBundle:NSUInteger{
    GWSDKBundleGameworks = 0,
    GWSDKBundleForgame = 1,
    GWSDKBundleSkyDream = 2
}GWSDKBundle;


/**
 *  GWGameworks is the main Class for Gameworks SDK
 */
@interface GWGameWorks : NSObject

/*!
*  Connecting to Gameworks
*
*  @discussion 该方法应在 "- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions" 中调用
*
*  @param gameKey   gameKey     geme Key
*  @param channelid channelid   channel id
*  @param gwrotate  gwrotate    screen rotate mode
*/
+ (void)setApplicationGameKey:(NSString *)gameKey ChannelID:(NSString *)channelid RotateMode:(GWRotateMode ) gwrotate;

/*!
 *  Settings current sdk's bundle files with sources.
 *
 *  @param bundletype type
 */
+ (void)setApplicationGameBundle:(GWSDKBundle )bundletype;

/**
 *  get Application GameKey
 *
 *  @return Application GameKey
 */
+ (NSString *)getApplicationGameKey;

/**
 *  get ChannelID Key
 *
 *  @return ChannelID Key
 */
+ (NSString *)getChannelID;

/**
 *  *  get the timeout interval fo
 *
 *  @return timeout interval
 */
+ (NSTimeInterval)networkTimeoutInterval;

/**
 *  set the timeout interval for net request
 *   default timeout is 10s.
 *
 *  @param time  timeout interval
 */
+ (void)setNetworkTimeoutInterval:(NSTimeInterval)time;

/*!
 *  set log level
 *
 *  @param level enum of log-leve
 */
+ (void)setLogLevel:(GWLogLevel)level;

/*!
 *  get log level
 *
 *  @return log-level
 */
+ (GWLogLevel)logLevel;

/**
 *  Set call what production mode's  code
 *
 *  @param isProduction the production mode or test mode
 */
+ (void)setProductionMode:(BOOL)isProduction;

/*!
 *  开始游戏时需要设置的主函数
 @since 具体函数请参考 https://bitbucket.org/gameworks/gwgamekitlib/issue
 */
+ (void)startGameWorks;

/*!
 *  切换用户帐号 or 重新登录
 */
+ (void)exchangeUserAccountAction;

/*!
 *  显示用户中心
 */
+ (void)showGWSDKUserCenterViewController;

/*!
 *  显示支付中心
 *
 *  @param payorder 订单信息 //GWSDKPayPluginOrder
 */
+ (void)showGWSDKPaymentViewController:(id)payorder;

/*!
 *  显示支付记录
 */
+ (void)showGWSDKPaymentHistoryViewController;

/*!
 *  显示登录中心
 */
+ (void)showGWSDKUserLoginCenterViewController;

/*!
 *  显示游客登录中心
 */
+ (void)showGWSDKtempUserLoginCenterViewController;

/*!
 *  检查订单状态
 */
+ (void) checkorderstatusblock:(void(^)(BOOL succeeded, NSString *string,NSString *msg))successResultBlock;

/*!
 *  设置浮标显示
 */
+ (void) showBanner:(BOOL) show;

/*!
 *  设置浮标隐藏
 */
+ (void) hiddenBanner:(BOOL) hidden;

@end
