#import "mainController.h"

@implementation mainController ( MODULE_GUI )

- (IBAction)button_Module_Prev:(UIButton*)sender
{
    
    NEXT_MODULE_INDEX--;
    
    if( NEXT_MODULE_INDEX < 0 )
    {
        NEXT_MODULE_INDEX = 0;
    }
    
    [self init_Module_GUI];
}
- (IBAction)button_Module_Next:(UIButton*)sender
{
    int num_of_modules = [module_ARRAY count];
    
    NEXT_MODULE_INDEX++;
    
    if( NEXT_MODULE_INDEX > num_of_modules-1 )
    {
        NEXT_MODULE_INDEX = num_of_modules-1;
    }
    
    [self init_Module_GUI];
}

- (IBAction)button_Module_Change:(UIButton*)sender
{
    [self pan_Cancel];
    [self longPress_Cancel];
    [self pinch_Cancel];
    
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] becomeBackground];
    
    CURRENT_MODULE_INDEX = NEXT_MODULE_INDEX;
    
    [[ module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] becomeCurrent];
    [[ module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] setCurrentSlotIndex:SLOT_INDEX];
    
    [self initGUI];
    [self init_Module_GUI];
    [self initSegmentGUI];
    
    
    IMAGEVIEW_MODULE_FRAME.alpha = 1.0;
    [UIView beginAnimations:@"lihten" context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    IMAGEVIEW_MODULE_FRAME.alpha = 0.4;
    
    [UIView commitAnimations];
}





@end