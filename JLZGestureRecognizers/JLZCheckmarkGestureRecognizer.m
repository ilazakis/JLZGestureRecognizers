//
//  JLZCheckmarkGestureRecognizer.m
//  TouchesAndGestures
//
//  Created by Joakim Lazakis on 1/19/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import "JLZCheckmarkGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation JLZCheckmarkGestureRecognizer
{
    // The first half of the checkmark movement (southeast direction)
    BOOL firstHalf;
    
    // The second half of the checkmark movement (northeast direction)
    BOOL secondHalf;
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
    
    if (self.state == UIGestureRecognizerStateFailed){return;}
    
    // If touches are not moving upwards
    if (!secondHalf)
    {
        // Reference to previous location
        CGPoint previousLocation = [[touches anyObject] previousLocationInView:self.view];
        
        // Reference to new location
        CGPoint newLocation = [[touches anyObject] locationInView:self.view];
        
        // If touches are moving towards the RIGHT and DOWN we recognize the first half of the movement
        if (newLocation.x >= previousLocation.x && newLocation.y >= previousLocation.y)
        {
            firstHalf = YES;
        }
        // Else if touches are moving towards the RIGHT and UP,
        // and we have already gone through the first half (RIGHT and DOWN)
        // we recognize the second half of the movement
        else if (newLocation.x >= previousLocation.x && newLocation.y <= previousLocation.y && firstHalf)
        {
            secondHalf = YES;
        }
        else
        {
            self.state = UIGestureRecognizerStateFailed;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    // If the second half of the gesture has been recognized,
    // and the recognizer's state is still possible (i.e. has not failed or cancelled),
    // the gesture is recognized
    if (secondHalf && self.state == UIGestureRecognizerStatePossible)
    {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];

    // If the gesture is cancelled transition to the failed state
    // (which will lead to a call to reset)
    self.state = UIGestureRecognizerStateFailed;
}

// Reset is automatically called whenever the recognizer's state swicthes to "failed"
- (void)reset
{
    [super reset];
    secondHalf = NO;
    firstHalf = NO;
    self.state = UIGestureRecognizerStatePossible;
}
@end
