//
//  ViewController.m
//  GameWorksTESTByTinkl
//
//  Created by tinkl on 8/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "ViewController.h"
#import <GameWorksPluginSDK/GWGameWorks.h>
#import <GameWorksPluginSDK/GWApp.h>
#import <GameWorksPluginSDK/GWUser.h>
#import <GameWorksPluginSDK/GWSDKPayPluginOrder.h>
#import "MenuItemsTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isshoworhidden;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isshoworhidden = YES;
    [GWGameWorks showBanner:isshoworhidden];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- uitableviewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0)
    {
        switch (indexPath.row) {
            case 0:
            {
                [GWGameWorks showGWSDKUserLoginCenterViewController];
            }
                break;
            case 1:
            {
                [GWGameWorks showGWSDKtempUserLoginCenterViewController];
                //[self loginGuestAction];
            }
                break;
            case 2:
            {
                [GWGameWorks showGWSDKUserCenterViewController];
                //[self loginNomalFromGuestAction];
            }
                break;
            case 3:
            {
//                order.gameextend = @"xxxx";
//                order.productDisplayTitle = @"套餐1";//没有则不填 不填则显示金额
                
//                [GWGameWorks requestUniPay:@"123" needPayCoins:1 serverid:@"111" productid:@"pro123" productnum:1 ProductName:@"product name test" notifyUrl:@"api.youxigongchang.com" complete:^(NSString *string) {
//                    
//                } failed:^(NSString *string) {
//                    [self alertMsg:string];
//                }];
                
                GWSDKPayPluginOrder * payorder = [[GWSDKPayPluginOrder alloc] init];
                payorder.amount = 20.0;
                payorder.productId = 123;
                payorder.productName = @"product name test";
                payorder.productCount = 1;
                payorder.payDescription = @"nothing of payDescription";
                payorder.roleId = @"0";
                payorder.zoneId = @"0";
                payorder.gameextend = @"nothing with gameextend";
                payorder.productDisplayTitle = @"元宝十个";
                
                if ([GWUser isAuthenticated]) {
                    [GWGameWorks showGWSDKPaymentViewController:payorder];
                }else{
                    [self alertMsg:@"您还未登录"];
                }
                
                //[GWGameWorks showGWSDKPaymentViewController];
                
                //[self rechargeAction];
            }
                break;
            case 4:
            {
                [GWGameWorks showGWSDKUserLoginCenterViewController];
                //[self swapAccountAction];
            }
                break;
            case 5:
            {
                [GWUser logOutInBackgroundblock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [self alertMsg:@"已注销"];
                    }else{
                        [self alertMsg:@"注销失败"];
                    }
                }];
                
                //[self loginOutAction];
            }
                break;
            case 6:
            {
                if ([GWUser isAuthenticated]) {
                    [GWGameWorks showGWSDKUserCenterViewController];
                }else{
                    [self alertMsg:@"您还未登录"];
                }

               // [self userCenterAction];
            }
                break;
            
            case 7:
            {
                // [self checkOrderState];
               [GWGameWorks checkorderstatusblock:^(BOOL succeeded, NSString *string, NSString *msg) {
                   if (succeeded) {
                       [self alertMsg:[NSString stringWithFormat:@"订单号：%@,状态：%@",string,msg]];
                   }else{
                       [self alertMsg:[NSString stringWithFormat:@"加载失败 订单号：%@",string]];
                   }
               }];
                
//                https://bitbucket.org/
                
//                [GWGameWorks showGWSDKPaymentHistoryViewController];
            }
                break;
                break;
            case 8:
            {
                if ([GWUser isAuthenticated]) {
                    [self alertMsg:@"已登录"];
                }else{
                    [self alertMsg:@"未登录"];
                }
                //[self haslogined];
            }
                break;
            case 9:
            {
                
                if ([GWUser isAuthenticated]) {
                    NSString * str =[NSString stringWithFormat:@"username:%@, nickname:%@,userId:%@",[GWUser currentUser].username,[GWUser currentUser].nickname,[GWUser currentUser].userId];
                    [self alertMsg:str];
                }else{
                    [self alertMsg:@"您还未登录"];
                }
                
                //[self getCurrentLoginUserInfo];
            }
                break;
                
            case 10:
            {
                isshoworhidden = !isshoworhidden;
                [GWGameWorks showBanner:isshoworhidden];
            }
                break;
                
            default:
                break;
        }
        
    }else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
               // [self statisticsUserLoginAction];
                break;
            case 1:
               // [self statisticsPayAction];
                break;
            case 2:
               // [self statisticsCreateRoleAction];
                break;
            case 3:
                //[self statisticsUserUpGradeAction];
            case 4:
                //[self statisticsBtnClickEventAction];
            default:
                break;
        }
        
    }
}


#pragma mark - uitableviewdatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 12;
            break;
        case 1:
            return 5;
            break;
        default:
            break;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItemsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemsCell"];
    if (!cell) {
        cell = [[MenuItemsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ItemsCell"];
    }else
    {
        cell.titleLable.text = @"";
    }
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                cell.titleLable.text = @"注册用户登录(@required)";
                break;
            case 1:
                cell.titleLable.text = @"游客登录(@required)";
                break;
            case 2:
                cell.titleLable.text = @"游客转注册用户(@required)";
                break;
            case 3:
                cell.titleLable.text = @"充值支付(@required)";
                break;
            case 4:
                cell.titleLable.text = @"切换用户(@required)";
                break;
            case 5:
                cell.titleLable.text = @"登录注销(@required)";
                break;
            case 6:
                cell.titleLable.text = @"用户中心(@required)";
                break;
             
            case 7:
                cell.titleLable.text = @"订单查询(@optional)";
                break;
            case 8:
                cell.titleLable.text = @"检查是否登录(@optional)";
                break;
            case 9:
                cell.titleLable.text = @"获取登录用户数据(@optional)";
                break;
            case 10:
                cell.titleLable.text = @"设置悬浮隐藏或者显示(@optional)";
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                cell.titleLable.text = @"登录统计(@required)";
                break;
            case 1:
                cell.titleLable.text = @"支付统计(@required)";
                break;
            case 2:
                cell.titleLable.text = @"创建角色(@required)";
                break;
            case 3:
                cell.titleLable.text = @"等级提升(@required)";
                break;
            case 4:
                cell.titleLable.text = @"按钮点击(@optional)";
                break;
            default:
                break;
        }
    }
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"常规接口(common interface)";
            break;
        case 1:
            return @"统计相关（about statistics）";
            break;
        default:
            break;
    }
    return [@"test_" stringByAppendingFormat:@"%lu",(long)section];
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

// 是否支持转屏
- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// 支持的屏幕方向，此处可直接返回 UIInterfaceOrientationMask 类型
// 也可以返回多个 UIInterfaceOrientationMask 取或运算后的值
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}



@end
