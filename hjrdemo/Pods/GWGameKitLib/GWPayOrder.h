//
//  GWPayOrder.h
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/7.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWPayOrder : NSObject

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
/**
 *  将GWPlayOrder 转化为NSDictionary
 *
 *  @param order 平台订单信息
 *
 *  @return NSDictionary
 */
- (NSDictionary *)transformationToDictionary;

@end
