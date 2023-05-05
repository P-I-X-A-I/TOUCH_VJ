#import "M02_FontBit.h"

@implementation M02_FontBit (ACTION)

- (IBAction)slider_color:(UISlider*)sender
{
    Byte tag = [sender tag];
    float value = [sender value];
    
    switch (tag)
    {
        case 0:
            Point_HSB[CURRENT_SLOT][0] = value;
            break;
        case 1:
            Point_HSB[CURRENT_SLOT][1] = value;
            break;
        case 2:
            Point_HSB[CURRENT_SLOT][2] = value;
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
    
    
    if( tag <= 2 )
    {
        UIColor* tempColor = [UIColor colorWithHue:Point_HSB[CURRENT_SLOT][0]
                                        saturation:Point_HSB[CURRENT_SLOT][1]
                                        brightness:Point_HSB[CURRENT_SLOT][2] alpha:1.0];
        
        const CGFloat* components = CGColorGetComponents(tempColor.CGColor);
        
        Point_Color[CURRENT_SLOT][0] = *components; components++;
        Point_Color[CURRENT_SLOT][1] = *components; components++;
        Point_Color[CURRENT_SLOT][2] = *components;
    }
    else
    {
        UIColor* tempColor = [UIColor colorWithHue:BG_HSB[CURRENT_SLOT][0]
                                        saturation:BG_HSB[CURRENT_SLOT][1]
                                        brightness:BG_HSB[CURRENT_SLOT][2] alpha:1.0];
        
        const CGFloat* components = CGColorGetComponents(tempColor.CGColor);
        
        BG_Color[CURRENT_SLOT][0] = *components; components++;
        BG_Color[CURRENT_SLOT][1] = *components; components++;
        BG_Color[CURRENT_SLOT][2] = *components;
    }
}
@end