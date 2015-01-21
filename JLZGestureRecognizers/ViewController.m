//
//  ViewController.m
//  JLZGestureRecognizers
//
//  Created by Joakim Lazakis on 1/19/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import "ViewController.h"
#import "JLZCheckmarkGestureRecognizer.h"
#import "JLZXGestureRecognizer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JLZCheckmarkGestureRecognizer *checkmarkRecognizer = [[JLZCheckmarkGestureRecognizer alloc] initWithTarget:self action:@selector(handleCheckMark:)];
    [self.view addGestureRecognizer:checkmarkRecognizer];
    
    JLZXGestureRecognizer *xRecognizer = [[JLZXGestureRecognizer alloc] initWithTarget:self action:@selector(handleX:)];
    [self.view addGestureRecognizer:xRecognizer];
}

- (void)handleCheckMark:(JLZCheckmarkGestureRecognizer *)recognizer
{
    NSLog(@"Checkmark Gesture Recognized!");
}

- (void)handleX:(JLZXGestureRecognizer *)recognizer
{
    NSLog(@"X Gesture Recognized!");
}

@end
