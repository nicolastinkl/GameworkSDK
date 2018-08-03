//
//  GWprovider.h
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWPayResult.h"
#import "GWTouristUserInfo.h"
#import "GWPayResult.h"
#import "GWPayResultOrder.h"
#import "GWResultToken.h"
#import "GWPayOrder.h"

@interface GWprovider : NSObject

/**
 *  获取单例对象
 *
 *  @return
 */
+ (GWprovider *)defaultProvider;

/**
 *  生成授权token
 *
 *  @param udid     唯一标示
 *  @param original 原有token
 *  @param sucessBlock 成功回调
 *  @param failBlock   失败回调
 */
- (void) checkValidateTokenWithUDID:(NSString *)udid
                           original:(NSString *)original
                        sucessBlock:(void (^)(GWResultToken *tokenInfo)) sucessBlock
                          failBlock:(void (^)(NSString *errorMsg)) failedBlock;
/**
 *  在整合平台获取订单号码
 *
 *  @param info 获取订单必备信息
 *  @param sucessBlock 成功回调
 *  @param failBlock   失败回调
 *
 *  @return 订单号码
 */
- (void) checkPayOrderWith:(GWPayOrder *)info
               sucessBlock:(void (^)(GWPayResultOrder *askOrderInfo)) sucessBlock
                 failBlock:(void (^)(NSString *errorMsg)) failedBlock;
/**
 *  获取订单状态
 *
 *  @param orderID     订单编号
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
- (void) checkOrderState:(NSString *)orderID
             sucessBlock:(void (^)(GWPayResult *result)) sucessBlock
               failBlock:(void (^)(NSString *errorMsg)) failedBlock;

/**
 *  用户信息验证
 *
 *  @param data        需要验证的数据
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
- (void) validateUserInfo:(NSDictionary *)data
              sucessBlock:(void (^)(NSDictionary *resData)) sucessBlock
                failBlock:(void (^)(NSString *errorMsg)) failedBlock;

/**
 *  临时用户登录  
 *
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
- (void) touristLoginWithBlock:(void (^)(GWTouristUserInfo *touristUserInfo)) sucessBlock
                 failBlock:(void (^)(NSString *errorMsg)) failedBlock;
@end
