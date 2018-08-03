//
//  GWInitConfigure.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/17.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWInitConfigureBase.h"

/**
 *  后面的整合 根据设置的参数进行修改
 */
@interface GWInitConfigure : GWInitConfigureBase

@property(nonatomic,assign) NSUInteger  waresid;//外部商铺号


/**
 *  构造函数
 *
 *  @param gameKey              整合平台gameKey
 *  @param gameChannel          整合平台Channel
 *  @param appKey               整合平台appKey
 *  @param appId                整合平台appId
 *  @param gameServerUrl        整合平台服务器:gameServerUrl
 *  @param gameServerID         整合平台服务器ID
 *  @param isDebug              是否采用调试模式
 *  @param checkVersion         是否自动检查更新
 *  @param supportedOrientation 支持屏幕方向
 *  @Param waresid;             外部商铺号
 *  @return
 */
- (instancetype)initWithGameKey:(NSString *)gameKey
                    gameChannel:(NSString *)gameChannel
                         appKey:(NSString *)appKey
                          appId:(NSString *)appId
                  gameServerUrl:(NSString *)gameServerUrl
                   gameServerID:(NSString *)gameServerID
                        isDebug:(BOOL)isDebug
                   checkVersion:(BOOL)checkVersion
           supportedOrientation:(UIInterfaceOrientation)supportedOrientation
                        waresid:(NSUInteger)waresid;

@end
