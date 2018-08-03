//
//  GWSDKViewController.h
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWSDKNavigationBar.h"
#import "GWSDKNavigationController.h"

@interface GWSDKViewController : UIViewController

@property (nonatomic,strong) GWSDKNavigationBar *navigationBar;
@property (nonatomic,weak,readonly) GWSDKNavigationController *gwSDKNavigationController;

@end
