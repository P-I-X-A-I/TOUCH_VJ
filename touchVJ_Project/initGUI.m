#import "mainController.h"

@implementation mainController ( INIT_GUI )

- (void)initGUI
{
    
    // BPM slider
    [SLIDER_BPM setValue:(float)BPM];
    [SLIDER_FADER setValue:FADER];
    LABEL_BPM.text = [NSString stringWithFormat:@"%d", BPM];
    LABEL_BPM2.text = [NSString stringWithFormat:@"%d", BPM];
    LABEL_FADER.text = [NSString stringWithFormat:@"%1.2f", FADER];
    LABEL_FADER2.text = [NSString stringWithFormat:@"%1.2f", FADER];
    
    // slot & loop
    SEGMENT_SLOT_INDEX.selectedSegmentIndex = SLOT_INDEX;
    SEGMENT_LOOP_POINT.selectedSegmentIndex = CURRENT_LOOP_POINT[SLOT_INDEX][CURRENT_MODULE_INDEX];
    
    // Monitor Resolution
    BOOL isDisplayConnected;
    Byte ScreenNum = [[UIScreen screens] count];
    
    if( ScreenNum > 1 )
    { isDisplayConnected = YES; }
    else
    { isDisplayConnected = NO; }
    
    if( isDisplayConnected )
    {
        TABLEVIEW_MONITOR_RESOLUTION.alpha = 1.0f;
        TABLEVIEW_MONITOR_RESOLUTION.allowsSelection = YES;
        
        if( [TableViewCell_ARRAY count] < 11 )
        {
            TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = NO;
        }
        else
        {
            TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = YES;
        }
    }
    else
    {
        TABLEVIEW_MONITOR_RESOLUTION.alpha = 0.5f;
        TABLEVIEW_MONITOR_RESOLUTION.allowsSelection = NO;
        TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = NO;
    }
    
    
    
    if( iPad_model_No == 2 )
    {
        if( isFPS_60 )
        { SEGMENT_FPS.selectedSegmentIndex = 1; }
        else
        { SEGMENT_FPS.selectedSegmentIndex = 0; }
        
        SEGMENT_FPS.enabled = YES;
        SEGMENT_FPS.alpha = 1.0f;
        LABEL_FPS.text = @"";
    }// isIpad2
    else if( iPad_model_No == 1 )
    {
        if( isFPS_60 )
        { SEGMENT_FPS.selectedSegmentIndex = 1; }
        else
        { SEGMENT_FPS.selectedSegmentIndex = 0; }
        
        SEGMENT_FPS.enabled = YES;
        SEGMENT_FPS.alpha = 1.0f;
        LABEL_FPS.text = @"";
//        [SEGMENT_FPS setTitle:@"---" forSegmentAtIndex:1];
//        SEGMENT_FPS.selectedSegmentIndex = 0;
//        SEGMENT_FPS.enabled = NO;
//        SEGMENT_FPS.alpha = 0.25f;
//        LABEL_FPS.text = @"60fps is available only on iPad2.";
//        LABEL_FPS.font = [UIFont systemFontOfSize:12.0];
//        LABEL_FPS.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    }
}


- (void)initSegmentGUI
{
    int i;
    moduleBasis* currentModule = [module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX];
  
    // clear segment bar
    [SEGMENT_PRAM_AND_OPTION removeAllSegments];
    
    // set segment items
    for( i = 0 ; i < currentModule.Num_Of_Pages ; i++ )
    {
        [SEGMENT_PRAM_AND_OPTION insertSegmentWithTitle:[currentModule.segmentPageTitle_ARRAY objectAtIndex:i]
                                                atIndex:i
                                               animated:YES];
    }
    
    // set last segment item
    [SEGMENT_PRAM_AND_OPTION insertSegmentWithTitle:@"Option" atIndex:currentModule.Num_Of_Pages animated:YES];
    
    // select first segment item
    SEGMENT_PRAM_AND_OPTION.selectedSegmentIndex = 0;
    
    // remove segment view
    if( current_Segment_View != nil )
    {
        [current_Segment_View removeFromSuperview];
    }
    
    current_Segment_View = [currentModule.viewForSegment_ARRAY objectAtIndex:0];
    [SegmentContainerView addSubview:current_Segment_View];
    
}






- (void)init_Module_GUI
{
    
    // modules
    moduleBasis* currentModule = [module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX];
    moduleBasis* nextModule = [module_ARRAY objectAtIndex:NEXT_MODULE_INDEX];
    
    VIEW_CURRENT_MODULE.image = currentModule.moduleIcon;
    
    if( CURRENT_MODULE_INDEX == NEXT_MODULE_INDEX )
    {
        VIEW_NEXT_MODULE.image = In_Use_Icon;
        BUTTON_MODULE_CHANGE.enabled = NO;
    }
    else
    {
        VIEW_NEXT_MODULE.image = nextModule.moduleIcon;
        BUTTON_MODULE_CHANGE.enabled = YES;
    }
    
}



- (void)setDefault
{
    int i, j;
    
    // Reset BPM
    BPM = 80;
    double timeFor_16beats = ( 60.0 / (double)BPM ) * 16.0;
    incrementFor_1frame = ( 1.0 / 60.0 ) / timeFor_16beats;
    
    // FADER
    FADER = 1.0f;
    
    // Reset Slot INDEX
    SLOT_INDEX = 0;
    
    // Reset Loop Length
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j< NUM_OF_MODULES ; j++ )
        {
            CURRENT_LOOP_POINT[i][j] = 0;
        }
    }
    
    // Reset Gesture
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {
            [self clearTap:(Byte)i moduleIndex:(short)j];
            [self clearLongPress:(Byte)i moduleIndex:(short)j];
            [self clearPan:(Byte)i moduleIndex:(short)j];
            [self clearPinch:(Byte)i moduleIndex:(short)j];
        }
    }
    
    // Reset Module Parameters
    for( i = 0 ; i < [module_ARRAY count] ; i++ )
    {
        [[module_ARRAY objectAtIndex:i] setDefault];
    }
    
    
    
    [self initGUI];
    [self init_Module_GUI];
    [self initSegmentGUI];
}

@end