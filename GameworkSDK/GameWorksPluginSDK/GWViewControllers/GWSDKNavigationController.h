//
//  GWSDKPresentViewController.h
//  GWSDKPresentViewController
//
// 
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//



#import <UIKit/UIKit.h>
@class  GWSDKViewController;
@class GWSDKNavigationBar;

@interface GWSDKNavigationController : UIViewController
+(instancetype)shareInstance;
-(id)initWithSize:(CGSize)size rootViewController:(GWSDKViewController *)viewController;
@property (strong,nonatomic) GWSDKViewController *rootViewController;
@property (assign,nonatomic) BOOL panPopView;
@property (assign,nonatomic) BOOL touchSpaceHide;
@property (assign,nonatomic) CGSize size;
-(void)show:(BOOL)isShow animated:(BOOL)animated;
-(void)pushGWSDKViewController:(GWSDKViewController *)viewController animated:(BOOL)animated;
-(void)popGWSDKViewControllerAnimated:(BOOL)animated;
@end
