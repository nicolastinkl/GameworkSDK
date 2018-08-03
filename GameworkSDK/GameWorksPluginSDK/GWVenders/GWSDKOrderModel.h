//
//  GWSDKOrderModel.h
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
/*!
 *  //gameid  payid channelid amount mobile captcha mail serverid cardno
    //cardkey  country  gameextend  gameuserid game_product_name
    这里订单信息
 */
@interface GWSDKOrderModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *gameid;   //OK
@property (strong, nonatomic) NSString<Optional> *payid;    //OK
@property (strong, nonatomic) NSString<Optional> *channelid;//OK
@property (assign, nonatomic) double           amount;   //...金额
@property (strong, nonatomic) NSString<Optional> *mobile;   //OK
@property (strong, nonatomic) NSString<Optional> *captcha;  //OK
@property (strong, nonatomic) NSString<Optional> *captchaurl;
@property (strong, nonatomic) NSString<Optional> *mail;     //OK keyMapper
@property (strong, nonatomic) NSString<Optional> *serverid; //...服务器id
@property (strong, nonatomic) NSString<Optional> *cardno;   //...充值卡卡号
@property (strong, nonatomic) NSString<Optional> *cardkey;  //...充值卡密码
@property (strong, nonatomic) NSString<Optional> *country;  //OK
@property (strong, nonatomic) NSString<Optional> *gameextend;   //游戏扩展参数
@property (strong, nonatomic) NSString<Optional> *gameuserid;   //游戏用户ID
@property (strong, nonatomic) NSString<Optional> *game_product_name;//商品名称
@property (strong, nonatomic) NSString<Optional> *timestamp;

@end
