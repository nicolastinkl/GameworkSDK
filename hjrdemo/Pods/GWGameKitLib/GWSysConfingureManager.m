//
//  GWSysConfingureManager.m
//  GameKit
//
//  Created by zhangzhongming on 14/11/25.
//  Copyright (c) 2014年 游戏工场. All rights reserved.
//

#import "GWSysConfingureManager.h"
#import "GWDefine.h"

static NSString *PTGameKey                          =  @"PTGameKey";
static NSString *PTGameChannel                      =  @"PTGameChannel";

static NSString *CPName                             =  @"CPName";
static NSString *CPVersion                          =  @"CPVersion";
static NSString *CPAppID                            =  @"CPAppID";
static NSString *CPAppKey                           =  @"CPAppKey";
static NSString *CPGameKey                          =  @"CPGameKey";
static NSString *CPGameChannel                      =  @"CPGameChannel";
static NSString *CPPrivateKey                       =  @"CPPrivateKey";
static NSString *CPServerNo                         =  @"CPServerNo";
static NSString *CPAutoLogin                        =  @"CPAutoLogin";
static NSString *CPForceUpdate                      =  @"CPForceUpdate";
static NSString *CPForceLogin                       =  @"CPForceLogin";

static NSString *DEV_ISDebugModel                   =  @"DEV_ISDebugModel";
static NSString *DEV_ShowFloatWindowOrBar           =  @"DEV_ShowFloatWindowOrBar";
static NSString *DEV_FloatWindowOrBarScreenPlace    =  @"DEV_FloatWindowOrBarScreenPlace";
static NSString *DEV_SupportScreenOrientation       =  @"DEV_SupportScreenOrientation";

static NSString *PAY_DefaultPayAmount               =  @"PAY_DefaultPayAmount";
static NSString *PAY_ShopingPrivateInfo             =  @"PAY_ShopingPrivateInfo";
static NSString *PAY_PayNotifyUrl                   =  @"PAY_PayNotifyUrl";
static NSString *PAY_AlipayScheme                   =  @"PAY_AlipayScheme";
static NSString *PAY_MerchantId                     =  @"PAY_MerchantId";
static NSString *PAY_AppScheme                      =  @"PAY_AppScheme";
static NSString *DATA_Product                       =  @"DATA_Product";


@interface  GWSysConfingureManager()
@property(nonatomic,copy)ParaseSucessCallBack paraseSucessBlock;
@property(nonatomic,copy)ParaseFaildCallBack  parasFaildBlock;
@end

@implementation GWSysConfingureManager

@synthesize xmlData;
@synthesize parserXML;
@synthesize dataToParse, workingArray, workingEntry,workingPropertyString, elementsToParse;

- (instancetype)initWithXML
{
    self = [super init];
    if (self) {
        NSString *strPathXml = [[NSBundle mainBundle] pathForResource:@"Confingure" ofType:@"xml"];
        self.parserXML = [[NSXMLParser alloc] initWithData:[[NSData alloc] initWithContentsOfFile:strPathXml]];
        self.workingPropertyString = [NSMutableString new];
        self.workingArray = [NSMutableArray new];
    }
    
    return self;
}


/**
 *  NSXMLParser 解析是同步解析的,一般情况会把解析放在异步解析子线程中，因为此处是平台初始化，不做异步处理
 */
-(void)startParserWithSucessBlock:(ParaseSucessCallBack) sucessBlock faildBlock:(ParaseFaildCallBack)faildBlock
{
    if (sucessBlock) {
        self.paraseSucessBlock = sucessBlock;
    }
    
    if (faildBlock) {
        self.parasFaildBlock = faildBlock;
    }
    
    self.elementsToParse = [NSArray arrayWithObjects:PTGameKey, PTGameChannel, CPName, CPVersion,CPAppID ,CPAppKey,CPGameKey,CPGameChannel,CPPrivateKey,DEV_ISDebugModel,DEV_ShowFloatWindowOrBar,DEV_FloatWindowOrBarScreenPlace,DEV_SupportScreenOrientation,PAY_DefaultPayAmount,PAY_ShopingPrivateInfo,PAY_AlipayScheme,PAY_AppScheme,PAY_MerchantId,PAY_PayNotifyUrl,DATA_Product,CPServerNo,nil];
    [parserXML setDelegate:self];
    [parserXML parse];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:SYSTMECONFIG_TAG_NAME])
    {
        self.workingEntry = [[GameKitConfigure alloc] init];
    }
    storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData)
    {
        [workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if (self.workingEntry)
    {
        if (storingCharacterData)
        {
            NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [workingPropertyString setString:@""];
            
            if ([elementName isEqualToString:PTGameKey]) {
                self.workingEntry.PTGameKey = trimmedString;
            }else if ([elementName isEqualToString:PTGameChannel])
            {
                self.workingEntry.PTGameChannel = trimmedString;
            }else if ([elementName isEqualToString:CPName])
            {
                self.workingEntry.CPName = trimmedString;
            }else if ([elementName isEqualToString:CPVersion])
            {
                self.workingEntry.CPVersion = trimmedString;
            }else if ([elementName isEqualToString:CPAppID])
            {
                self.workingEntry.CPAppID = trimmedString;
            }else if ([elementName isEqualToString:CPAppKey])
            {
                self.workingEntry.CPAppKey = trimmedString;
            }else if ([elementName isEqualToString:CPGameKey])
            {
                self.workingEntry.CPGameKey = trimmedString;
            }else if ([elementName isEqualToString:CPGameChannel])
            {
                self.workingEntry.CPGameChannel = trimmedString;
            }else if ([elementName isEqualToString:CPPrivateKey])
            {
                self.workingEntry.CPPrivateKey = trimmedString;
            }else if ([elementName isEqualToString:CPAutoLogin])
            {
                self.workingEntry.CPAutoLogin = [@"1" isEqualToString:trimmedString]?YES:NO;
            }else if ([elementName isEqualToString:CPServerNo])
            {
                self.workingEntry.CPServerNo = trimmedString;
            }
            else if ([elementName isEqualToString:CPForceLogin])
            {
                self.workingEntry.CPForceLogin = [@"1" isEqualToString:trimmedString]?YES:NO;
            }else if ([elementName isEqualToString:CPForceUpdate])
            {
                self.workingEntry.CPForceUpdate = [@"1" isEqualToString:trimmedString]?YES:NO;
            }else if ([elementName isEqualToString:DEV_ISDebugModel])
            {
                self.workingEntry.DEV_ISDebugModel = [@"1" isEqualToString:trimmedString]?YES:NO;
            }else if ([elementName isEqualToString:DEV_ShowFloatWindowOrBar])
            {
                self.workingEntry.DEV_ShowFloatWindowOrBar = [@"1" isEqualToString:trimmedString]?YES:NO;
            }else if ([elementName isEqualToString:DEV_FloatWindowOrBarScreenPlace])
            {
                //1.上左 2.上中 3.上右 4.中左  5.中间 6.中右 7.底左 8.底中 9.底右
                switch ([trimmedString intValue]) {
                    case 1:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_TOP_LEFT;
                    }
                        break;
                    case 2:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_TOP_MIDDLE;
                    }
                        break;
                    case 3:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_TOP_RIGHT;
                    }
                        break;
                    case 4:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_MIDDLE_LEFT;
                    }
                        break;
                    case 5:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_MIDDLE_RIGHT;
                    }
                        break;
                    case 6:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_BOTTOM_LEFT;
                    }
                        break;
                    case 7:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_BOTTOM_MIDDLE;
                    }
                        break;
                    case 8:
                    {
                        self.workingEntry.DEV_FloatWindowOrBarScreenPlace = PLACE_BOTTOM_RIGHT;
                    }
                        break;
                    default:
                        break;
                }

            }else if ([elementName isEqualToString:DEV_SupportScreenOrientation])
            {
                self.workingEntry.DEV_SupportScreenOrientation = trimmedString;
            }else if ([elementName isEqualToString:PAY_DefaultPayAmount])
            {
                self.workingEntry.PAY_DefaultPayAmount = trimmedString;
            }else if ([elementName isEqualToString:PAY_ShopingPrivateInfo])
            {
                self.workingEntry.PAY_ShopingPrivateInfo = trimmedString;
            }else if ([elementName isEqualToString:PAY_AlipayScheme])
            {
                self.workingEntry.PAY_AlipayScheme = trimmedString;
            }else if ([elementName isEqualToString:PAY_AppScheme])
            {
                self.workingEntry.PAY_AppScheme = trimmedString;
            }else if ([elementName isEqualToString:PAY_PayNotifyUrl])
            {
                self.workingEntry.PAY_PayNotifyUrl = trimmedString;
            }else if ([elementName isEqualToString:PAY_MerchantId])
            {
                self.workingEntry.PAY_MerchantId = trimmedString;
            }else if ([elementName isEqualToString:DATA_Product])
            {
                NSMutableDictionary *dic = [NSMutableDictionary new];
                if (trimmedString && ![trimmedString isEqualToString:@""]) {
                    NSArray *arr = [trimmedString componentsSeparatedByString:@"|"];
                    if ([arr count]>0) {
                        
                        for (NSString *temp in arr) {
                            NSArray *infoArr = [temp componentsSeparatedByString:@":"];
                            if ([infoArr count] == 2) {
                                [dic setObject:infoArr[1] forKey:infoArr[0]];
                            }
                            
                        }
                    }
                }
                self.workingEntry.DATA_Product = dic;
            }
        }
    }

    if ([elementName isEqualToString:SYSTMECONFIG_TAG_NAME])
    {
        [self.workingArray addObject:self.workingEntry];
        if (self.paraseSucessBlock) {
            self.paraseSucessBlock([self.workingEntry copy]);
        }
        self.workingEntry = nil;
    }
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    if (self.parasFaildBlock) {
        self.parasFaildBlock(@"配置文件解析失败");
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (self.parasFaildBlock) {
        self.parasFaildBlock(@"配置文件解析失败");
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //数据解析完成
    NSLog(@"配置数据解析完成!");
}

@end
