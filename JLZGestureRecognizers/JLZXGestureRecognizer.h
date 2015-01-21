//
//  JLZXGestureRecognizer.h
//  JLZGestureRecognizers
//
//  Created by Joakim Lazakis on 1/21/15.
//  Copyright (c) 2015 Joakim Lazakis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLZXGestureRecognizer : UIGestureRecognizer


// Designated initializer.
// Timeout paramater indicates how long the recognizer will wait between the two movements/touches required to recognize an 'X' gesture.
// Keep the timeout variable in mind when using this recognizer along with potential competing recognizers and use the UIGestureRecognizerDelegate methods to manage conflicts/ordering etc.
// Default timeout value is 0.4, i.e. after the first stroke the recognizer will wait for 0.4 seconds before failing
- (instancetype)initWithTarget:(id)target action:(SEL)action timeoutBetweenTouches:(NSTimeInterval)timeout;

@end
