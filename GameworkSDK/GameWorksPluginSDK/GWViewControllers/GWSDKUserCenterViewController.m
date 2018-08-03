//
//  GWSDKUserCenterViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 14/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKUserCenterViewController.h"

#import "UIButton+Bootstrap.h"
#import "GWUtility.h"
#import "GWSDKQuarkTableViewCell.h"
#import "GWUICKeyChainStore.h"
#import "GWMacro.h"
#import "GWUser.h"
#import "SVProgressHUD.h"
#import "GWSDKBingAccountViewController.h"
#import "GWSDKRegisterViewController.h"
#import "GWSDKFindPwdViewController.h"
#import "UIAlertView+GWSDKBlocks.h"

#import "GWSDKAboutUSViewController.h"
#import "GWSDKHelpViewController.h"
#import "GWSDKChangePwdViewController.h"

@interface GWSDKUserCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *Label_username;
@property (weak, nonatomic) IBOutlet UILabel *Label_pwd;
@property (weak, nonatomic) IBOutlet UIButton *Button_binding;
@property (weak, nonatomic) IBOutlet UIButton *Button_logout;
@property (weak, nonatomic) IBOutlet UILabel *label_bg_top;
@property (weak, nonatomic) IBOutlet UILabel *label_bg_down;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_line;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_Trarg;
@property (weak, nonatomic) IBOutlet UILabel *label_bg_toper;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_Trarg1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_Trarg2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_Trarg3;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_line1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview_line2;
@property (weak, nonatomic) IBOutlet UILabel *imageview_bg2;

@end

@implementation GWSDKUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"用户中心";
    self.Button_logout.enabled = NO;
//    [self.Button_binding infoStyle];
    [self.Button_logout dangerStyle];
    
    [self border:self.label_bg_toper];
    [self border:self.label_bg_down];
    [self border:self.imageview_bg2];
        
    UIImage * line = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"chapter_line@2x"]];
    
    self.imageview_line.image = line;
    self.imageview_line1.image = line;
    self.imageview_line2.image = line;
    
    UIImage * target = [UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"history_next@2x"]];
    self.imageview_Trarg.image = target;
    self.imageview_Trarg1.image = target;
    self.imageview_Trarg2.image = target;
    self.imageview_Trarg3.image = target;
    
    [self.navigationBar setShowCloseButtton:YES];
    
    self.navigationBar.rightTitle = @"找回密码";
    self.navigationBar.rightBlock = ^{
        
        GWSDKFindPwdViewController *  openViewcontr = [[GWSDKFindPwdViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKFindPwdViewController class])] bundle:nil];
        GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
        [navitation pushGWSDKViewController:openViewcontr animated:YES];
        
    };
     
    [self requsetUserINFO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatepwd:) name:kGWSDKCHANGEPWDNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)updatepwd:(NSNotification * ) notify
{
    if (notify.object) {
        self.Label_pwd.text = [NSString stringWithFormat:@"%@",notify.object];
    }
}

-(void) border:(UIView * )view
{
    view.layer.borderWidth = 0.5;
    view.layer.cornerRadius = 4.0;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.masksToBounds = YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGWSDKCHANGEPWDNotification object:nil];
}

-(void) requsetUserINFO
{
    
    //当前用户UID
    [GWUICKeyChainStore setDefaultService:GW_KEYCHAIN_SERVER];
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString * uid =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    
    NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
    if ([isTempUser isEqualToString:@"1"]) {
        //如果是临时用户
        
        //获取用户信息
        [GWUser requestUserInfoByUID:uid block:^(NSString *string, NSError *error) {
            [SVProgressHUD dismiss];
            if (string) {
                self.Button_logout.enabled = YES;
                self.Label_username.text = [NSString stringWithFormat:@"%@",string];
                self.Label_pwd.text = [NSString stringWithFormat:@"%@", [keyChainObj stringForKey: [NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]]];
            }else{
                self.Label_username.text = @"获取失败";
                self.Label_pwd.text = @"获取失败";
                self.Button_logout.hidden = YES;
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"帐号数据获取失败" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"取消" action:^{
                }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"重新获取" action:^{
                    [SVProgressHUD show];
                    [self requsetUserINFO];
                }], nil] show];
            }
        }];
    }else{
        
        self.Button_logout.enabled = YES;
        self.Label_username.text = [NSString stringWithFormat:@"%@", [keyChainObj stringForKey: [NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_USERNAME,uid]]];
        self.Label_pwd.text = [NSString stringWithFormat:@"%@", [keyChainObj stringForKey: [NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_PASSWORD,uid]]];
    }
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    GWUICKeyChainStore * keyChainObj = [GWUICKeyChainStore keyChainStore];
    NSString * uid =  [keyChainObj stringForKey:KeyChain_GW_USERCURRENTLOGIN_UID];
    NSString * isTempUser = [keyChainObj stringForKey:[NSString stringWithFormat:@"%@_%@",KeyChain_GW_USER_STATUS_TEMP,uid]];
    if ([isTempUser isEqualToString:@"1"]) {
        self.Button_binding.hidden = NO;
        self.imageview_Trarg.hidden = NO;
        self.label_bg_down.hidden = NO;
    }else
    {
        self.Button_binding.hidden = YES;
        self.imageview_Trarg.hidden = YES;
        self.label_bg_down.hidden = YES;
    }
    
}

- (IBAction)bingding_action:(id)sender {
    
    GWSDKRegisterViewController *  openViewcontr = [[GWSDKRegisterViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKRegisterViewController class])] bundle:nil];
    openViewcontr.isLoginAssgin = GWEXCHANGETYPE_Binding;
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
    
    
}

- (IBAction)logout_action:(id)sender {
    [SVProgressHUD showWithStatus:@"注销中" maskType:(SVProgressHUDMaskTypeGradient)];
    [GWUser logOutInBackgroundblock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD dismiss];
            GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
            [navitation show:NO animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"注销失败,请检查网络设置"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return .0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return nil;
}

- (IBAction)changepwd_action:(id)sender {
    
    GWSDKChangePwdViewController *  openViewcontr = [[GWSDKChangePwdViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKChangePwdViewController class])] bundle:nil];
    
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
    
}

- (IBAction)aboutus_action:(id)sender {
    GWSDKAboutUSViewController *  openViewcontr = [[GWSDKAboutUSViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKAboutUSViewController class])] bundle:nil];
    
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
}

- (IBAction)help_action:(id)sender {
    GWSDKHelpViewController *  openViewcontr = [[GWSDKHelpViewController alloc] initWithNibName:    [GWUtility stringByViewController:NSStringFromClass([GWSDKHelpViewController class])] bundle:nil];
    
    GWSDKNavigationController * navitation = [GWSDKNavigationController shareInstance];
    [navitation pushGWSDKViewController:openViewcontr animated:YES];
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
