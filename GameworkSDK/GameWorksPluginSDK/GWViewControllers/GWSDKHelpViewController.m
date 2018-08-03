//
//  GWSDKHelpViewController.m
//  GameWorksSDK
//
//  Created by tinkl on 21/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import "GWSDKHelpViewController.h"

typedef enum kCRQuestion {
    kCRQuestionQuestion,
    kCRQuestionAnswer,
    kNumberOfCRQuestionParts
} kCRQuestion;

static NSString *kCellIdentifierForTableOfContents	= @"TableOfContentsCell";
static NSString *kCellIdentifierForAnswer			= @"AnswerCell";

@interface GWSDKHelpViewController ()<UITableViewDelegate,UITableViewDataSource>

- (UITableViewCell *)tableOfContentsCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)answerCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath;
@end

@implementation GWSDKHelpViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    _questions = [@[] mutableCopy];
    self.title = @"帮助说明";
    // Customization defaults
    // pale yellow
    _highlightedQuestionColor = [UIColor colorWithRed:248/255.0 green:241/255.0 blue:222/255.0 alpha:1.0];
    _highlightedQuestionDelay = 0.5;
    _highlightedQuestionDuration = 0.75;
    _indexTitle = @"";
    _questionsAreUppercase = YES;
    _fontForAnswers = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    _fontForQuestions = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.selectedRow = -1;
    
    [self.answersTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifierForAnswer];
    [self.indexTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifierForTableOfContents];
    

    // Do any additional setup after loading the view from its nib.
    
    
    NSArray* arrayTitle= @[@"温馨提示",@"支付宝",@"银行卡",@"神州行",@"中国联通",@"中国电信",@"QQ充值卡",@"盛大一卡通",@"骏网一卡通",@"mo9先玩后付"];
    
    
    NSArray * arrayInfo=@[@"温馨提示： 如果充值期间遇到问题，请联系客服   QQ: 3090004270。\n2、	确认订单并提交成功后会跳入第三方支付网站。\n3、	第三方支付可能存在延时,请在扣费成功后耐心等待，不要反复操作,否则无法退还您的费用。",@"       通过网上银行 、网点和消费卡充值到支付宝账户的款项即为支付宝账户余额 ,交易时只需输入支付宝的帐号和支付密码即可完成付款。",@"         快捷支付是支付宝联合各大银行推出的全新最安全、轻松的支付方式 。付款时无需登录网上银行, 也无需开通网银功能 ，只需输入银行卡或信用卡卡号、姓名、身份证号、手机号即可完成付款。\n【特点】\n        安全：3大安全体系设计，让您安心购物\n        便捷：3步在线支付流程，让您轻松购物\n        保障：72小时完成赔付 ， 让您放心购物",@"【支持卡种】\n        卡号17位、密码18位的阿拉伯数字。\n【支持面额】\n        10，20，30，50，100，200，300，500，1000元\n【重要提示】\n        请务必使用与此面额相同的移动充值卡，否则会导致支付不成功,或支付金额丢失(使用面额100元的移动充值卡但选择50元 , 高于50元部分不返还;使用50元卡但选择100元, 支付失败,50元不返还。）不支持彩铃充值卡和短信充值卡,选择任何面额彩铃充值卡，将不予退还任何金额。",@"【支持卡种】\n        联通全国卡，卡号15位阿拉伯数字，密码19位阿拉伯数字。\n【支持面额】\n        20，30，50，100，300，500元\n【重要提示】\n        请务必使用与您选择的面额相同的联通充值卡进行支付，否则引起的交易失败交易金额不予退还。\n        如：选择50元面额但使用100元卡支付，则系统认为实际支付金额为50元，高于50元部分不予退还；选择50元面额但使用30元卡支付则系统认为支付失败，30元不予退还。",@"【支持卡种】\n        中国电信充值付费卡卡号19位，密码18位的阿拉伯数字。\n        目前只支持电信全国卡和广东卡，充值卡序列号第四位为“1”的卡为全国卡，为“2”的则为地方卡。\n【支持面额】\n        50，100元\n【重要提示】\n       请务必使用与您所选择的面额相同的电信卡进行支付,否则引起的交易失败或交易金额丢失，我方不予承担！",@"【支持卡种】\n        全国各地Q币卡，卡号：9位的阿拉伯数字、密码：12位的阿拉伯数字。\n【支持面额】\n        10，15，20，30，60，100，200元\n【重要提示】\n       请务必使用与您所选面额相同的Q币卡进行支付,否则您将承担因此而引起的交易失败或者交易金额丢失所造成的损失。",@"【支持卡种】\n       卡号15位或16位的数字字母,密码8位或9位的阿拉伯数字。\n【支持面额】\n        实卡面值：  10 ，30 ，35 ，45 ，100，350，1000元\n【温馨提示】\n        请使用卡号以CSC5 、CS 、S、CA 、CSB 、YA 、YB 、YC、YD、80133开头的“盛大互动娱乐卡”进行支付。",@"【支持卡种】\n       卡号、密码都是16位的阿拉伯数字。\n【支持面额】\n        10，15，30，50，100元\n【温馨提示】\n        不能使用特定游戏专属充值卡支付  .   特定游戏包括大唐风云、传说、蜗牛、猫扑一卡通、九鼎、雅典娜、山河等游戏。\n        在此使用过的骏网一卡通  , 卡内剩余J点只能在富汇易达合作商家进行支付使用。",@"        如何使用mo9先玩后付？\n第1步：先玩\n        选择“mo9先玩后付”, 输入你的手机号码,点击确认后   ,  你的手机短信会在3秒内收到一个验证码,输入验证码后  , 你的游戏币就已购买成功了 ! 同时 , 你的mo9账户已自动生成  , mo9账户号就是你的手机号 , mo9账户的初始登入密码将以短信形式发送到你的手机,你可随时登录mo9官网www.mo9.com查看你的账户详情。\n第2步：后付\n       你有充裕的7天时间登入mo9官网进行充值还款 . 在电脑上或手机上登入 www.mo9.com ( 电脑上的充值还款方式比手机上更多 )  ,  点击网站首页右上角的  “充值还款 ”, 即可对你的mo9账户(账户号即为你的手机号）进行快捷充值或还款 ;你也可以选择先登录你的mo9账户( 账户号即为你的手机号; 初始登录密码之前已发至你的 手机),账户内可清楚查看你的消费记录、信用额度、账户余额、欠款额等信息，点击 “ 充值”，即可进行对mo9账户进行充值或还款。"];
    
    [arrayInfo enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString * title = arrayTitle[idx];
        [self addQuestion:title withAnswer:obj];
    }];
    float height = 56.0f;
    for (int i = 0; i < [self numberOfQuestions]; i++) {
        height += [self tableView:self.indexTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    self.answersTableView.tableHeaderView.frame = CGRectMake(CGRectGetMinX(self.indexTableView.frame), CGRectGetMinY(self.indexTableView.frame), CGRectGetWidth(self.indexTableView.frame), height);
    [self.answersTableView reloadData];
}


#pragma mark - Questions

- (void)addQuestion:(NSArray *)question
{
    if (question && [question count] == kNumberOfCRQuestionParts) {
        [self.questions addObject:question];
    }
}

- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer
{
    [self addQuestion:@[question, answer]];
}

- (NSUInteger)numberOfQuestions
{
    return [self.questions count];
}

- (NSString *)questionTextForQuestion:(NSArray *)question
{
    return question[kCRQuestionQuestion];
}

- (NSString *)answerTextForQuestion:(NSArray *)question
{
    return question[kCRQuestionAnswer];
}

#pragma mark - Tableview Stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger numberOfSections = 1;
    
    if (tableView == self.answersTableView) {
        numberOfSections = [self numberOfQuestions];
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRows = 1;
    
    if (tableView == self.indexTableView) {
        numberOfRows = [self numberOfQuestions];
    }
    
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float width = CGRectGetWidth(tableView.frame) - (2 * 15); // don't forget the margins
    NSString *text;
    UIFont *font;
    
    if (tableView == self.answersTableView) {
        text = [self answerTextForQuestion:self.questions[indexPath.section]];
        font = self.fontForAnswers;
    } else if (tableView == self.indexTableView) {
        text = [self questionTextForQuestion:self.questions[indexPath.row]];
        font = self.fontForQuestions;
        width -= 14; // the accessory view
    }
    
    float height = [text boundingRectWithSize:CGSizeMake(width, INT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    height += 24.0f; // some breathing room
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    
    if (tableView == self.indexTableView) {
        title = self.indexTitle;
    }
    
    if (tableView == self.answersTableView) {
        return [self questionTextForQuestion:self.questions[section]];
    }
    
    if (self.questionsAreUppercase) {
        title = [title uppercaseString];
    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (tableView == self.answersTableView) {
        NSString *title = [self answerTextForQuestion:self.questions[indexPath.section]];
        cell = [self answerCellWithTitle:title forIndexPath:indexPath];
    } else {
        NSString *question = [self questionTextForQuestion:self.questions[indexPath.row]];
        cell = [self tableOfContentsCellWithTitle:question forIndexPath:indexPath];
    }
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //	cell.textLabel.textColor = [tools colorWithIndex:0];
    
    return cell;
}

- (UITableViewCell *)answerCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.answersTableView dequeueReusableCellWithIdentifier:kCellIdentifierForAnswer forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = self.fontForAnswers;
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (self.selectedRow == indexPath.section) {
        cell.backgroundColor = self.highlightedQuestionColor;
        [UIView animateWithDuration:self.highlightedQuestionDuration delay:self.highlightedQuestionDelay options:UIViewAnimationOptionCurveLinear animations:^{
            cell.backgroundColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {
            self.selectedRow = -1;
        }];
    }
    
    return cell;
}

- (UITableViewCell *)tableOfContentsCellWithTitle:(NSString *)title forIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.indexTableView dequeueReusableCellWithIdentifier:kCellIdentifierForTableOfContents forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0];
    cell.textLabel.font = self.fontForQuestions;
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.indexTableView) {
        self.selectedRow = indexPath.row;
        NSIndexPath *indexPathForAnswer = [NSIndexPath indexPathForRow:0 inSection:self.selectedRow];
        [self.answersTableView scrollToRowAtIndexPath:indexPathForAnswer atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.answersTableView reloadData];
    }
}

#pragma mark - Customization Methods

- (void)setSectionHeadersToUppercase:(BOOL)isUppercase
{
    _questionsAreUppercase = isUppercase;
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
