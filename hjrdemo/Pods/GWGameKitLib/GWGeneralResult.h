//
//  GWGeneralResult.h
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/18.
//  Copyright (c) 2014年 游戏工厂. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    OperationStateSucess = 0,    //操作成功
    OperationStateFaild  = 1,    //操作失败
    OperationStateParamsWrong =2, //参数错误
    OperationStateUnknow = 3
} OperationState;

/**
 *  服务器端数据返回 model  
 {"info":{"result":"xxx","errorinfo":"xxx"},
   "data":{具体数据}
 }
 */
@class GWReturnInfo;
@interface GWGeneralResult : NSObject

@property(nonatomic,retain) GWReturnInfo *info;
@property(nonatomic,retain) NSDictionary *data;

/**
 *  通过字典构造对象
 *
 *  @param dictionary 字典数据  不能为空
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


/**
 *  服务器返回数据中的info信息部分
 *  1、操作状态   2、操作信息
 */
@interface GWReturnInfo : NSObject

@property(nonatomic,assign) OperationState  operationState; //操作状态
@property(nonatomic,copy)   NSObject*       operationMsg;   //操作描述信息

/**
 *  通过字典构造对象
 *
 *  @param dictionary 字典数据  不能为空
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
