//
//  GWResultToken.h
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/19.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  第三方平台获取的token信息
 */
@interface GWResultToken : NSObject

@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *cp;
@property(nonatomic,copy)NSString *guid;
@property(nonatomic,copy)NSString *original;//需要进行base64解密

//构造方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
