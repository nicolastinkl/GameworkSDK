//
//  GWSDKRegisterViewController.h
//  GameWorksSDK
//
//  Created by tinkl on 11/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GWSDKViewController.h"

typedef enum : NSUInteger {
    GWEXCHANGETYPE_Register = 1,
    GWEXCHANGETYPE_Login = 2,
    GWEXCHANGETYPE_Binding = 3,
} GWEXCHANGETYPE;

@interface GWSDKRegisterViewController : GWSDKViewController

@property (nonatomic,assign) GWEXCHANGETYPE isLoginAssgin;

@end
