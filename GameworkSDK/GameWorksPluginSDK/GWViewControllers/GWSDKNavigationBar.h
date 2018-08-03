//
//  GWSDKNavigationBar.h
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GWSDKViewController;

@interface GWSDKNavigationBar : UIToolbar  
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,assign) BOOL showBackButtton;
@property (nonatomic,assign) BOOL showCloseButtton;
@property (strong,nonatomic) void (^leftBlock)(void);
@property (strong,nonatomic) void (^rightBlock)(void);
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGFloat titleAlpha;
-(void)clear;
@end
