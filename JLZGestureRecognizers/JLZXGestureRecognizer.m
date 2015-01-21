//
//  JLZXGestureRecognizer.m
//  JLZGestureRecognizers
//
//  Created by Joakim Lazakis on 1/21/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import "JLZXGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static const NSTimeInterval kXGestureTimeout = 0.4;

@interface JLZXGestureRecognizer ()

@property (nonatomic, assign) NSTimeInterval timeout;

@end

@implementation JLZXGestureRecognizer
{
    // The first half of the 'X' gesture can either be a southeast(\)
    BOOL southeast;
    
    // or southwest (/) movement
    BOOL southwest;
    
    // the recognized variable will only become true if:
    // a "southeast"(\) movement is followed by a "southwest"(/) movement or vice versa
    BOOL recognized;
    
    // The timer used to measure timeouts between the two 'X' movements, "/" and "\" (or the opposite)
    NSTimer *timer;
}

- (instancetype)init
{
    return [self initWithTarget:nil action:nil];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    return [self initWithTarget:target action:action timeoutBetweenTouches:kXGestureTimeout];
}

// designated initializer
- (instancetype)initWithTarget:(id)target action:(SEL)action timeoutBetweenTouches:(NSTimeInterval)timeout
{
    if (self = [super initWithTarget:target action:action])
    {
        _timeout = timeout;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    // This is a discrete single-finger gesture, thus if more than one touches are detected it should fail
    if (touches.count != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint previousLocation = [[touches anyObject] previousLocationInView:self.view];
    CGPoint currentLocation = [[touches anyObject] locationInView:self.view];
    
    // if there has already been a "southwest" movement
    if (southwest)
    {
        //
        if (currentLocation.x >= previousLocation.x && currentLocation.y >= previousLocation.y)
        {
            recognized = YES;
        }
    }
    else if (southeast)
    {
        if (currentLocation.x <= previousLocation.x && currentLocation.y >= previousLocation.y)
        {
            recognized = YES;
        }
    }
    else
    {
        //
        if (currentLocation.x <= previousLocation.x && currentLocation.y >= previousLocation.y)
        {
            southwest = YES;
        }
        else if (currentLocation.x >= previousLocation.x && currentLocation.y >= previousLocation.y)
        {
            southeast = YES;
        }
        else
        {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    // if the gesture has been recognized (based on touches) AND the recognizer's state is still "Possible"
    if (recognized && self.state == UIGestureRecognizerStatePossible)
    {
        // the gesture can been "officially" recognized
        self.state = UIGestureRecognizerStateRecognized;
    }
    // else if only the first part of the gesture has been recognized, give the user a timeframe to perform the second part/stroke
    else if((southeast || southwest) && self.state == UIGestureRecognizerStatePossible)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:_timeout target:self selector:@selector(gestureTimeout) userInfo:nil repeats:NO];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    // set state to "Failed", a change that will automatically trigger a call to the reset method
    self.state = UIGestureRecognizerStateFailed;
}

- (void)reset
{
    [super reset];
    
    // reset ivars and prepare for the next potential recognition
    southeast = NO;
    southwest = NO;
    recognized = NO;
    [timer invalidate];
    self.state = UIGestureRecognizerStatePossible;
}

// Called upon timeout (time allowed between 'X' strokes)
- (void)gestureTimeout
{
    self.state = UIGestureRecognizerStateFailed;
}
@end
