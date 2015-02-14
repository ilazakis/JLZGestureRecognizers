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
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *xImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JLZCheckmarkGestureRecognizer *checkmarkRecognizer = [[JLZCheckmarkGestureRecognizer alloc] initWithTarget:self action:@selector(handleCheckMark:)];
    [self.view addGestureRecognizer:checkmarkRecognizer];
    
    JLZXGestureRecognizer *xRecognizer = [[JLZXGestureRecognizer alloc] initWithTarget:self action:@selector(handleX:)];
    [self.view addGestureRecognizer:xRecognizer];
}

- (void)handleCheckMark:(JLZCheckmarkGestureRecognizer *)recognizer
{
    NSLog(@"Checkmark Gesture Recognized!");
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         
                         self.checkMarkImageView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5 delay:0.0 options:
                          UIViewAnimationOptionCurveEaseIn animations:^ {
                              
                              self.checkMarkImageView.alpha = 0;
                              
                          } completion:^ (BOOL completed) {}];
                     }];
}

- (void)handleX:(JLZXGestureRecognizer *)recognizer
{
     NSLog(@"X Gesture Recognized!");
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         
                         self.xImageView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:1.0 delay:0.5 options:
                          UIViewAnimationOptionCurveEaseIn animations:^ {
                              
                              self.xImageView.alpha = 0;
                              
                          } completion:^ (BOOL completed) {}];
                     }];
}

@end
