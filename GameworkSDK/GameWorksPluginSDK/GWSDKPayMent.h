//
//  GWSDKPayMent.h
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWApp.h"
#import "GWSDKOrderModel.h"

@interface GWSDKPayMent : NSObject

/*!
 *  获取IAP列表信息
 *
 *  @param block 回调信息数据
 */
+ (void) requestIAPDataInBackgroundBlock:(PFArrayResultBlock)block
                                   block:(GWIdResultBlock)gameblock;

/*!
 *  添加订单
 *
 *  @param channelID channelID description
 *  @param gameID    gameID description
 *  @param block     block description
 */
+ (void) requestOrderAddInBackground:(NSString *)channelID
                            gameid:(NSString *)gameID
                               block:(PFIdResultBlock)block;

/*!
 *  处理提交订单请求  order/submit
 */
+ (void) requestOrderAddInBackground:(NSDictionary *)ordermodel
                               block:(PFIdResultBlock)block;

/*!
 *  处理第三方支付请求
 */
+ (void) requestOrderThirdInBackground:(NSString *)orderid
                               block:(PFIdResultBlock)block;


/*!
 *  处理支付结果请求
 */
+ (void) requestOrderResultInBackground:(NSString *)orderid
                                 block:(PFIdResultBlock)block;

/*!
 * 登录后提示处理
 */
+ (void) showNotifyToast:(NSString * ) toast;

/*!
 *  获取gameid
 *
 */
+(void)requestGameIdInBackgroundblock:(PFIdResultBlock)gameblock;

/*!
 查询游戏支付记录
 */
+ (void)requestPayHistoryInBackground:(NSInteger) startid
                           gameid:(NSInteger) gameid
                            block:(PFArrayResultBlock)successResultBlock;

@end
