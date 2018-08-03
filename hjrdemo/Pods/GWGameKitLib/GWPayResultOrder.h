//
//  GWPayResultOrder.h
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  整合平台返回的订单信息
 */
@interface GWPayResultOrder : NSObject

@property(nonatomic,copy)NSString *gameId;
@property(nonatomic,copy)NSString *gameName;
@property(nonatomic,copy)NSString *orderID;
@property(nonatomic,copy)NSString *createTime;

//构造方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
