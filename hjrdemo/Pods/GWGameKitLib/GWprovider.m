//
//  GWprovider.m
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWprovider.h"
#import "GWNetworkService.h"
#import "GWUrlhelper.h"
#import "GWCommonUtility.h"

#define SEND_UDID      @"guid"
#define SEND_ORIGINAL  @"original"
#define SEND_ORDERID   @"orderid"
#define ERROR_ALERT_MSG_  @"解析数据失败"

@implementation GWprovider

#pragma mark -  构造单例对象
+(GWprovider *)defaultProvider
{
    static GWprovider *provider;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        provider = [[GWprovider alloc] init];
    });
    return provider;
}

#pragma mark -  逻辑函数
/**
 *  生成授权token
 *
 *  @param udid        客户端唯一标示符
 *  @param original    原来的original
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */

-(void) checkValidateTokenWithUDID:(NSString *)udid
                          original:(NSString *)original
                       sucessBlock:(void (^)(GWResultToken *tokenInfo)) sucessBlock
                         failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:udid,SEND_UDID,original,SEND_ORIGINAL,nil];
    [[GWNetworkService defaultService] requestIntegrationPlatformWithUrl:[GWUrlhelper checkValidateTokenUrl:nil] params:dic sucessBlock:^(GWGeneralResult *result) {
        if(result && result.data && result.info && result.info.operationState == OperationStateSucess)
        {
            if (sucessBlock)
                sucessBlock([[GWResultToken alloc] initWithDictionary:result.data]);
        }else
        {   if(result && result.info && !result.data)
            {
                if (failedBlock) {
                    failedBlock((NSString *)result.info.operationMsg);
                }
            }else
            {
                if(failedBlock)
                    failedBlock(ERROR_ALERT_MSG_);
            }
        }
    }  failBlock:failedBlock];
}

/**
 *  获取获取订单基本信息,在整合平台上获取订单号码等信息
 *
 *  @param info        需要的订单信息
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
-(void) checkPayOrderWith:(GWPayOrder *)info
              sucessBlock:(void (^)(GWPayResultOrder *askOrderInfo)) sucessBlock
                failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    [[GWNetworkService defaultService] requestIntegrationPlatformWithUrl:[GWUrlhelper checkPayOrderNo:nil] params:[info transformationToDictionary] sucessBlock:^(GWGeneralResult *result) {
        if(result && result.data && result.info && result.info.operationState == OperationStateSucess)
        {
            if (sucessBlock)
                sucessBlock([[GWPayResultOrder alloc] initWithDictionary:result.data]);
        }else
        {
            if(result && result.info && !result.data)
            {
                if (failedBlock) {
                    failedBlock((NSString *)result.info.operationMsg);
                }
            }else
            {
                if(failedBlock)
                failedBlock(ERROR_ALERT_MSG_);
            }
        }
        
    } failBlock:failedBlock];
}


/**
 *  获取订单状态（支付结果）
 *
 *  @param orderID     订单编号
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
-(void) checkOrderState:(NSString *)orderID
            sucessBlock:(void (^)(GWPayResult *result)) sucessBlock
              failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:orderID,SEND_ORDERID, nil];
    [[GWNetworkService defaultService] requestIntegrationPlatformWithUrl:[GWUrlhelper checkOrderState:nil] params:dic sucessBlock:^(GWGeneralResult *result) {
        if(result && result.data && result.info && result.info.operationState == OperationStateSucess)
        {
            if (sucessBlock)
                sucessBlock([[GWPayResult alloc] initWithDictionary:result.data]);
        }else
        {
            if(failedBlock)
                failedBlock(ERROR_ALERT_MSG_);
        }
        
    } failBlock:failedBlock];
}

//用户信息验证   不是每个sdk都需要调用这个接口
-(void) validateUserInfo:(NSDictionary *)data
             sucessBlock:(void (^)(NSDictionary *resData)) sucessBlock
               failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    [[GWNetworkService defaultService] requestIntegrationPlatformWithUrl:[GWUrlhelper validateUserInfo:nil] params:data sucessBlock:^(GWGeneralResult *result) {
        if(result && result.data && result.info && result.info.operationState == OperationStateSucess)
        {
            if (sucessBlock)
                sucessBlock(result.data);//具体的每个数据可以延后判断
        }else
        {
            if(failedBlock)
                failedBlock(ERROR_ALERT_MSG_);
        }
    }  failBlock:failedBlock];
}


//临时用户登录
- (void) touristLoginWithBlock:(void (^)(GWTouristUserInfo *touristUserInfo)) sucessBlock
                     failBlock:(void (^)(NSString *errorMsg)) failedBlock
{
    [[GWNetworkService defaultService] requestIntegrationPlatformWithUrl:[GWUrlhelper touristLoginUrl:nil] params:nil sucessBlock:^(GWGeneralResult *result) {
        if(result && result.data && result.info && result.info.operationState == OperationStateSucess)
        {
            GWTouristUserInfo *userInfo = [[GWTouristUserInfo alloc] initWithDictionary:result.data];
            if (userInfo.session)
                [GWCommonUtility setGameSession:userInfo.session];
            if (sucessBlock)
                sucessBlock(userInfo);
        }else
        {
            if(failedBlock)
                failedBlock(ERROR_ALERT_MSG_);
        }
    } failBlock:failedBlock];
}

@end
