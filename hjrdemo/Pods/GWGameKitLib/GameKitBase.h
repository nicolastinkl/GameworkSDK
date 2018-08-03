//
//  GameKitBase.h
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWSysConfingureManager.h"
#import "GameKitGeneralProtocol.h"

@class GameKitConfigure;

@interface GameKitBase : NSObject<GameKitGeneralProtocol>

@property(nonatomic,assign)BOOL             parserSucessed;
@property(nonatomic,copy) GameKitConfigure  *gameKitConfigure;

@end
