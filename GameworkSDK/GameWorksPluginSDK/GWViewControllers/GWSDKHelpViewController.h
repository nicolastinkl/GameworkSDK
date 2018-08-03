//
//  GWSDKHelpViewController.h
//  GameWorksSDK
//
//  Created by tinkl on 21/1/15.
//  Copyright (c) 2015年 ___GAMEWORK___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWSDKViewController.h"

@interface GWSDKHelpViewController : GWSDKViewController


@property (nonatomic, strong) IBOutlet UITableView *answersTableView;
@property (nonatomic, strong) IBOutlet UITableView *indexTableView;
@property (nonatomic, strong) NSMutableArray *questions;

@property (assign) NSInteger selectedRow;

@property (assign) float highlightedQuestionDelay;
@property (assign) float highlightedQuestionDuration;
@property (assign) BOOL questionsAreUppercase;
@property (nonatomic, strong) NSString *indexTitle;
@property (nonatomic, strong) UIColor *highlightedQuestionColor;
@property (nonatomic, strong) UIFont *fontForQuestions;
@property (nonatomic, strong) UIFont *fontForAnswers;

- (void)addQuestion:(NSString *)question withAnswer:(NSString *)answer;
- (NSUInteger)numberOfQuestions;
- (NSString *)questionTextForQuestion:(NSArray *)question;
- (NSString *)answerTextForQuestion:(NSArray *)question;

#pragma mark - Customization
- (void)setSectionHeadersToUppercase:(BOOL)isUppercase;

@end
