//
//  GWPayResultOrder.m
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import "GWPayResultOrder.h"

#define ORDER_GAMEID       @"gameid"
#define ORDER_GAMENAME     @"gamename"
#define ORDER_ORDER_ID     @"order_number"
#define ORDER_CREATE_TIME  @"create_time"

@implementation GWPayResultOrder

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary) {
            
            if (dictionary[ORDER_GAMEID] && [dictionary[ORDER_GAMEID] isKindOfClass:[NSString class]])
                self.gameId = dictionary[ORDER_GAMEID];
            if (dictionary[ORDER_GAMENAME] && [dictionary[ORDER_GAMENAME] isKindOfClass:[NSString class]])
                self.gameName = dictionary[ORDER_GAMENAME];
            if (dictionary[ORDER_ORDER_ID] && [dictionary[ORDER_ORDER_ID] isKindOfClass:[NSString class]])
                self.orderID = dictionary[ORDER_ORDER_ID];
            if (dictionary[ORDER_CREATE_TIME] && [dictionary[ORDER_CREATE_TIME] isKindOfClass:[NSString class]])
                self.createTime = dictionary[ORDER_CREATE_TIME];
        }
    }
    return self;
}

@end
