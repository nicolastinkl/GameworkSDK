//
//  GWSDKOrderModel.m
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKOrderModel.h"

@implementation GWSDKOrderModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
 

/*!
 *  @"countrylist.code": @"country",
 *
 *  @"email":@"mail",
 *  @return return value description

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{ 
                                                       @"captchaurl":@"captchaurl"
                                                       }];
}
 */
@end
