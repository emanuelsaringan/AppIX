//
//  LGDetailNavigationViewController.m
//  AppIX
//
//  Created by Emanuel Saringan on 10/28/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import "LGDetailNavigationViewController.h"

@implementation LGDetailNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor greenColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
