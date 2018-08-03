//
//  GWNetworkBase.h
//  GamePluginSDK
//
//  Created by zhangzhongming on 14/11/10.
//  Copyright (c) 2014年 zhangzhongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWNetworkBase : NSObject

#pragma mark -  property

// 网络请求队列管理
@property(nonatomic,retain)NSOperationQueue *operationQueue;


#pragma mark -  function

// 网络访问取消操作
-(void)cancle;

/**
 *  异步网络访问
 *
 *  @param params      参数
 *  @param sucessBlock 成功回调
 *  @param failBlock   失败回调
 */
-(void)sendAsynchronousWithUrl:(NSString *)url
                          data:(NSData *)sendData
                   sucessBlock:(void (^)(NSData *respondData)) sucessBlock
                     failBlock:(void (^)(NSString *errorMsg)) failBlock;

/**
 *  同步网络访问
 *
 *  @param params      参数
 *  @param sucessBlock 成功回调
 *  @param failBlock   失败回调
 */
-(void)sendSynchronousWithUrl:(NSString *)url
                       data:(NSData *)sendData
                  sucessBlock:(void (^)(NSData *respondData)) sucessBlock
                    failBlock:(void (^)(NSString *errorMsg)) failBlock;

@end
