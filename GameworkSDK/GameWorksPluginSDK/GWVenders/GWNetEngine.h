//
//  GWNetEngine.h
//  GameWorksSDK
//
//  Created by tinkl on 7/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWApp.h"

/*!
 *  网路引擎
 */
@interface GWNetEngine : NSObject

+(GWNetEngine* ) sharedGWNetEngine;

/*!
 *  Post请求
 *
 *  @param parames 参数
 *  @param action  动作
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)postRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(GWIdResultBlock) success error:(GWIntegerResultBlock) fail;

@end
