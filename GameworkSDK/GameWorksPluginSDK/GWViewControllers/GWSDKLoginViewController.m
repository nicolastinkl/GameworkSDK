//
//  GWSDKLoginViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 9/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKLoginViewController.h"
#import "GWSDKNavigationController.h"
#import "GWSDKRegisterViewController.h"
#import "GWUtility.h"
#import "UIButton+Bootstrap.h"
#import "GWUser.h"
#import "GWUICKeyChainStore.h"
#import "GWUtility.h"
#import "GWMacro.h"
#import "SVProgressHUD.h"
#import "GWSDKFindPwdViewController.h"

@interface GWSDKLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *Button_QuartLogin;
@property (weak, nonatomic) IBOutlet UIButton *Button_Login;
@property (weak, nonatomic) IBOutlet UIButton *Button_Resgister;

@end

@implementation GWSDKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.Button_Login infoStyle];
    [self.Button_QuartLogin infoStyle];
    [self.Button_Resgister infoStyle];
    self.title = @"登录";
    [self.navigationBar setShowCloseButtton:YES];
    
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSLog(@"KeyChain_GW_USER_UID : %@  ----- current login uid :%@ ",[keyChainObj stringForKey:KeyChain_GW_USER_UID],[keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID]);
        
        
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)forgetpwd:(id)sender 
{
    GWSDKFindPwdViewController *  openViewcontr = [[GWSDKFindPwdViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKFindPwdViewController class])] bundle:nil];
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
}

- (IBAction)actin_login:(id)sender {
    GWSDKRegisterViewController *  openViewcontr = [[GWSDKRegisterViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKRegisterViewController class])] bundle:nil];
 
    openViewcontr.isLoginAssgin = GWEXCHANGETYPE_Login;
    openViewcontr.navigationBar.showBackButtton = NO;
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
    
}

- (IBAction)action_resgister:(id)sender {

    GWSDKRegisterViewController *  openViewcontr = [[GWSDKRegisterViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKRegisterViewController class])] bundle:nil];
    openViewcontr.isLoginAssgin = GWEXCHANGETYPE_Register;
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];

    [navitation pushGWSDKViewController:openViewcontr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//快速登录
- (IBAction)action_CloseWindow:(id)sender {
    
    [SVProgressHUD showWithStatus:@"登录中" maskType:(SVProgressHUDMaskTypeBlack)];
    
    [GWUser logInWithTempUsernameInBackgroundblock:^(GWUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD dismiss];
            GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
            [navitation show:NO animated:YES];        
        }else{
            NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            [SVProgressHUD showErrorWithStatus:errorDes];
        }
        
    }];
    
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
