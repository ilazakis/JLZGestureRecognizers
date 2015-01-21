# JLZGestureRecognizers
A collection of custom UIGestureRecognizer subclasses. More will be added with time.

1) **JLZCheckmarkGestureRecognizer** recognizes checkmark-like gestures. 

2) **JLZXGestureRecognizer** recognizes 'X' gestures (when both strokes move downwards).
Use the designated initializer to set a specific timeout between the two 'X' stroke movements/touches. Default value is 0.4.
    - (instancetype)initWithTarget:(id)target action:(SEL)action timeoutBetweenTouches:(NSTimeInterval)timeout;

Example uses:

    - (void)viewDidLoad {
	    [super viewDidLoad];
	    
	    JLZCheckmarkGestureRecognizer *checkmarkRecognizer = [[JLZCheckmarkGestureRecognizer alloc] initWithTarget:self action:@selector(handleCheckMark:)];
	    [self.view addGestureRecognizer:checkmarkRecognizer];
	    
	    JLZXGestureRecognizer *xRecognizer = [[JLZXGestureRecognizer alloc] initWithTarget:self action:@selector(handleX:) timeoutBetweenTouches:(0.2)];
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

**TODO**

1. Recognize strokes moving upwards for 'X' gesture.
