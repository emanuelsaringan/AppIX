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
#import "LGVideoListViewController.h"

@interface LGSubtopicListViewController()

@property (nonatomic,strong) LGSubtopic* subtopic;

@end

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
    self.subtopic = [self.objects objectAtIndex:indexPath.row];
    
    if ([self.subtopic.code hasSuffix:@"-vid"]) {
        [self performSegueWithIdentifier:@"subtopic_videos" sender:self];
        return;
    }
    
    // Get Detail View
    UINavigationController* detailNavController = [self.parentViewController.parentViewController.childViewControllers
                                                   lastObject];
    LGDetailViewController* detailViewController = [[detailNavController childViewControllers] objectAtIndex:0];
    
    // Load HTML file
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* htmlFile = [mainBundle pathForResource:self.subtopic.code ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [detailViewController.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[mainBundle bundlePath]]];
    
    // Set title
    detailViewController.navigationItem.title = self.subtopic.name;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"subtopic_videos" isEqualToString:segue.identifier]) {
        LGVideoListViewController* videoList = segue.destinationViewController;
        videoList.title = self.subtopic.name;
        videoList.videoCode = self.subtopic.code;
    }
}

@end
