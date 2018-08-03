//
//  GWSDKPayPluginOrder.m
//  GameWorksPluginSDK
//
//  Created by tinkl on 26/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPayPluginOrder.h"

@implementation GWSDKPayPluginOrder


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


@end
