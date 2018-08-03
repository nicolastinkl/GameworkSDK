//
//  GWSDKWebViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 15/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKWebViewController.h"
#import "SVProgressHUD.h"
#import "GWUtility.h"
#import "UIAlertView+GWSDKBlocks.h"
#import "GWMacro.h"
#import "UIColor+iOS7Colors.h"
#import "GWApp.h"

@interface GWSDKWebViewController ()<UIWebViewDelegate>
{
    NSString * url ;
    NSString * currentOrderid;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIButton *Button_close;
@property (weak, nonatomic) IBOutlet UIView *View_head;
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation GWSDKWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.webview.delegate = self;
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.Button_close setImage:[UIImage imageWithContentsOfFile:[GWUtility getFilePathFromBound:@"back_icon"]] forState:UIControlStateNormal];
    
    self.View_head.backgroundColor = [UIColor colorWithRed:29/255.0 green:211/255.0 blue:4/255.0 alpha:1];
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)close_action:(id)sender {
    //弹出提示是否关闭
    [self dismissViewControllerAnimated:YES completion:^{}];
    //通知检查订单是否支付成功
    [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKPaymentCheckResultNotification object:nil];
    
    /* [[[UIAlertView alloc]initWithTitle:@"提示" message:@"暂时没有支付完成，是否退出支付？" cancelButtonItem:[GWSDKRIButtonItem itemWithLabel:@"关闭" action:^{
        
    }] otherButtonItems:[GWSDKRIButtonItem itemWithLabel:@"继续支付" action:^{
        
    }], nil] show];
    */
}

-(void) setWeburl:(GWSDKPayDesStructXX*) payinfo
{
    char * encode_buf = payinfo->urldata;
    NSString *encrypted = [[NSString alloc] initWithCString:(const char*)encode_buf encoding:NSASCIIStringEncoding];
    url = [NSString stringWithCString:(const char*)encode_buf encoding:NSASCIIStringEncoding];
    currentOrderid = [NSString stringWithCString:(const char*)payinfo->ordernumber encoding:NSASCIIStringEncoding];
    [GWUtility printSystemLog:encrypted];
}


/*
 * 方法的返回值是BOOL值。
 * 返回YES：表示让浏览器执行默认操作，比如某个a链接跳转
 * 返回NO：表示不执行浏览器的默认操作，这里因为通过url协议来判断js执行native的操作，肯定不是浏览器默认操作，故返回NO
*/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //+[GWUtility printSystemLog:](330): http://api.mobile.youxigongchang.com/recharge_res.php?orderid=1501227003000008  0
    [GWUtility printSystemLog:[NSString stringWithFormat:@"%@  ",[request URL]]];
    NSURL *urlback = [request URL];
    if (urlback && urlback.host) {
        if ([urlback.host rangeOfString:@"youxigongchang.com"].location != NSNotFound) {
//        if ([urlback.host containsString:@"youxigongchang.com"]) {
            //这里是支付后的成功回调
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKPaymentResultNotification object:@{@"status":@(0),@"ordernumber":currentOrderid}];
             
            [self dismissViewControllerAnimated:YES completion:^{}];
            //通知检查订单是否支付成功
            [[NSNotificationCenter defaultCenter] postNotificationName:kGWSDKPaymentCheckResultNotification object:nil];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败，请重新点击支付按钮"];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
    return YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
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
