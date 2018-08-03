//
//  GWSDKPayDesStruct.h
//  GameWorksSDK
//
//  Created by tinkl on 16/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  防止反汇编处理
 */
typedef struct _GWSDKPayDesStruct
{
    BOOL (*setPayInfo)(void);
    char   *urldata;
    char   *ordernumber;
    
} GWSDKPayDesStructXX;


@interface GWSDKPayDesStruct : NSObject

+ (GWSDKPayDesStructXX *)sharedGWSDKPayDesStructXX;

@end
