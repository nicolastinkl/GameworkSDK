//
//  GWPayOrder.m
//  GamePluginSDK  支付订单信息
//
//  Created by zhangzhongming on 14/11/7.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWPayOrder.h"
#import "GWDefine.h"

@implementation GWPayOrder


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.amount = 0.0f;
        self.orderNo = @"";
        self.productId = 0;
        self.productName = @"";
        
        self.productCount = 0;
        self.notifyUrl = @"";
        self.payDescription = @"";
        self.roleId = @"";
        
        self.zoneId = @"";
        self.gameextend = @"";
        self.productDisplayTitle = @"";
    }
    return self;
}

// 订单转化为NSDictionary
- (NSDictionary *)transformationToDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.amount)
        [dic setObject:@(self.amount) forKey:GW_AMOUNT];
    if (self.productCount)
        [dic setObject:@(self.productCount) forKey:GW_PNUM];
    if (self.orderNo)
        [dic setObject:self.orderNo forKey:GW_ORDER_NO];
    if (self.zoneId)
        [dic setObject:self.zoneId forKey:GW_SERVERID];
    if (self.productId)
        [dic setObject:@(self.productId) forKey:GW_PID];
    if (self.gameextend)
        [dic setObject:self.gameextend forKey:GW_GAME_EXTEND];
    if (self.notifyUrl) {
        [dic setObject:self.notifyUrl forKey:GW_NOTIFY_URL];
    }
    return dic;
}

@end
