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
    
    // Load HTML file
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* htmlFile = [mainBundle pathForResource:@"featured" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    // Load trivia/featured article
    NSString* triviaFile = [mainBundle pathForResource:@"trivia" ofType:@"plist"];
    NSMutableArray* triviaArray = [NSMutableArray arrayWithContentsOfFile:triviaFile];
    
    // Fisher - Yates algorithm for shuffling
    NSUInteger triviaArrayCnt = [triviaArray count];
    NSUInteger startIndex = triviaArrayCnt - 1;
    NSUInteger endIndex = startIndex - 5;
    for (NSUInteger i = startIndex; i >= endIndex; i--) {
        NSUInteger randIndex = arc4random() % triviaArrayCnt;
        // Set template vars
        NSString* patternToReplace = [NSString stringWithFormat:@"{{TRIVIA_%d}}", triviaArrayCnt - i];
        htmlString = [htmlString stringByReplacingOccurrencesOfString:patternToReplace withString:triviaArray[randIndex]];
        
        NSString* temp = triviaArray[i];
        triviaArray[i] = triviaArray[randIndex];
        triviaArray[randIndex] = temp;
    }
    
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[mainBundle bundlePath]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
