//
//  GWSDKPayMentModel.m
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPayMentModel.h"

@implementation GWSDKPayMentModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"gameid"
                                                       }];
}



@end


@implementation GWSDKPayMentModelSUB


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}



+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"channelid"
                                                       }];
}

@end



@implementation GWSDKPayGameINFO


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}



@end
 

@implementation GWSDKPayHistoryGameINFO


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}



@end

