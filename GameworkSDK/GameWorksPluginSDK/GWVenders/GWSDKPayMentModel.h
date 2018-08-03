//
//  GWSDKPayMentModel.h
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "JSONModel.h"


@protocol GWSDKPayMentModelSUB
@end


/*!
 *  游戏支付方式列表
 */
@class GWSDKPayMentModelSUB;
@interface GWSDKPayMentModel : JSONModel

@property (strong, nonatomic) NSString<Optional> *code;
@property (strong, nonatomic) NSString<Optional> *icon;
@property (strong, nonatomic) NSString<Optional> *gameid;
@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *desc;

@property (strong, nonatomic) NSArray<GWSDKPayMentModelSUB,Optional>* sub;

@end


/*!
 *  游戏支付方式子列表
 */
@interface GWSDKPayMentModelSUB : JSONModel

@property (strong, nonatomic) NSString<Optional> *code;
@property (strong, nonatomic) NSString<Optional> *desc;
@property (strong, nonatomic) NSString<Optional> *channelid;
@property (strong, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSString<Optional> *off_swith_icon;
@property (strong, nonatomic) NSString<Optional> *on_swith_icon;

@end

/*!
 *  游戏信息
 */
@interface GWSDKPayGameINFO : JSONModel

@property (strong, nonatomic) NSString<Optional> *account;
@property (strong, nonatomic) NSString<Optional> *allow;
@property (strong, nonatomic) NSString<Optional> *gameid;
@property (strong, nonatomic) NSString<Optional> *gamename;
@property (strong, nonatomic) NSString<Optional> *mobile;
@property (strong, nonatomic) NSString<Optional> *rate;

@end

/*!
 *  支付历史信息
 
 amount = 1;
 channelid = 19;
 "create_time" = 1421757378;
 gamename = "";
 icon = "http://static.youxigongchang.com/upload/recharge/201407/30/nfjnLK.png";
 monthTotalAmount = 12;
 "order_number" = 1501207003000045;
 payid = 10;
 paymentname = "dW5pb25wYXk=";
 status = 1;
 
 */
@interface GWSDKPayHistoryGameINFO : JSONModel

@property (strong, nonatomic) NSString<Optional> *create_time;
@property (strong, nonatomic) NSString<Optional> *order_number;
@property (strong, nonatomic) NSString<Optional> *gamename;
@property (strong, nonatomic) NSString<Optional> *icon;
@property (strong, nonatomic) NSString<Optional> *paymentname;
@property (strong, nonatomic) NSString<Optional> *amount;
@property (strong, nonatomic) NSString<Optional> *status;
@property (strong, nonatomic) NSString<Optional> *monthTotalAmount;
@property (strong, nonatomic) NSString<Optional> *channelid;

@end


