//
//  GWSDKRegisterViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 11/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKRegisterViewController.h"
#import "UIButton+Bootstrap.h"
#import "GWUser.h"
#import "SVProgressHUD.h"
#import "GWUtility.h"

@interface GWSDKRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Txt_Name;
@property (weak, nonatomic) IBOutlet UITextField *Txt_Pwd;
@property (weak, nonatomic) IBOutlet UIButton *Button_Regsiter;

@end

@implementation GWSDKRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.isLoginAssgin) {
        case GWEXCHANGETYPE_Login:
            self.title = @"登录";
            [self.Button_Regsiter setTitle:@"登录" forState:UIControlStateNormal];
            break;
        case GWEXCHANGETYPE_Register:
            self.title = @"注册";
            [self.Button_Regsiter setTitle:@"注册" forState:UIControlStateNormal];
            break;
        case GWEXCHANGETYPE_Binding:
            self.title = @"绑定帐号";
            [self.Button_Regsiter setTitle:@"绑定帐号" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView * imageview = ((UIImageView *)obj);

            if (imageview.tag < 5 && imageview.tag > 1) {
                    [((UIImageView *)obj) setImage:[UIImage imageWithContentsOfFile:[GWUtility  getFilePathFromBound:@"chapter_line@2x"]]];
            }            
        }
    }];
    

    [self.Button_Regsiter infoStyle];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)tapAction:(id)sender {
    
    [self.Txt_Name resignFirstResponder];

    [self.Txt_Pwd resignFirstResponder];
}

- (IBAction)action_register:(id)sender {
    //signUpInBackgroundWithBlock
    
    if (self.Txt_Name.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        return;
    }    
    
    if (self.Txt_Pwd.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    
    switch (self.isLoginAssgin) {
        case GWEXCHANGETYPE_Login:
        {
            [SVProgressHUD showWithStatus:@"登录中" maskType:(SVProgressHUDMaskTypeBlack)];
            [GWUser logInWithUsernameInBackground:self.Txt_Name.text password:self.Txt_Pwd.text block:^(GWUser *user, NSError *error) {
                if (user) {
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       [self.gwSDKNavigationController show:NO animated:YES];
                                   });
                }else{
                    NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                    [SVProgressHUD showErrorWithStatus:errorDes];
                }
            }];
        }
            break;
        case GWEXCHANGETYPE_Register:
        {
            
            [SVProgressHUD showWithStatus:@"注册中" maskType:(SVProgressHUDMaskTypeBlack)];
            [GWUser signUpInBackgroundWithBlock:self.Txt_Name.text password:self.Txt_Pwd.text block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //这里默认登录处理
                    [GWUser logInWithUsernameInBackground:self.Txt_Name.text password:self.Txt_Pwd.text block:^(GWUser *user, NSError *error) {
                        
                    }];
                    
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       [self.gwSDKNavigationController show:NO animated:YES];
                                   });
                }else{
                    NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                    [SVProgressHUD showErrorWithStatus:errorDes];
                }
            }];
        }
            break;
        case GWEXCHANGETYPE_Binding:
        {
            [SVProgressHUD showWithStatus:@"绑定中" maskType:(SVProgressHUDMaskTypeBlack)];
            [GWUser bindWithUsernameInBackground:self.Txt_Name.text password:self.Txt_Pwd.text block:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [SVProgressHUD dismiss];
                    
                    dispatch_async(dispatch_get_main_queue(), ^
                                   {
                                       [self.gwSDKNavigationController show:NO animated:YES];
                                   });

                }else{
                    NSString * errorDes = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
                    [SVProgressHUD showErrorWithStatus:errorDes];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)dealloc
{
    self.view = nil;
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
