//
//  ViewController.m
//  JLZGestureRecognizers
//
//  Created by Joakim Lazakis on 1/19/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import "ViewController.h"
#import "JLZCheckmarkGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JLZCheckmarkGestureRecognizer *checkmarkRecognizer = [[JLZCheckmarkGestureRecognizer alloc] initWithTarget:self action:@selector(handleCheckMark:)];
    [self.view addGestureRecognizer:checkmarkRecognizer];
}

- (void)handleCheckMark:(JLZCheckmarkGestureRecognizer *)recognizer
{
    NSLog(@"Checkmark Gesture Recognized!");
}

@end
