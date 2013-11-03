//
//  LGDetailViewController.h
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
