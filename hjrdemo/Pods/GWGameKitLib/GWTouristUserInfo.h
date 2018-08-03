//
//  GWTouristUserInfo.h
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWTouristUserInfo : NSObject

@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *session;
@property(nonatomic,copy)NSString *nickname;

//构造方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
