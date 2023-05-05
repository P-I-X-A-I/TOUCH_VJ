
#import "mainController.h"

@implementation mainController ( UTILITY )

- (void)stopAllUserInteraction:(BOOL)yn
{
    if (yn)
    {
        dispLink.paused = YES;
        
        // gesture
        [self setGestureEnabled:NO];
        
        // GUI leftTOp
        SEGMENT_SLOT_INDEX.enabled = NO;
        SEGMENT_CLEAR_GESTURE.enabled = NO;
        SEGMENT_LOOP_POINT.enabled = NO;
        
        // GUI Center
        BUTTON_CUE.enabled = NO;
        BUTTON_MODULE_PREV.enabled = NO;
        BUTTON_MODULE_NEXT.enabled = NO;
        BUTTON_MODULE_CHANGE.enabled = NO;
        SLIDER_BPM.enabled = NO;
        SLIDER_FADER.enabled = NO;
        
        // moduleParam & Options
        SEGMENT_PRAM_AND_OPTION.enabled = NO;
        
        TABLEVIEW_MONITOR_RESOLUTION.alpha = 0.5f;
        TABLEVIEW_MONITOR_RESOLUTION.userInteractionEnabled = NO;
        
        SEGMENT_FPS.enabled = NO;
        
        BUTTON_RESET_PARAM.enabled = NO;
        BUTTON_SAVE.enabled = NO;
        BUTTON_EXIT.enabled = NO;
        
    }
    else
    {
        // moduleParam & Options
        SEGMENT_PRAM_AND_OPTION.enabled = YES;
        
        TABLEVIEW_MONITOR_RESOLUTION.userInteractionEnabled = YES;
        TABLEVIEW_MONITOR_RESOLUTION.alpha = 1.0f;
        
        SEGMENT_FPS.enabled = YES;

        BUTTON_RESET_PARAM.enabled = YES;
        BUTTON_SAVE.enabled = YES;
        BUTTON_EXIT.enabled = YES;

        // GUI Center
        BUTTON_CUE.enabled = YES;
        BUTTON_MODULE_PREV.enabled = YES;
        BUTTON_MODULE_NEXT.enabled = YES;
        
        if( CURRENT_MODULE_INDEX == NEXT_MODULE_INDEX)
        {
            BUTTON_MODULE_CHANGE.enabled = NO;
        }
        else
        {
            BUTTON_MODULE_CHANGE.enabled = YES;
        }
        
        SLIDER_FADER.enabled = YES;
        SLIDER_BPM.enabled = YES;
        
        // GUI leftTOp
        SEGMENT_LOOP_POINT.enabled = YES;
        SEGMENT_CLEAR_GESTURE.enabled = YES;
        SEGMENT_SLOT_INDEX.enabled = YES;
        
        // gesture
        [self setGestureEnabled:YES];
        
        
        dispLink.paused = NO;
    }
}





- (void)setGUI_Image
{
    NSLog(@"set GUI image");
        
    UIImage* button_reset_image = [UIImage imageNamed:@"button_reset_normal.png"];
    [BUTTON_RESET_PARAM setBackgroundImage:button_reset_image forState:UIControlStateNormal];
    [BUTTON_RESET_PARAM setBackgroundImage:button_reset_image forState:UIControlStateDisabled];
    
    UIImage* button_save_image =[UIImage imageNamed:@"button_save_normal.png"];
    [BUTTON_SAVE setBackgroundImage:button_save_image forState:UIControlStateNormal];
    [BUTTON_SAVE setBackgroundImage:button_save_image forState:UIControlStateDisabled];
    
    UIImage* button_load_image = [UIImage imageNamed:@"button_load_normal.png"];
    [BUTTON_LOAD setBackgroundImage:button_load_image forState:UIControlStateNormal];
    [BUTTON_LOAD setBackgroundImage:button_load_image forState:UIControlStateDisabled];
    
    UIImage* button_exit_image = [UIImage imageNamed:@"button_exit_normal.png"];
    [BUTTON_EXIT setBackgroundImage:button_exit_image forState:UIControlStateNormal];
    [BUTTON_EXIT setBackgroundImage:button_exit_image forState:UIControlStateDisabled];
    
    SEGMENT_SLOT_INDEX.alpha = 0.6;
    SEGMENT_LOOP_POINT.alpha = 0.6;
    SEGMENT_CLEAR_GESTURE.alpha = 0.6;
    
    SEGMENT_PRAM_AND_OPTION.alpha = 0.8;
    
    IMAGEVIEW_MODULE_FRAME.alpha = 0.4;
}

@end