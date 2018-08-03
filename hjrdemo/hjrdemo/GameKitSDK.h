//
//  GameKitSDK.h
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <GameKitBase.h>
#import <GameKitObserverProtocol.h>
#import <GWUserInfo.h>
#import <GWPayOrder.h>
#import <GameKitInitParam.h>

@interface GameKitSDK : GameKitBase

#pragma mark - 平台初始化相关
// 获取单例对象
+ (GameKitSDK *)defaultSdk;
//注册统一回调函数
- (void)initWithObserver:(id<GameKitObserverProtocol>) observer params:(GameKitInitParam *)params;

#pragma mark  - 用户相关
- (void)nomalLogin;             //登录
- (void)guestLogin;             //游客登录(快速登录)
- (void)guestRegist;            //游客转为注册账号
- (bool)isLogined;              //是否登录
- (void)loginOut;               //注销登录
- (void)userCenter;             //用户中心
- (void)swapAccount;            //切换用户
- (GWUserInfo *)loginUserInfo;  //获取登录用户信息

#pragma mark  - 支付相关
- (void)pay:(GWPayOrder *)order;//提交订单
- (void)checkOrder:(NSString *)orderId;//查询订单（非必须接入）

#pragma mark - 用户平台相关

- (void)showFloatWindowOrBar:(BOOL) isShow;// 是否显示浮动窗口或者操作栏
- (void)checkUpdate;//检查更新

#pragma mark - 数据统计相关
//用户登录统计
- (void)statisticsUserLogin:(NSDictionary *)info;
// 支付统计
- (void)statisticsPay:(NSDictionary *)order;
// 玩家升级统计
- (void)statisticsUserUpGrade:(NSDictionary *)info;
// 玩家创建角色统计
- (void)statisticsCreateRole:(NSDictionary *)info;
// 按钮点击统计（非必须接入）
- (void)statisticsBtnClickEvent:(NSDictionary *)info;

#pragma mark - 游戏生命周期相关
//继续游戏
- (void)gameContinueEvent;
//暂停游戏
- (void)gameSuspendEvent;
//停止游戏
- (void)gameStopEvent;
//open url 跳转响应

#pragma mark - 其他

- (void)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation;
@end
