//
//  GWTouristUserInfo.m
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import "GWTouristUserInfo.h"

#define UID      @"uid"
#define SESSION  @"session"
#define NICKNAME @"nickname"

@implementation GWTouristUserInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary) {
            if (dictionary[UID] && [dictionary[UID] isKindOfClass:[NSString class]])
                self.uid = dictionary[UID];
            if (dictionary[SESSION] && [dictionary[SESSION] isKindOfClass:[NSString class]])
                self.session = dictionary[SESSION];
            if (dictionary[NICKNAME] && [dictionary[NICKNAME] isKindOfClass:[NSString class]])
                self.nickname = dictionary[NICKNAME];
        }
    }
    return self;
}

@end
