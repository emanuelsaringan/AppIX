//
//  LGVideoListViewController.m
//  AppIX
//
//  Created by Emanuel Saringan on 10/24/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import "LGVideoListViewController.h"
#import "LGVideo.h"
#import "LGDetailViewController.h"

@interface LGVideoListViewController()

@property (nonatomic,strong) LGVideo* video;

@end

@implementation LGVideoListViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"videos" ofType:@"plist"];
    NSDictionary* videosDict = [NSDictionary dictionaryWithContentsOfFile:bundle];
    NSArray* videoList = [videosDict objectForKey:self.videoCode];
    NSUInteger videosCnt = [videoList count];
    
    for (NSUInteger i = 0; i < videosCnt; i++) {
        NSDictionary* video = [videoList objectAtIndex:i];
        
        LGVideo* videoObj = [[LGVideo alloc] init];
        videoObj.name = [video objectForKey:@"name"];
        videoObj.videoID = [video objectForKey:@"id"];
        
        [self insertNewObject:videoObj];
    }
}

- (void)insertNewObject:(LGVideo*)videoObj {
    [self.objects addObject:videoObj];
}

-(NSMutableArray*) objects {
    if (!_objects) {
        [self setObjects:[[NSMutableArray alloc] init]];
    }
    
    return _objects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VideoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LGVideo* video = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = video.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.video = [self.objects objectAtIndex:indexPath.row];
    
    // Get Detail View
    UINavigationController* detailNavController = [self.parentViewController.parentViewController.childViewControllers
                                                   lastObject];
    LGDetailViewController* detailViewController = [[detailNavController childViewControllers] objectAtIndex:0];
    
    // Load HTML file
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* htmlFile = [mainBundle pathForResource:@"video" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    // Prepare template vars
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{NAME}}" withString:self.video.name];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"{{VIDEO_ID}}" withString:self.video.videoID];
    
    [detailViewController.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[mainBundle bundlePath]]];
    
    // Set title
    detailViewController.navigationItem.title = self.video.name;
}

@end
