//
//  GWNetworkService.h
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import "GWNetworkBase.h"
#import "GWGeneralResult.h"

@interface GWNetworkService : GWNetworkBase



/**
 *  获取单例对象
 *
 *  @return
 */
+(GWNetworkService *)defaultService;



/**
 *  取消所有的网络访问
 */
-(void)cancleAllService;



/**
 *  抽象统一网络访问接口  在此处加上全局info数据,并且拼装成json数据，通过post.body访问
 *
 *  @param url         网络访问url
 *  @param parmas      参数
 *  @param sucessBlock 成功回调
 *  @param failedBlock 失败回调
 */
-(void) requestIntegrationPlatformWithUrl:(NSString *)url
                                   params:(NSDictionary *)parmas
                              sucessBlock:(void (^)(GWGeneralResult *result)) sucessBlock
                                failBlock:(void (^)(NSString *errorMsg)) failedBlock;


@end
