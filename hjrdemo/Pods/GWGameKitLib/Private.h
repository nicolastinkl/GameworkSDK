//
//  Private.h
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

/**
 *  私有定义文件   针对具体的SDK
 */
#ifndef GameKit_Private_h
#define GameKit_Private_h

//功能配置文件
#define response_nomal_login                1   //是否提供正常登录 登陆 功能        常规接口
#define response_guest_login                1   //是否提供游客登录
#define response_gusetTonomal               1   //是否提供游客账号变为正常账号
#define response_isLogined                  1   //判断是否登录                    常规接口
#define response_loginedUser                1   //获取已经登录的用户信息           常规接口


#define response_checkupdate                0   //是否提供检查更新 功能
#define response_pay                        1   //是否提供支付 功能               常规接口
#define response_checkorder                 1   //是否提供订单查询 功能            常规接口
#define response_loginout                   1   //是否提供注销登陆 功能
#define response_usercenter                 1   //是否提供用户中心 功能
#define response_changeuser                 1   //是否提供切换用户 功能
#define response_showFloatWindowOrBar       1   //是否提供显示或者隐藏悬浮框 功能


#define response_statistics_UserLogin       0   //是否提供 统计用户登录 功能
#define response_statistics_Pay             0   //是否提供 统计支付 功能
#define response_statistics_CreateRole      0   //是否提供 创建角色 功能
#define response_statistics_UserUpGrade     0   //是否提供 玩家升级 功能
#define response_statistics_BtnClickEvent   0   //是否提供 按钮点击 功能

#define response_continueEvent              0   //是否提供 继续游戏 功能
#define response_suspendEven                0   //是否提供 暂停游戏 功能
#define response_stopEvent                  0   //是否提供 停止游戏 功能
#define response_openurl                    0   //程序跳转回调

#endif
