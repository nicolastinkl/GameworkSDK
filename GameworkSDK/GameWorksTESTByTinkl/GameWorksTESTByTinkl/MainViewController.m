//
//  MainViewController.m
//  GameWorksTESTByTinkl
//
//  Created by tinkl on 22/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "MainViewController.h"

#import <GameWorksPluginSDK/GWGameWorks.h>
#import <GameWorksPluginSDK/GWApp.h>
#import <GameWorksPluginSDK/GWUser.h>


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [GWGameWorks showBanner:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameinitsuccess) name:kGWSDKInitSuccessNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameinitfail) name:kGWSDKInitFailNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameloginNotify) name:kGWSDKLoginResultNotification object:nil];
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGWSDKLoginResultNotification object:nil];
}

-(void)gameinitsuccess {
   // [self alertMsg:@"游戏初始化成功"];
}

-(void)gameinitfail {
   // [self alertMsg:@"游戏初始化失败"];
}

-(void)gameloginNotify
{
    [self targetViewController];
}

-(void)targetViewController
{
   id viewcontroller =  [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
 
#pragma mark - 其他函数
-(void)alertMsg:(NSString *)msg
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (IBAction)gameThroeAction:(id)sender {
   // [GWGameWorks showBanner:YES];
    [GWGameWorks showGWSDKUserLoginCenterViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
