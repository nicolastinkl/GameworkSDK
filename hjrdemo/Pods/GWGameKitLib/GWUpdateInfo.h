//
//  GWUpdateInfo.h
//  GameKit
//
//  Created by zhangzhongming on 14/12/18.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger
{
    CHECK_SUCCEED,//成功
    CHECK_FAILED  //失败
}CheckStatus;

@interface GWUpdateInfo : NSObject

@property(nonatomic,assign) CheckStatus status;   //操作是否成功
@property(nonatomic,assign) BOOL        hasUpdate;//是否有更新
@property(nonatomic,assign) BOOL        isForce;  //是否强制更新

@end
