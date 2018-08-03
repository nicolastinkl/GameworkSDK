//
//  GWSDKPayDesStruct.m
//  GameWorksSDK
//
//  Created by tinkl on 16/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKPayDesStruct.h"

static BOOL _setPayInfo(void)
{
    return YES;
}

static char* _urldata;
static char* _ordernumber;


static GWSDKPayDesStructXX * util = NULL;


@implementation GWSDKPayDesStruct

+(GWSDKPayDesStructXX *)sharedGWSDKPayDesStructXX
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = malloc(sizeof(GWSDKPayDesStructXX));
        util->setPayInfo = _setPayInfo;
        util->urldata = _urldata;
        util->ordernumber = _ordernumber;
    });
    return util;
}

+ (void)destroy
{
    util ? free(util): 0;
    util = NULL;
}


@end
