//
//  GWPayResult.h  支付结果查询
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

/**
 //Sucess
 _Sucess_OrderState                       =  1,  //已经下单
 _Sucess_ApplyTo3PlatformState            =  2,  //已向第三方平台申请
 _Sucess_Recived3PlatformState            =  5,  //已收到第三方支付成功
 _Sucess_GameRechargeState                =  6,  //向游戏充值
 _Sucess_RechargeState                    =  7,  //游戏充值成功
 _Sucess_RechargeCompletedState           =  8,  //充值完成
 
 //Failed
 _Failed_State                            =  1000 //订单操作失败
 */

#import "GWNetworkBase.h"

/**
    修改：0:成功  非0:失败
 */
typedef enum : NSUInteger
{
    _Sucess_OrderStatus =0,
    _Failed_OrderStatus
} OrderStatus;


@interface GWPayResult : GWNetworkBase

@property(nonatomic,assign)OrderStatus status;        //订单状态
@property(nonatomic,copy)  NSString   *desc;          //失败原因

//构造方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
