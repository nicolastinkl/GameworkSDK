//
//  GWUrlhelper.h
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWNetworkBase.h"

@interface GWUrlhelper : GWNetworkBase

/**
 *  动态构建url
 *
 *  @param params 参数列表
 *
 *  @return url-patter
 */

+ (NSMutableString *) buildUrl:(NSDictionary *)params;

/**
 *  获取验证token url
 *
 *  @param params 参数列表
 *
 *  @return url
 */
+ (NSString *) checkValidateTokenUrl:(NSDictionary *)params;

/**
 *  在整合平台获取订单号码
 *
 *  @param params 参数列表
 *
 *  @return url
 */
+ (NSString *) checkPayOrderNo:(NSDictionary *)params;

/**
 *  获取订单状态
 *
 *  @param params 参数
 *·
 *  @return url
 */
+ (NSString *) checkOrderState:(NSDictionary *)params;


/**
 *  用户信息验证
 *
 *  @param params 参数
 *
 *  @return url
 */
+ (NSString *) validateUserInfo:(NSDictionary *)params;


/**
 *  临时用户登录
 *
 *  @param parmas 参数
 *
 *  @return url
 */
+ (NSString *) touristLoginUrl:(NSDictionary *)parmas;

@end
