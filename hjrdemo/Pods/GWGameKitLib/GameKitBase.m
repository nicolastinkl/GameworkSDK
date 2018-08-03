//
//  GameKitBase.m
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GameKitBase.h"
#import "GWLogUtility.h"
#import "Private.h"


@implementation GameKitBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak GameKitBase *self_ = self;
        
        ParaseSucessCallBack sucessBlock = ^(GameKitConfigure *config)
        {
            __strong GameKitBase *_self = self_;
            if (_self) {
                _self.gameKitConfigure = config;
                _self.parserSucessed = YES;
                NSLog(@"配置文件解析完成:    \n%@",[config descGameKitConfigure]);
            }
        };
        
        ParaseFaildCallBack faidBlock = ^(NSString *errorMsg)
        {
            __strong GameKitBase *_self = self_;
            if (_self) {
                _self.gameKitConfigure = nil;
                _self.parserSucessed = NO;
                NSLog(@"%@",errorMsg);
            }
        };
        [[[GWSysConfingureManager alloc] initWithXML] startParserWithSucessBlock:sucessBlock faildBlock:faidBlock];
    }
    return self;
}

#pragma mark -  服务功能检测服务接口
/** 检测渠道是否提供 登录 服务 */
- (BOOL)hasProvide_nomal_login_service
{
    return response_nomal_login == 1?YES:NO;
}

- (BOOL)hasProvide_guest_login_service
{
    return response_guest_login == 1?YES:NO;
}

- (BOOL)hasProvide_gusetTonomal_service
{
    return response_gusetTonomal == 1?YES:NO;
}

- (BOOL)hasProvide_isLogined_service
{
    return response_isLogined == 1?YES:NO;
}

- (BOOL)hasProvide_getloginedUser_service
{
    return response_loginedUser == 1?YES:NO;
}

- (BOOL)hasProvide_openurl_service
{
    return response_openurl == 1?YES:NO;
}

/** 检测渠道是否提供 检查更新 服务 */
- (BOOL)hasProvide_checkupdate_service
{
    return response_checkupdate == 1?YES:NO;
}
/** 检测渠道是否提供 支付充值 服务 */
- (BOOL)hasProvide_pay_service
{
    return response_pay == 1?YES:NO;
}
/** 检测渠道是否提供 订单查询 服务 */
- (BOOL)hasProvide_checkorder_service
{
    return response_checkorder == 1?YES:NO;
}
/** 检测渠道是否提供 注销登录 服务 */
- (BOOL)hasProvide_loginout_service
{
    return response_loginout == 1?YES:NO;
}
/** 检测渠道是否提供 进入用户中心 服务 */
- (BOOL)hasProvide_usercenter_service
{
    return response_usercenter == 1?YES:NO;
}
/** 检测渠道是否提供 切换用户 服务 */
- (BOOL)hasProvide_changeuser_service
{
    return response_changeuser == 1?YES:NO;
}

/** 检测渠道是否提供 显示/隐藏浮动窗口或者操作栏 服务 */
- (BOOL)hasProvide_showFloatWindowOrBar_service
{
    return response_showFloatWindowOrBar == 1?YES:NO;
}


/** 检查渠道是否提供 统计用户登录 服务*/
- (BOOL)hasProvide_statistics_UserLogin_service
{
    return response_statistics_UserLogin == 1?YES:NO;
}
/** 检查渠道是否提供 统计支付 服务*/
- (BOOL)hasProvide_statistics_Pay_service
{
    return response_statistics_Pay == 1?YES:NO;
}
/** 检查渠道是否提供 统计玩家创建角色 服务*/
- (BOOL)hasProvide_statistics_CreateRole_service
{
    return response_statistics_CreateRole == 1?YES:NO;
}
/** 检查渠道是否提供 统计玩家升级 服务*/
- (BOOL)hasProvide_statistics_UserUpGrade_service
{
    return response_statistics_UserUpGrade == 1?YES:NO;
}
/** 检查渠道是否提供 统计按钮点击 服务*/
- (BOOL)hasProvide_statistics_BtnClickEvent_service
{
    return response_statistics_BtnClickEvent == 1?YES:NO;
}

/** 检查渠道是否提供 响应游戏继续 事件处理服务*/
- (BOOL)hasProvide_response_continueEvent_service
{
    return response_continueEvent == 1?YES:NO;
}
/** 检查渠道是否提供 响应游戏暂停 事件处理服务*/
- (BOOL)hasProvide_response_suspendEvent_service
{
    return response_suspendEven == 1?YES:NO;
}
/** 检查渠道是否提供 响应游戏停止 事件处理服务*/
- (BOOL)hasProvide_response_stopEvent_service
{
    return response_stopEvent == 1?YES:NO;
}
/** 检查渠道是否提供 openurl 跳转回到 事件处理服务*/
- (BOOL)hasProvide_response_openurl_service
{
    return response_openurl == 1?YES:NO;
}
@end
