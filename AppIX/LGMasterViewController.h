//
//  LGMasterViewController.h
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGDetailViewController;

@interface LGMasterViewController : UITableViewController

@property (strong, nonatomic) LGDetailViewController *detailViewController;

@end