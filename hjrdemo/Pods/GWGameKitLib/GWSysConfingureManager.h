//
//  GWSysConfingureManager.h
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GameKitConfigure.h"

typedef void(^ParaseSucessCallBack)(GameKitConfigure * config);
typedef void(^ParaseFaildCallBack)(NSString * errorMsg);

@protocol NSXMLParserDelegate;

@interface GWSysConfingureManager : NSObject<NSXMLParserDelegate>
{
    NSData             *xmlData;
    NSXMLParser        *parserXML;
    NSData             *dataToParse;
    NSMutableArray     *workingArray;
    NSMutableString    *workingPropertyString;
    NSArray            *elementsToParse;
    BOOL                storingCharacterData;
    GameKitConfigure   *workingEntry;
}

@property (nonatomic,retain) NSXMLParser       *parserXML;
@property (nonatomic,retain) NSData            *xmlData;
@property (nonatomic,retain) NSData            *dataToParse;
@property (nonatomic,retain) NSMutableArray    *workingArray;
@property (nonatomic,retain) NSMutableString   *workingPropertyString;
@property (nonatomic,retain) NSArray           *elementsToParse;
@property (nonatomic,retain) GameKitConfigure  *workingEntry;

- (instancetype)initWithXML;
-(void)startParserWithSucessBlock:(ParaseSucessCallBack) sucessBlock faildBlock:(ParaseFaildCallBack)faildBlock;

@end
