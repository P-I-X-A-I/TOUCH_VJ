#import "mainController.h"

@implementation mainController ( GESTURE )

- (void)setGestureRecognizerToGLESView
{
    NSLog(@"set Gesture Recognizer");
    
    Tap_GR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Tapped:)];
    LongPress_GR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_LongPressed:)];
    Pan_GR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Pan:)];
    Pinch_GR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Pinch:)];
    //Rot_GR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Rotate:)];
    Swipe_GR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesture_Swipe:)];

    LongPress_GR.minimumPressDuration = 0.2;
    Pan_GR.maximumNumberOfTouches = 1;
    Swipe_GR.numberOfTouchesRequired = 2;
    Swipe_GR.direction = UISwipeGestureRecognizerDirectionUp |
                         UISwipeGestureRecognizerDirectionLeft |
                         UISwipeGestureRecognizerDirectionDown |
                         UISwipeGestureRecognizerDirectionRight;
    
    [GLES_View addGestureRecognizer:Tap_GR];
    [GLES_View addGestureRecognizer:LongPress_GR];
    [GLES_View addGestureRecognizer:Pan_GR];
    [GLES_View addGestureRecognizer:Pinch_GR];
    //[GLES_View addGestureRecognizer:Rot_GR];
    [GLES_View addGestureRecognizer:Swipe_GR];
}


- (void)gesture_Tapped:(UITapGestureRecognizer*)GR
{
    CGPoint tapPoint = [GR locationInView:GLES_View];
    
//    switch (GR.state) {
//        case UIGestureRecognizerStatePossible:
//            NSLog(@"Tap possible");
//            break;
//        case UIGestureRecognizerStateBegan:
//            NSLog(@"Tap began");
//            break;
//        case UIGestureRecognizerStateChanged:
//            NSLog(@"Tap changed");
//            break;
//        case UIGestureRecognizerStateEnded:
//            NSLog(@"Tap ended");
//            break;
//        case UIGestureRecognizerStateCancelled:
//            NSLog(@"Tap cancelled");
//            break;
//        case UIGestureRecognizerStateFailed:
//            NSLog(@"Tap failed");
//            break;
//        default:
//            break;
//    }
    
    State_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64] = YES;
    Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][0] = (tapPoint.x-320.0)*0.003125; // -1.0 ~ 1.0
    Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][1] = (tapPoint.y-240.0)*-0.004166666666; // -1.0 ~ 1.0
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] isTapped_X:&Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][0]
                                                                Y:&Value_Tap[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_64][1]
                                                              num:BeatINDEX_64];
    TapColor[3] = 1.0;
    TapAnimation = 0.05;
   // NSLog(@"Tapped %f %f", tapPoint.x, tapPoint.y );
}
- (void)gesture_LongPressed:(UILongPressGestureRecognizer*)GR
{
    int i;
    CGPoint longPressPoint = [GR locationInView:GLES_View];
    
    switch (GR.state) {
        case UIGestureRecognizerStatePossible:
            //NSLog(@"LongPress possible");
        break;
            
        case UIGestureRecognizerStateBegan:
            //NSLog(@"LongPress began");
            
            for( i = 0 ; i < 64 ; i++ )
            {
                State_LongPress[ SLOT_INDEX ][ CURRENT_MODULE_INDEX ][ LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] ][i] = NO;
            }
            
            isLongPressed = YES;
            Value_LongPress[ SLOT_INDEX ][ CURRENT_MODULE_INDEX ][ LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] ][0] = (longPressPoint.x-320.0)*0.003125; // -1.0 ~ 1.0
            Value_LongPress[ SLOT_INDEX ][ CURRENT_MODULE_INDEX ][ LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] ][1] = (longPressPoint.y-240.0)*-0.004166666666; // -1.0 ~ 1.0
        break;
            
        case UIGestureRecognizerStateChanged:
            //NSLog(@"LongPress changed");
        break;
            
        case UIGestureRecognizerStateEnded:
            [self longPress_Cancel];
            break;
            
        case UIGestureRecognizerStateCancelled:
            //NSLog(@"LongPress cancelled");
            [self longPress_Cancel];
        break;
            
        case UIGestureRecognizerStateFailed:
            //NSLog(@"LongPress failed");
        break;
            
        default:
        break;
    }
    
    //NSLog(@"LongPress %f %f", longPressPoint.x, longPressPoint.y );
}

- (void)longPress_Cancel
{
    if( isLongPressed )
    {
        isLongPressed = NO;
        LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX]++;
        if( LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] == MAX_LONGPRESS_POINT )
        {
            LongPress_INDEX[SLOT_INDEX][CURRENT_MODULE_INDEX] = 0;
        }
    }
}


- (void)gesture_Pan:(UIPanGestureRecognizer*)GR
{
    CGPoint position = [GR locationInView:GLES_View];
    CGPoint translation = [GR translationInView:GLES_View];
    CGPoint velocity = [GR velocityInView:GLES_View];
    
    GLfloat posX, posY, transX, transY;
    posX = (position.x-320.0)*0.003125;
    posY = (position.y-240.0)*-0.004166666666;
    transX = translation.x*0.003125;
    transY = translation.y*-0.004166666666;
    
    GLfloat velocityValue = sqrtf(velocity.x*velocity.x + velocity.y*velocity.y);
    GLfloat normWeight = 1.0f / velocityValue;
    
    
    switch (GR.state) {
        case UIGestureRecognizerStatePossible:
           // NSLog(@"Pan possible");
            break;
        case UIGestureRecognizerStateBegan:
            //NSLog(@"Pan began");
            isPan = YES;
            isPanHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] = 1;
            State_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] = YES;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][0] = last_Value_Pan[0] = posX;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][1] = last_Value_Pan[1] = posY;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][2] = last_Value_Pan[2] = transX;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][3] = last_Value_Pan[3] = transY;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][4] = last_Value_Pan[4] = velocity.x * normWeight;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][5] = last_Value_Pan[5] = -velocity.y * normWeight;
            Value_Pan[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256][6] = last_Value_Pan[6] = velocityValue;
                        
            break;
        case UIGestureRecognizerStateChanged:
           // NSLog(@"Pan changed");
            
            last_Value_Pan[0] = posX;
            last_Value_Pan[1] = posY;
            last_Value_Pan[2] = transX;
            last_Value_Pan[3] = transY;
            last_Value_Pan[4] = velocity.x * normWeight;
            last_Value_Pan[5] = -velocity.y * normWeight;
            last_Value_Pan[6] = velocityValue;
            break;
        case UIGestureRecognizerStateEnded:
            //NSLog(@"Pan ended");
            [self pan_Cancel];
            break;
        case UIGestureRecognizerStateCancelled:
            //NSLog(@"Pan cancelled");
            [self pan_Cancel];
            break;
        case UIGestureRecognizerStateFailed:
           // NSLog(@"Pan failed");
            break;
        default:
            break;
    }
}

- (void)pan_Cancel
{
    int i;
    
    if( isPan )
    {
        isPan = NO;
        isPanHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_256] = 2;
   }
    
    for( i = 0 ; i < 7 ; i++ )
    {
        last_Value_Pan[i] = 0.0f;
    }
}






- (void)gesture_Pinch:(UIPinchGestureRecognizer*)GR
{
    CGPoint pinchCenter = [GR locationInView:GLES_View];
    CGFloat Scale = GR.scale;
    CGFloat Velocity = GR.velocity;
    
    GLfloat center_X = (pinchCenter.x - 320.0)*0.003125;
    GLfloat center_Y = (pinchCenter.y - 240.0)*-0.004166666666;
    
    GLfloat eachTouchPosition[2][2];
    
    switch (GR.state) {
            
        case UIGestureRecognizerStatePossible:
            NSLog(@"Pinch possible");
            break;
            
            
        case UIGestureRecognizerStateBegan:
            //NSLog(@"Pinch began"); // num of touches is always 2
            isPinch = YES;
            isPinchHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = 1;
            State_Pinch[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = YES;
            Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][0] = last_Pinch_Center[0] = center_X;
            Value_Pinch_Center[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128][1] = last_Pinch_Center[1] = center_Y;
            
            eachTouchPosition[0][0] = ([GR locationOfTouch:0 inView:GLES_View].x-320.0f)*0.003125;
            eachTouchPosition[0][1] = ([GR locationOfTouch:0 inView:GLES_View].y-240.0f)*-0.003125;
            eachTouchPosition[1][0] = ([GR locationOfTouch:1 inView:GLES_View].x-320.0f)*0.003125;
            eachTouchPosition[1][1] = ([GR locationOfTouch:1 inView:GLES_View].y-240.0f)*-0.003125;
            
            last_Pinch_Radius = sqrtf(
                                      (eachTouchPosition[0][0] - eachTouchPosition[1][0])*(eachTouchPosition[0][0] - eachTouchPosition[1][0]) +
                                      (eachTouchPosition[0][1] - eachTouchPosition[1][1])*(eachTouchPosition[0][1] - eachTouchPosition[1][1])
                                      )*0.5f;
            
            last_Pinch_Scale = Scale;
            last_Pinch_Velocity = Velocity;
            break;
            
            
        case UIGestureRecognizerStateChanged:
            //NSLog(@"Pinch changed")
            if( [GR numberOfTouches] < 2 )
            {
                [self pinch_Cancel];
                break;
            }
            
            last_Pinch_Center[0] = center_X;
            last_Pinch_Center[1] = center_Y;
            
            last_Pinch_Scale = Scale;
            last_Pinch_Velocity = Velocity;
            break;
            
            
        case UIGestureRecognizerStateEnded:
           // NSLog(@"Pinch ended");
            [self pinch_Cancel];
            break;
            
        case UIGestureRecognizerStateCancelled:
            //NSLog(@"Pinch cancelled");
            [self pinch_Cancel];
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"Pinch failed");
            break;
        default:
            break;
    }
    
   //NSLog(@"Pinch scale %1.3f vel %1.3f x %1.3f y %1.3f", Scale, Velocity, pinchCenter.x, pinchCenter.y );
}

- (void)pinch_Cancel
{
    if ( isPinch ) {
        isPinch = NO;
        isPinchHead[SLOT_INDEX][CURRENT_MODULE_INDEX][BeatINDEX_128] = 2;
    }

    last_Pinch_Center[0] = 0.0f;
    last_Pinch_Center[1] = 0.0f;
    last_Pinch_Radius = 0.0f;
    last_Pinch_Scale = 0.0f;
    last_Pinch_Velocity = 0.0f;
}







- (void)gesture_Rotate:(UIRotationGestureRecognizer*)GR
{
    CGPoint rotatePoint = [GR locationInView:GLES_View];
    CGFloat Rotation = [GR rotation];
    CGFloat Velocity = [GR velocity];
    
    switch (GR.state) {
        case UIGestureRecognizerStatePossible:
            NSLog(@"Rotate possible");
            break;
        case UIGestureRecognizerStateBegan:
            NSLog(@"Rotate began");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"Rotate changed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"Rotate ended");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Rotate cancelled");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"Rotate failed");
            break;
        default:
            break;
    }
    
    NSLog(@"Rotation %1.3f velocity %1.3f x %1.3f y %1.3f", Rotation, Velocity, rotatePoint.x, rotatePoint.y);
}
- (void)gesture_Swipe:(UISwipeGestureRecognizer*)GR
{
    
    switch (GR.state) {
        case UIGestureRecognizerStatePossible:
            NSLog(@"Swipe possible");
            break;
        case UIGestureRecognizerStateBegan:
            NSLog(@"Swipe began");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"Swipe changed");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"Swipe ended");
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"Swipe cancelled");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"Swipe failed");
            break;
        default:
            break;
    }

    NSLog(@"swipe");
}


- (void)setGestureEnabled:(BOOL)yn
{
    Tap_GR.enabled = yn;
    LongPress_GR.enabled = yn;
    Pan_GR.enabled = yn;
    Pinch_GR.enabled = yn;
    Rot_GR.enabled = yn;
    Swipe_GR.enabled = yn;
}


@end