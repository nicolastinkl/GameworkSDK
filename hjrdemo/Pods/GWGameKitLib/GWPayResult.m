//
//  GWPayResult.m
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWPayResult.h"
#import "GWCommonUtility.h"

#define ORDER_STATUS @"status"
#define ORDER_DESC   @"desc"

@implementation GWPayResult

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary) {
            if (dictionary[ORDER_STATUS] && [dictionary[ORDER_STATUS] isKindOfClass:[NSString class]] && [GWCommonUtility isPureInt:dictionary[ORDER_STATUS]]){
                if ([dictionary[ORDER_STATUS] intValue] == 0)
                    self.status = _Sucess_OrderStatus;
                else
                    self.status = _Failed_OrderStatus;
            }
            
            if (dictionary[ORDER_DESC]) {
                self.desc = dictionary[ORDER_DESC];
            }
        }
    }
    return self;
}

@end
