//
//  GWCheckOrderInfo.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/18.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    TRADE_SUCCEED,//交易成功
    TRADE_FAILED  //交易失败
}TradeStatus;

@interface GWCheckOrderInfo : NSObject

@property(nonatomic,assign)TradeStatus status;
@property(nonatomic,copy)  NSString *statusDesc;

@end
