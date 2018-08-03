//
//  GameKitError.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/16.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    SDK_INIT_ERROR      = 100,      //平台初始化失败
    USER_UNLOGIN        = 101,      //用户未登录
    USER_CANCEL         = 102,      //用户取消了操作
    SERVER_ERROR        = 500,      //服务器发生错误
    REQUEST_ERROR       = 404,      //访问整合平台失败
    NETWORK_EXCEPTION   = 409,      //网络异常
    UNKONW_ERROR        = 9000      //未知错误
    
}ErrorCode;

@interface GWError : NSError

@property(nonatomic,assign) ErrorCode   errorCode;    //错误码
@property(nonatomic,copy)  NSString     *errorDesc;   //错误描述

@end
