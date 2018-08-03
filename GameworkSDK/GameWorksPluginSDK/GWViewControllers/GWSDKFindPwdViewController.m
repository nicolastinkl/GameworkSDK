//
//  GWSDKFindPwdViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKFindPwdViewController.h"
#import "GWUICKeyChainStore.h"
#import "GWMacro.h"


@interface GWSDKFindPwdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_pwdSign;

@end

@implementation GWSDKFindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    
    // Do any additional setup after loading the view from its nib.
    
    [GWUICKeyChainStore setDefaultService:GW_KEYCHAIN_SERVER];
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString * PREUDID =  [keyChainObj stringForKey:KeyChain_GW_SYSTEM_UDID];
    
    self.label_pwdSign.text = [NSString stringWithFormat:@"%@",PREUDID];


    
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
