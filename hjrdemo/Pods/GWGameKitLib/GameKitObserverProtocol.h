//
//  GameKitResponseProtocol.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/16.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GWPayBackInfo.h"
#import "GWUpdateInfo.h"
#import "GWUserInfo.h"
#import "GWCheckOrderInfo.h"
#import "GWError.h"

@protocol GameKitObserverProtocol <NSObject>

@optional

/**平台初始化回调函数*/
-(void)gameKitInitCompletedISSucceedStatus:(BOOL) isSucceed error:(GWError *)error;

/**注册成功回调函数*/
-(void)rigisterCompletedWithResponseData:(GWUserInfo *)obj;

/**登录回调接口*/
-(void)loginCompletedWithLoginStatus:(LoginStatus)loginStatus responseObj:(GWUserInfo *)obj error:(GWError *)error;

/**支付回调接口*/
-(void)payCompletedWithPayStatus:(PayStatus)payStatus responseObj:(GWPayBackInfo *)obj error:(GWError *)error;

/**登录注销完成回调*/
-(void)LoginOutCompletedISSucceedStatus:(BOOL) isSucceed error:(GWError *)error;

/**订单查询*/
-(void)checkOrderCompletedWithData:(GWCheckOrderInfo *)obj error:(GWError *)error;

/**检查更新获取回调数据*/
-(void)checkUpdateCompletedWithData:(GWUpdateInfo *)obj error:(GWError *)error;

/*
 * 退出平台界面回调通知（仅仅涉及到登录界面可以关闭的渠道）
 * 如果渠道的登录界面或者切换账号界面不能直接关闭则 没有此回调信息返回
 */
-(void)leavSDKPlatform;
@end
