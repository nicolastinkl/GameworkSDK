//
//  GWSDKPayPluginOrder.h
//  GameWorksPluginSDK
//
//  Created by tinkl on 26/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWSDKPayPluginOrder : NSObject

@property (nonatomic,assign) double      amount;             //支付金额
@property (nonatomic,copy)   NSString   *orderNo;            //外部订单号
@property (nonatomic,assign) NSInteger   productId;          //商品ID
@property (nonatomic,copy)   NSString   *productName;        //商品名称
@property (nonatomic,assign) NSInteger   productCount;       //商品数量
@property (nonatomic,copy)   NSString   *notifyUrl;          //自定义回调地址
@property (nonatomic,copy)   NSString   *payDescription;     //商户私有信息
@property (nonatomic,copy)   NSString   *roleId;             //角色ID
@property (nonatomic,copy)   NSString   *zoneId;             //游戏分区ID
@property (nonatomic,copy)   NSString   *gameextend;         //游戏扩展参数
@property (nonatomic,copy)   NSString   *productDisplayTitle;//支付显示 名称

@end
