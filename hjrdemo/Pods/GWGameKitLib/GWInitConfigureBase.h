//
//  GWInitConfigureBase.h
//  GDEMO
//
//  Created by zhangzhongming on 14/11/17.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GWInitConfigureBase : NSObject

@property(nonatomic,copy)   NSString   *gameKey;      //整合平台游戏ID
@property(nonatomic,copy)   NSString   *gameChannel;  //整合平台channel
@property(nonatomic,copy)   NSString   *appKey;       //第三方分配的appkey
@property(nonatomic,copy)   NSString   *appId;        //第三方分配的appId
@property(nonatomic,copy)   NSString   *gameServerUrl;//整合SDK接口URL
@property(nonatomic,copy)   NSString   *gameServerID;

@property(nonatomic,assign) BOOL        isDebug;      //是否采用调试模式
@property(nonatomic,assign) BOOL        checkVersion; //是否坚持更新

@property(nonatomic,assign) UIInterfaceOrientation supportedOrientation;//sdk 支持的屏幕方向

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
           supportedOrientation:(UIInterfaceOrientation)supportedOrientation;

@end
