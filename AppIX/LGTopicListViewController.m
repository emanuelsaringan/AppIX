//
//  LGMasterViewController.m
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import "LGTopicListViewController.h"
#import "LGSubtopicListViewController.h"
#import "LGTopic.h"
#import "LGSubtopic.h"

@interface LGTopicListViewController ()

@property (nonatomic,strong) NSMutableArray* objects;

@end

@implementation LGTopicListViewController

- (void)awakeFromNib {
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString* bundle = [[NSBundle mainBundle] pathForResource:@"topics" ofType:@"plist"];
    NSArray* topics = [NSArray arrayWithContentsOfFile:bundle];
    NSUInteger topicsCnt = [topics count];

    for (NSUInteger i = 0; i < topicsCnt; i++) {
        NSDictionary* topic = [topics objectAtIndex:i];
        
        LGTopic* topicObj = [[LGTopic alloc] init];
        topicObj.code = [topic objectForKey:@"code"];
        topicObj.name = [topic objectForKey:@"name"];
        topicObj.desc = [topic objectForKey:@"desc"];
        topicObj.subtopics = [topic objectForKey:@"subtopics"];
        
        [self insertNewObject:topicObj];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(LGTopic*)topicObj {
    [self.objects addObject:topicObj];
}

-(NSMutableArray*) objects {
    if (!_objects) {
        [self setObjects:[[NSMutableArray alloc] init]];
    }
    
    return _objects;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.objects) {
        return 0;
    }
    
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];

    LGTopic* object = self.objects[indexPath.row];
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.desc;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Handled in prepareForSegue
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"topic_subtopic" isEqualToString:segue.identifier]) {
        LGSubtopicListViewController* subtopicListViewController = (LGSubtopicListViewController*) segue.destinationViewController;
        
        // Get indexPath
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        NSArray* subtopics = [[self.objects objectAtIndex:indexPath.row] subtopics];
        NSUInteger subtopicsCnt = [subtopics count];
        for (NSUInteger i = 0; i < subtopicsCnt; i++) {
            NSMutableDictionary* subtopicDict = [subtopics objectAtIndex:i];
            
            LGSubtopic* subtopic = [[LGSubtopic alloc] init];
            subtopic.code = [subtopicDict objectForKey:@"code"];
            subtopic.name = [subtopicDict objectForKey:@"name"];
            
            [subtopicListViewController.objects addObject:subtopic];
        }
    }
}

@end
