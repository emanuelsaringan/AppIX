//
//  LGSubtopicListViewController.m
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import "LGSubtopicListViewController.h"
#import "LGDetailViewController.h"
#import "LGSubtopic.h"

@implementation LGSubtopicListViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray*) objects {
    if (!_objects) {
        [self setObjects:[[NSMutableArray alloc] init]];
    }
    
    return _objects;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LGSubtopic* subtopic = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = subtopic.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSubtopic* subtopic = [self.objects objectAtIndex:indexPath.row];
    
    // Get nib to display and its container
    LGDetailViewController *detailViewController = [[LGDetailViewController alloc] initWithNibName:/*subtopic.code*/@"1a"
                                                                                            bundle:nil];
    UINavigationController* detailNavController = [self.parentViewController.parentViewController.childViewControllers
                                                   lastObject];
    
    // Navigate to nib
    [detailNavController popToRootViewControllerAnimated:NO];
    [detailNavController pushViewController:detailViewController animated:NO];
    
    // Set title
    detailViewController.navigationItem.title = subtopic.name;
}

@end
