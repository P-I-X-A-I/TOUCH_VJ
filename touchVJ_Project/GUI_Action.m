
#import "mainController.h"

@implementation mainController ( GUI )

//- (IBAction)button_SegmentedControll:(UISegmentedControl*)sender
- (IBAction)segment_ParamSettingTab:(UISegmentedControl*)sender
{
    NSLog(@"SEGMENT");
    unsigned int numOfSegments = sender.numberOfSegments;
    unsigned int INDEX = sender.selectedSegmentIndex;
    
    moduleBasis* currentModule = [module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX];
    NSMutableArray* currentModuleView_ARRAY = currentModule.viewForSegment_ARRAY;
    UIView* nextView;
    
    if( INDEX == (numOfSegments - 1) )
    {
        nextView = SegmentSettingView;
    }
    else
    {
       nextView =[currentModuleView_ARRAY objectAtIndex:INDEX];
    }
    
        [current_Segment_View removeFromSuperview];
        [SegmentContainerView addSubview:nextView];
        current_Segment_View = nextView;
}



- (IBAction)button_Cue:(UIButton*)sender
{
    [self longPress_Cancel];
    [self pan_Cancel];
    [self pinch_Cancel];
    
    BPM_COUNTER = 0.0;
    CurrentTempo = 0;

}

- (IBAction)slider_BPM:(UISlider*)sender
{    
    BPM = (Byte)[sender value];
    LABEL_BPM.text = [NSString stringWithFormat:@"%d", BPM];
    LABEL_BPM2.text = [NSString stringWithFormat:@"%d", BPM];

    double timeFor_16beats = (60.0 / (double)BPM)*16.0;
    incrementFor_1frame = 0.01666666666666 / timeFor_16beats;
}

- (IBAction)slider_fader:(UISlider*)sender
{
    FADER = [sender value];
    
    LABEL_FADER.text = [NSString stringWithFormat:@"%1.2f", FADER];
    LABEL_FADER2.text = [NSString stringWithFormat:@"%1.2f", FADER];
}



- (IBAction)button_SetDefault:(UIButton*)sender
{
    NSString* alertMessage;
    
    if( [language isEqualToString:@"ja"] )
    {
        alertMessage = [NSString stringWithString:@"パラメータを初期値にリセットします。よろしいですか？"];
    }
    else
    {
        alertMessage = [NSString stringWithString:@"All Parameters will be reset. OK?"];
    }
    
    ALERT_VIEW = [[UIAlertView alloc] initWithTitle:@"Parameter Reset"
                                            message:alertMessage
                                           delegate:self 
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"OK", nil];
    
    [ALERT_VIEW show];
    
}






- (IBAction)segment_tempo_loop:(UISegmentedControl*)sender
{
    NSLog(@"SEGMENT Tempo Loop");
    [self longPress_Cancel];
    [self pan_Cancel];
    [self pinch_Cancel];
    
    int INDEX = sender.selectedSegmentIndex;
    
    
    switch (INDEX) {
        case 0:
            BPM_COUNTER = 0.0;
            CurrentTempo = 0;
            
            CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] = 0;
            break;
        case 1:
            if( CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] == 2 )
            {
                BPM_COUNTER = 0.0;
                CurrentTempo = 0;
            }
            CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] = 1;
            break;
        case 2:
            CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX] = 2;
            break;
        default:
            break;
    }
}

- (IBAction)segment_clear_gesture:(UISegmentedControl*)sender
{
    NSLog(@"SEGMENT Clear Gesture");
    [self longPress_Cancel];
    [self pan_Cancel];
    [self pinch_Cancel];
   
    int INDEX = sender.selectedSegmentIndex;
    
    switch (INDEX) {
        case 0:            
            [self clearTap:SLOT_INDEX moduleIndex:CURRENT_MODULE_INDEX];
        break;
        case 1:
            [self clearLongPress:SLOT_INDEX moduleIndex:CURRENT_MODULE_INDEX];
         break;
        case 2:
            [self clearPan:SLOT_INDEX moduleIndex:CURRENT_MODULE_INDEX];
        break;
        case 3:
            [self clearPinch:SLOT_INDEX moduleIndex:CURRENT_MODULE_INDEX];
        break;
        default:
        break;
    }
}


- (IBAction)segment_slot_index:(UISegmentedControl*)sender
{
    NSLog(@"SEGMENT Slot Index");
    [self longPress_Cancel];
    [self pan_Cancel];
    [self pinch_Cancel];
    
    SLOT_INDEX = sender.selectedSegmentIndex;
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] setCurrentSlotIndex:SLOT_INDEX];
    
    [self initGUI];
}




// Clear gesture

- (void)clearTap:(Byte)index moduleIndex:(short)M_INDEX
{
    int i;
    for( i = 0 ; i < 64 ; i++ )
    {
        State_Tap[index][M_INDEX][i] = NO;
    }
}
- (void)clearLongPress:(Byte)index moduleIndex:(short)M_INDEX
{
    int i, j;
    for( i = 0 ; i < MAX_LONGPRESS_POINT ; i++ )
    {
        for( j = 0 ; j < 64 ; j++ )
        {
            State_LongPress[index][M_INDEX][i][j] = NO;
        }
        Value_LongPress[index][M_INDEX][i][0] = -20.0f;
        Value_LongPress[index][M_INDEX][i][1] = -20.0f;
    }
    
    LongPress_INDEX[index][CURRENT_MODULE_INDEX] = 0;
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopLongPress:SLOT_INDEX];

}
- (void)clearPan:(Byte)index moduleIndex:(short)M_INDEX
{
    int i;
    for( i = 0 ; i < POINTS_OF_PAN ; i++ )
    {
        State_Pan[index][M_INDEX][i] = NO;
        isPanHead[index][M_INDEX][i] = 0;
        Value_Pan[index][M_INDEX][i][0] = 0.0f; // point x
        Value_Pan[index][M_INDEX][i][1] = 0.0f; // point y
        Value_Pan[index][M_INDEX][i][2] = 0.0f; // trans x
        Value_Pan[index][M_INDEX][i][3] = 0.0f; // trans y
        Value_Pan[index][M_INDEX][i][4] = 0.0f; // vec x
        Value_Pan[index][M_INDEX][i][5] = 0.0f; // vex y
        Value_Pan[index][M_INDEX][i][6] = 0.0f; // velocity
    }
    isPanHead[index][M_INDEX][0] = 1;
    isPanHead[index][M_INDEX][POINTS_OF_PAN-1] = 2;
    
    for( i = 0 ; i < 7 ; i++ )
    {
        last_Value_Pan[i] = 0.0f;
    }
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopPan];
    
}
- (void)clearPinch:(Byte)index moduleIndex:(short)M_INDEX
{
    int i;
    for( i = 0 ; i < 128 ; i++ )
    {
        State_Pinch[index][M_INDEX][i] = NO;
        Value_Pinch_Center[index][M_INDEX][i][0] = 0.0f;
        Value_Pinch_Center[index][M_INDEX][i][1] = 0.0f;
        Value_Pinch_Radius[index][M_INDEX][i] = 0.0f;
        Value_Pinch_Scale[index][M_INDEX][i] = 0.0f;
        Value_Pinch_Velocity[index][M_INDEX][i] = 0.0f;
        isPinchHead[index][M_INDEX][i] = 0;
    }
    
    isPinchHead[index][M_INDEX][0] = 1;
    isPinchHead[index][M_INDEX][127] = 2;
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] stopPinch];
}
@end