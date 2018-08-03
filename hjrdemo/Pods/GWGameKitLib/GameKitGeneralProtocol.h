//
//  GameKitInterfaceProtocol.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/11.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameKitGeneralProtocol <NSObject>

@required

#pragma mark - 游戏方调用服务检测（平台方法不用检测）

#pragma mark - 基础方法
/** 检测渠道是否提供 用户名登录 服务 */
- (BOOL)hasProvide_nomal_login_service;
/** 检测渠道是否提供 快速登录 服务 */
- (BOOL)hasProvide_guest_login_service;
/** 检测渠道是否提供 快速登录用户转为注册用户 服务 */
- (BOOL)hasProvide_gusetTonomal_service;
/** 检测渠道是否提供 检查是否登录 服务 */
- (BOOL)hasProvide_isLogined_service;
/** 检测渠道是否提供 获取登录用户信息 服务 */
- (BOOL)hasProvide_getloginedUser_service;
/** 检测渠道是否提供 注销登录 服务 */
- (BOOL)hasProvide_loginout_service;
/** 检测渠道是否提供 进入用户中心 服务 */
- (BOOL)hasProvide_usercenter_service;
/** 检测渠道是否提供 切换用户 服务 */
- (BOOL)hasProvide_changeuser_service;
/** 检测渠道是否提供 openUrl 服务 */
- (BOOL)hasProvide_openurl_service;

/** 检测渠道是否提供 检查更新 服务 */
- (BOOL)hasProvide_checkupdate_service;
/** 检测渠道是否提供 支付充值 服务 */
- (BOOL)hasProvide_pay_service;
/** 检测渠道是否提供 订单查询 服务 */
- (BOOL)hasProvide_checkorder_service;
/** 检测渠道是否提供 显示/隐藏浮动窗口或者操作栏 服务 */
- (BOOL)hasProvide_showFloatWindowOrBar_service;

#pragma mark - 统计方法
/** 检查渠道是否提供 统计用户登录 服务*/
- (BOOL)hasProvide_statistics_UserLogin_service;
/** 检查渠道是否提供 统计支付 服务*/
- (BOOL)hasProvide_statistics_Pay_service;
/** 检查渠道是否提供 统计玩家创建角色 服务*/
- (BOOL)hasProvide_statistics_CreateRole_service;
/** 检查渠道是否提供 统计玩家升级 服务*/
- (BOOL)hasProvide_statistics_UserUpGrade_service;
/** 检查渠道是否提供 统计按钮点击 服务*/
- (BOOL)hasProvide_statistics_BtnClickEvent_service;

#pragma mark - 游戏生命周期相关
/** 检查渠道是否提供 响应游戏继续 事件处理服务*/
- (BOOL)hasProvide_response_continueEvent_service;
/** 检查渠道是否提供 响应游戏暂停 事件处理服务*/
- (BOOL)hasProvide_response_suspendEvent_service;
/** 检查渠道是否提供 响应游戏停止 事件处理服务*/
- (BOOL)hasProvide_response_stopEvent_service;

#pragma mark - 其他
/** 提供open url 跳转回调检测 */
- (BOOL)hasProvide_response_openurl_service;

@end
