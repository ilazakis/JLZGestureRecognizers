//
//  JLZTouchTracker.m
//  JLZGestureRecognizers
//
//  Created by Joakim Lazakis on 2/14/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import "JLZTouchTracker.h"

#pragma mark - Local constants

static const CGFloat kLineWidth = 4.0;  // Default value for the path/drawing line width

#pragma mark - Class extension

@interface JLZTouchTracker ()

@property (nonatomic) UIBezierPath *trackPath;

@end

#pragma mark - Class implementation

@implementation JLZTouchTracker

#pragma mark - Initializers

// Initializer. Calls setup method to set default values
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUp];
    }
    
    return self;
}

// Initializer (NIbs). Calls setup method to set default values
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    // 1) Don't allow more than one touches. We do this early(init) as there is no reason to delay it.
    NSLog(@"%i", self.multipleTouchEnabled);
    self.multipleTouchEnabled = NO;
    
    // 2) Create the path we are going to use for tracking/drawing the user's touches. While we can avoid the allocation overhead by delaying this initialization until touches actually start happening, it doesn't make much sense since this view's role is to track touches using a path. So we can assume that if the view is needed, the path is going to be needed too.
    self.trackPath = [UIBezierPath bezierPath];
    
    // 3) Set the path line width
    self.trackPath.lineWidth = kLineWidth;
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    // 1) To draw the view's contents all we need to do is draw the path that has been created by following the user's touches
    [_trackPath stroke];
}

#pragma mark - Touches handling

// When touches are first detected
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{// 1) To draw our view we just have to draw the path
    self.trackPath = [UIBezierPath bezierPath];
    
    // 3) Set the path line width
    self.trackPath.lineWidth = kLineWidth;
    // 1) Grab a touch object and
    UITouch *touch = [touches anyObject];
    
    // 2) update the path
    [_trackPath moveToPoint:[touch locationInView:self]];
}

// When user keeps moving their finger ON the screen
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1) Grab a touch object,
    UITouch *touch = [touches anyObject];
    
    // 2) update (append to) the path and
    [_trackPath addLineToPoint:[touch locationInView:self]];
    
    // 3) we notify the system that the view's (this view's) content needs to be redrawn
    [self setNeedsDisplay];
}

// When the user lifts their finger
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1) Grab a touch object,
    UITouch *touch = [touches anyObject];
    
    // 2) update (append to) the path and
    [_trackPath addLineToPoint:[touch locationInView:self]];
    
    // 3) we notify the system that the view's (this view's) content needs to be redrawn
    [self setNeedsDisplay];
}

// If the touch/drawing is cancelled (e.g. finger slides off the screen or system demands it)
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1) Simply delegate to touchesEnded:
    [self touchesEnded:touches withEvent:event];
}

@end
