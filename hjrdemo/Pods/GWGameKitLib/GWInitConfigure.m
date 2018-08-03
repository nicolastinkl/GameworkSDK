//
//  GWInitConfigure.m
//  GDEMO
//
//  Created by zhangzhongming on 14/11/17.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import "GWInitConfigure.h"

@implementation GWInitConfigure

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
 *
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
                        waresid:(NSUInteger)waresid
{
    self = [super initWithGameKey:gameKey
                      gameChannel:gameChannel
                           appKey:appKey
                            appId:appId
                    gameServerUrl:gameServerUrl
                     gameServerID:gameServerID
                          isDebug:isDebug
                     checkVersion:checkVersion
             supportedOrientation:supportedOrientation];
    if (self) {
        self.waresid = waresid;
    }
    return self;
}
@end
