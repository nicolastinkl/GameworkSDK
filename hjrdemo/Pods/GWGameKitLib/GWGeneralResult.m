//
//  GWGeneralResult.m
//  GameWorksSDK
//
//  Created by zhangzhongming on 14/11/18.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GWGeneralResult.h"
#import "GWCommonUtility.h"
#import "GWLogUtility.h"


#define RESULT_INFO    @"info"
#define RESULT_DATA    @"data"
#define RESULT         @"result"
#define OPERATION_MSG  @"errorinfo"


#pragma mark - GWGeneralResult
@implementation GWGeneralResult

@synthesize info;
@synthesize data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary && dictionary[RESULT_INFO] && [dictionary[RESULT_INFO] isKindOfClass:[NSDictionary class]])
            self.info = [[GWReturnInfo alloc] initWithDictionary:dictionary[RESULT_INFO]];
        
        if (dictionary && dictionary[RESULT_DATA] && [dictionary[RESULT_DATA] isKindOfClass:[NSDictionary class]])
            self.data = dictionary[RESULT_DATA];
    }
    return self;
}
@end


#pragma mark - GWReturnInfo
@implementation GWReturnInfo

@synthesize operationState;
@synthesize operationMsg;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (dictionary && dictionary[RESULT] && [GWCommonUtility isPureInt:dictionary[RESULT]]) {

            int state = [dictionary[RESULT] intValue];
            if (state == 0)
                self.operationState = OperationStateSucess;
            else if (state == 1)
                self.operationState = OperationStateFaild;
            else if (state == 2)
                self.operationState = OperationStateParamsWrong;
            else
                self.operationState = OperationStateUnknow;
        }else
            self.operationState = OperationStateUnknow;
        
        if (dictionary && dictionary[OPERATION_MSG])
            self.operationMsg = dictionary[OPERATION_MSG];
    }
    return self;
}

@end

