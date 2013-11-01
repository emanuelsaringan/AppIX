//
//  LGDetailViewController.m
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import "LGDetailViewController.h"

@implementation LGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load trivia/featured article
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* triviaFile = [mainBundle pathForResource:@"trivia" ofType:@"plist"];
    NSArray* triviaArray = [NSArray arrayWithContentsOfFile:triviaFile];
    NSString* trivia = triviaArray[arc4random() % [triviaArray count]];
    
    // Load HTML file
    NSString* htmlFile = [mainBundle pathForResource:@"featured" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    // Set template vars
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{TRIVIA}}" withString:trivia];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[mainBundle bundlePath]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
