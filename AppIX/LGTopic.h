//
//  LGTopic.h
//  AppIX
//
//  Created by Emanuel Saringan on 10/19/13.
//  Copyright (c) 2013 lambdageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGTopic : NSObject

@property (nonatomic,strong) NSString* code;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* desc;
@property (nonatomic,strong) NSMutableArray* subtopics;

@end
