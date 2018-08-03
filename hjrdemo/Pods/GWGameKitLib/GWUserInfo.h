//
//  GWUserInfo.h
//  GameKit 记录登录后的用户信息
//
//  Created by zhangzhongming on 14/12/24.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    LOGIN_SUCCEED,//成功
    LOGIN_FAILED, //失败
    LOGIN_CANCLE, //取消
    
}LoginStatus;

typedef enum : NSInteger
{
    RIGISTER_USER, //注册用户
    GUEST_USER     //游客用户
}LoginedUserType;

@interface GWUserInfo : NSObject

@property(nonatomic,assign)LoginedUserType loginUserType;//登录用户的用户类型

@property(nonatomic,copy)NSString *userID;          //id
@property(nonatomic,copy)NSString *userName;        //名称
@property(nonatomic,copy)NSString *nickName;        //昵称
@property(nonatomic,copy)NSString *userLoginToken;  //整合平台返回的token
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *CPName;          //渠道名称
@property(nonatomic,copy)NSString *cpToken;         //渠道返回的token 或者 sessionid

@end
