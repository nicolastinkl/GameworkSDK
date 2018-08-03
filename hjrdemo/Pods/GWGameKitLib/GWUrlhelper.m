//
//  GWUrlhelper.m
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWUrlhelper.h"
#import "GWDefine.h"


@implementation GWUrlhelper

/**
 *  动态构建url
 *
 *  @param params 参数列表
 *
 *  @return url-patter
 */

+ (NSMutableString *) buildUrl:(NSDictionary *)params;
{
    NSParameterAssert(params);
    if ([params count] == 0) {
        return nil;
    }
    NSMutableString *patter = [[NSMutableString alloc] init];
    for (NSString *key in [params allKeys]) {
         NSString  *value = [params objectForKey:key];
        [patter appendFormat:@"&%@=%@",key,value];
    }
    return patter;
}

/**
 *  获取验证token url
 *
 *  @param params 参数列表
 *
 *  @return url
 */
+ (NSString *) checkValidateTokenUrl:(NSDictionary *)params
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",BaseUrl,ValidateTokenUrl];
    if (params) {
        url = [url stringByAppendingString:[self buildUrl:params]];
    }
    return url;
}

/**
 *  在整合平台获取订单号码
 *
 *  @param params 参数列表
 *
 *  @return url
 */
+ (NSString *) checkPayOrderNo:(NSDictionary *)params
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",BaseUrl,PayOrderNoUrl];
    if (params) {
        url = [url stringByAppendingString:[self buildUrl:params]];
    }
    return url;
}

/**
 *  获取订单状态
 *
 *  @param params 参数
 *
 *  @return url
 */
+ (NSString *) checkOrderState:(NSDictionary *)params
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",BaseUrl,OrderStateUrl];
    if (params) {
        url = [url stringByAppendingString:[self buildUrl:params]];
    }
    return url;
}

// 用户信息验证
+ (NSString *) validateUserInfo:(NSDictionary *)params
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",BaseUrl,UserInfoValidate];
    if (params) {
        url = [url stringByAppendingString:[self buildUrl:params]];
    }
    return url;
}

// 临时用户登录
+ (NSString *) touristLoginUrl:(NSDictionary *)parmas
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",BaseUrl,TouristLogin];
    if (parmas) {
        url = [url stringByAppendingString:[self buildUrl:parmas]];
    }
    return url;
}


@end
