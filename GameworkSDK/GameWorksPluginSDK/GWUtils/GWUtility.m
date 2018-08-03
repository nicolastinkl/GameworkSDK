//
//  GWUtility.m
//  GameWorksSDK
//
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWUtility.h"
#import "GWAES.h"
#import "GWMBase64.h"
#import "GWMacro.h"
#import "GPReachability.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <dlfcn.h>
#include "GWOpenUDID.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CommonCrypto/CommonDigest.h> 

#import "GWUICKeyChainStore.h"
#import "GWObject.h"


#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

@implementation GWUtility

#pragma mark - AES
+ (NSString *)AESStingWithString:(NSString *)str {
    GWAES *aes = [[GWAES alloc] initWithKey:GW_NETWORK_KEY];
    const char *strChar = [str UTF8String];
    NSString *encryptString = [aes Encryption:strChar
                                          len:(int)strlen(strChar)];
    return encryptString;
}

+ (NSString *)stringWithAESString:(NSString *)aesStr {
    if(aesStr.length==0||aesStr==nil)
    {
        return @"";
    }
    aesStr = [NSString stringWithFormat:@"%@",aesStr];
    GWAES *aes = [[GWAES alloc] initWithKey:GW_NETWORK_KEY];
    const char *strChar = [aesStr UTF8String];
    NSString *decryptString = [aes Decryption:strChar
                                          len:(int)strlen(strChar)];
    // (int) is depater for x86_64
    return decryptString;
}

// IOS Device platformString
+ (NSString *) platform{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

+(NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    
    if (str.length == 0) {
        return nil;
    }
    
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    NSString *md5String = [NSString stringWithFormat:
                           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return [md5String lowercaseString];
    
}


+ (NSString *)platformString
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (UK+Europe+Asia+China)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (UK+Europe+Asia+China)";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

/*!
 *  判断是否越狱
 
 方式：
 
 /Applications/Cydia.app
 
 /Library/MobileSubstrate/MobileSubstrate.dylib
 
 /bin/bash
 
 /usr/sbin/sshd
 
 /etc/apt
 
*/
const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

+ (BOOL)isJailBreak
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
//            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
//    NSLog(@"The device is NOT jail broken!");
    return NO;
}


/*!
 *  获取屏幕分辨率
 *
 *  @return resolutionScreen
 */
+ (NSString *)resolutionScreen {
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSString* resolution=[NSString stringWithFormat:@"%.0f*%.0f",size_screen.width*scale_screen,size_screen.height*scale_screen];
    return resolution;
}


//系统版本信息
+ (NSString *) systemVersionApp
{
    return [NSString stringWithFormat:@"%@%@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
}

//系统UDID
+ (NSString *) systemUDID
{
    [GWUICKeyChainStore setDefaultService:GW_KEYCHAIN_SERVER];
    
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString * PREUDID =  [GWUICKeyChainStore stringForKey:KeyChain_GW_SYSTEM_UDID];
    NSString * systemUIDID = [GWOpenUDID value];
    NSString * CURRENTUDID = [self md5:systemUIDID];//[GWOpenUDID value]
    
    CURRENTUDID = [[CURRENTUDID substringWithRange:NSMakeRange(7, 16)] uppercaseString];
    
    //判断GWopenUDID取出来的UDID是否和KeyChain取出来的是否一直
    if ([PREUDID isEqualToString:CURRENTUDID]) {
        return CURRENTUDID;
    }else{
        //首次设置UDID到KeyChain
        [keyChainObj setString:CURRENTUDID forKey:KeyChain_GW_SYSTEM_UDID];
        [keyChainObj synchronize];
    }
    
    return [NSString stringWithFormat:@"%@",PREUDID];
}


//当前网络环境
+ (NSString *) sysytemCurrentReachabilityStatus
{
    GPReachability* test=[GPReachability reachabilityWithHostName:@"www.baidu.com"];
    
    NetworkStatus netStatus = [test currentReachabilityStatus];
    NSString * network;
    switch (netStatus)
    {
        case GPkNotReachable:
        {
            network = @"0";
            break;
        }
            
        case GPkReachableViaWWAN:
        {
            network = @"1";
            break;
        }
        case GPkReachableViaWiFi:
        {
            network= @"2";
            break;
        }
        case GPKReachableVia2G:
        {
            network= @"3";
            break;
        }
    }
    
    return network;
}


//当前运营商
+ (NSString *) sysytemCellularProviderName
{
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    return  [carrier carrierName];
}

//当前国家号
+ (NSString *) sysytemCellularCountryCode
{
    CTTelephonyNetworkInfo*netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    return  [carrier isoCountryCode];
}

//当前系统语言
+ (NSString *) systemLanguages
{
    NSUserDefaults* defaultss = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaultss objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSString * strLanguage;
    /**  *得到本机现在用的语言  
     * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......  
     */
    if ([preferredLang isEqualToString:@"zh-Hans"] || [preferredLang isEqualToString:@"zh-Hant"]) {
        strLanguage=@"1";
    }else{
        strLanguage=@"2";
    }
    return strLanguage;
}

///---------------------------------------------------------------------------------------
/// @name  Log 工具
///---------------------------------------------------------------------------------------

//打印日志信息
+ (void) printSystemLog:(id) log
{
    
    if ([GWObject sharedGWObject].isPRODECTION) {
        GWInfoLog(@"%@",log);
    }else{
        if ([GWObject sharedGWObject].LOGLEVEL) {
            
            switch ([GWObject sharedGWObject].LOGLEVEL) {
                case GWLogLevelNone:
                    break;
                case GWLogLevelError:
                    GWLog(@"Error : %@",log);
                    break;
                case GWLogLevelWarning:
                    GWDefaultLog(@"Warning : %@",log);
                    break;
                case GWLogLevelInfo:
                    GWInfoLog(@"Info : %@",log);
                    break;
                case GWLogLevelVerbose:
                    GWInfoLog(@"%@",log);
                    break;
                case GWLogLevelDefault:
                    GWInfoLog(@"%@",log);
                    break;
                default:
                    
                    break;
            }
        }else{
            GWInfoLog(@"%@",log);
        }
    }
    
    
}

// BASE64
+ (NSString *)base64Encode:(NSString *)string
{
    NSString *str = [GWMBase64 encodeBase64String:string];
    return str;
}

+ (NSString *)base64Decode:(NSString *)string
{
    if (!string || string.length==0) {
        return @"";
    }
    NSString *str = [GWMBase64 decodeBase64String:string];
    return str;
}

//服务接口地址
+ (NSString *) systemDOMAINURL
{
    BOOL isproductionBool = [GWObject sharedGWObject].isPRODECTION;
    if (isproductionBool) {
        return GW_DOMAIN_RELEASE;
    }
    return GW_DOMAIN_DEBUG;
}

//string字符串安全处理 
+ (NSString *) stringSafeOperation:(NSString *) string
{
    if (string == nil) {
        return @"";
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}


+ (BOOL)IsNilOrEmpty:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (str == nil) {
        return YES;
    }
    
    NSMutableString *string = [[NSMutableString alloc] init];
    [string setString:str];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)string);
    if([string length] == 0)
    {
        return YES;
    }
    return NO;
}

+ (NSString*)timestampFromIntDate:(NSDate*)date
{
    NSTimeInterval seconds = [date timeIntervalSince1970];
    NSString* temp=[NSString stringWithFormat:@"%.0f",[[NSNumber numberWithDouble:seconds] floatValue]];
    return temp;
}

+ (NSString *) stringByViewController:(NSString *) classname
{
    return [NSString stringWithFormat:@"%@/%@/%@/%@/%@",GWSDKBUNDLE_NAME_FRAMEWORK,GWSDKBUNDLE_NAME_GWFRAMEWORK,GWSDKBUNDLE_NAME_PATH,GWSDKBUNDLE_NAME, classname];
    
    /*
     return [[[[[NSBundle mainBundle].resourcePath
     stringByAppendingPathComponent:@"Frameworks"]
     stringByAppendingPathComponent:@"GameWorksSDK.framework"]
     stringByAppendingPathComponent:@"GameWorksSDKBundle.bundle"]
     stringByAppendingPathComponent:classname];
     
     BOOL isIpad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
    if (isIpad) {
        return [NSString stringWithFormat:@"%@/%@~ipad",GWSDKBUNDLE_NAME, classname];
    }
    return [NSString stringWithFormat:@"%@/%@~iphone",GWSDKBUNDLE_NAME, classname];
     */
}

+(BOOL)isValidatePhoneNumber:(NSString *)phonenumber{
    
    NSString *regex = @"^(13[0-9]|15[0-9]|18[0-9]|17[0678]|14[57])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phonenumber]; 
    return isMatch;
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidatePwd:(NSString *)pwd {
    NSString *pwdRegex = @"[A-Z0-9a-z._%+-]+";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwdRegex];
    BOOL t=[pwdTest evaluateWithObject:pwd];
    return t;
}

+ (NSString *)getFilePathFromBound:(NSString *)fileNameAndType
{
    NSString *gwbundlePath = [[[[[NSBundle mainBundle].resourcePath  stringByAppendingPathComponent:@"Frameworks"]
                               stringByAppendingPathComponent:@"GameWorksSDK.framework"]
                               stringByAppendingPathComponent:@"GameWorksPluginSDK.framework"]
                              stringByAppendingPathComponent:@"GameWorksSDKBundle.bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:gwbundlePath];
    
    NSString *img_path  = [bundle pathForResource:fileNameAndType ofType:@"png"];
    return  img_path;//[UIImage imageWithContentsOfFile:img_path];
    
}

+ (CGSize)fixedScreenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    } else {
        return screenSize;
    }
}

@end
