
#import "M01_Cube.h"

@implementation M01_Cube (ACTION)

- (IBAction)button_Afterimage:(UIButton*)sender
{
    isAction_Afterimage = sender.tracking;
}
- (IBAction)button_Noise:(UIButton*)sender
{
    isAction_Noise = sender.tracking;
}
- (IBAction)button_Stop:(UIButton*)sender
{
    isAction_Stop = sender.tracking;
}


- (IBAction)slider_color:(UISlider*)sender
{
    int tag = sender.tag;
    float value = [sender value];
    
    switch (tag) {
        case 0:
            Obj_HSB[CURRENT_SLOT][0] = value;
            break;
        case 1:
            Obj_HSB[CURRENT_SLOT][1] = value;
            break;
        case 2:
            Obj_HSB[CURRENT_SLOT][2] = value;
            break;
        case 3:
            BG_HSB[CURRENT_SLOT][0] = value;
            break;
        case 4:
            BG_HSB[CURRENT_SLOT][1] = value;
            break;
        case 5:
            BG_HSB[CURRENT_SLOT][2] = value;
            break;
        default:
            break;
    }
    
    
    if( tag <=2 )
    {
        UIColor* tempColor = [UIColor colorWithHue:Obj_HSB[CURRENT_SLOT][0] 
                                        saturation:Obj_HSB[CURRENT_SLOT][1]
                                        brightness:Obj_HSB[CURRENT_SLOT][2] alpha:1.0f];
        
        const CGFloat* components = CGColorGetComponents(tempColor.CGColor);
        
        Obj_Color[CURRENT_SLOT][0] = *components;   components++;
        Obj_Color[CURRENT_SLOT][1] = *components;   components++;
        Obj_Color[CURRENT_SLOT][2] = *components;
    }
    else
    {
        UIColor* tempColor = [UIColor colorWithHue:BG_HSB[CURRENT_SLOT][0]
                                        saturation:BG_HSB[CURRENT_SLOT][1]
                                        brightness:BG_HSB[CURRENT_SLOT][2]
                                             alpha:1.0f];
        
        const CGFloat* components = CGColorGetComponents(tempColor.CGColor);
        
        BG_Color[CURRENT_SLOT][0] = *components;    components++;
        BG_Color[CURRENT_SLOT][1] = *components;    components++;
        BG_Color[CURRENT_SLOT][2] = *components;
    }
}

@end