//
//  GWObject.h
//  GameworksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GWGameworks.h"

@interface GWObject : NSObject

+(GWObject*) sharedGWObject;

@property (nonatomic,strong) NSString       * GWGAMEKEY;     //游戏key
@property (nonatomic,strong) NSString       * GWCHANNELID;   //游戏渠道ID
@property (nonatomic,assign) GWRotateMode   GWROTATEMODE;    //屏幕适配模式
@property (nonatomic,assign) GWSDKBundle    GWSDKBundleTYPE; //设置游戏资源方
@property (nonatomic,assign) NSTimeInterval NETWORKTIME;     //网络超时设置
@property (nonatomic,assign) GWLogLevel     LOGLEVEL;        //设置日志级别
@property (nonatomic,assign) BOOL           isPRODECTION;    //是否debug模式或者产品模式
@property (nonatomic,strong) NSString       * GWDEVICETOKENID;   //apns  push 通知token
@property (nonatomic,strong) NSString       * GWSERVERIP;    //服务器返回IP地址


@property (nonatomic,strong) NSString       * GWPASSSERVICETEL;     //客服电话
@property (nonatomic,strong) NSString       * GWSERVICETEL;         //支付方式电话
@property (nonatomic,strong) NSString       * GWSERVICEQQ;          //游戏qq

@property (nonatomic,strong) NSString       * GWSERVER_S_ID;
@property (nonatomic,strong) NSString       * GWSERVER_S_NO;
@property (nonatomic,strong) NSString       * GWSERVER_S_NAME;


@end
