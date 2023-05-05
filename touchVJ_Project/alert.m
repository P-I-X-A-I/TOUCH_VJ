
#import "mainController.h"

@implementation mainController ( ALERT_VIEW )

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"clicked button at index %d", buttonIndex);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //NSLog(@"did dismiss with button index %d", buttonIndex);
    
    NSString* titleString = alertView.title;
    
    // Reset Parameter
    if( [titleString isEqualToString:@"Parameter Reset"] && buttonIndex == 1 )
    {
        [self setDefault];
    }
    
    
    // save data
    else if( [titleString isEqualToString:@"Save"] && buttonIndex != 0 )
    {
        // save data
        NSLog(@"save %d", buttonIndex);
        [self save:(Byte)buttonIndex];
        
        // set save data Information to alertView button
        NSCalendar* calender = [NSCalendar currentCalendar];        
        unsigned int unitFlags = NSYearCalendarUnit |
                                 NSMonthCalendarUnit |
                                 NSDayCalendarUnit |
                                 NSHourCalendarUnit |
                                 NSMinuteCalendarUnit |
                                 NSSecondCalendarUnit;
        
        NSDateComponents* compo = [calender components:unitFlags fromDate:[NSDate date]];
        NSString* dateString = [NSString stringWithFormat:@"( %d.%d.%d %d:",
                                                        [compo year]-2000,
                                                        [compo month],
                                                        [compo day],
                                                        [compo hour]
                                                                        ];
        NSString* dateStringWithMinute;
        if( [compo minute ] < 10 )
        {
            dateStringWithMinute = [NSString stringWithFormat:@"%@0%d )", dateString, [compo minute] ];
        }
        else
        {
            dateStringWithMinute = [NSString stringWithFormat:@"%@%d )", dateString, [compo minute] ];
        }
        
        NSLog(@"%@", dateStringWithMinute);
        
        NSUserDefaults* userDefs = [NSUserDefaults standardUserDefaults];
        [userDefs setBool:YES forKey:[NSString stringWithFormat:@"Slot_%d_saved", buttonIndex]];
        [userDefs setObject:dateStringWithMinute forKey:[NSString stringWithFormat:@"saveDate_%d", buttonIndex]];
        [userDefs synchronize];
    }
    
    
    
    // load data
    else if( [titleString isEqualToString:@"Load"] && buttonIndex != 0 )
    {
        NSString* buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
        
        if ( [buttonTitle isEqualToString:@"not saved"] )
        {
            NSLog(@"save data isn't exist");
        }
        else
        {
            NSLog(@"load %d", buttonIndex);
            [self load:(Byte)buttonIndex];
        }
    }
    
    
    // delete save data
    else if( [titleString isEqualToString:@"Delete Saved Data"] && buttonIndex != 0 )
    {
        NSUserDefaults* userDefs = [NSUserDefaults standardUserDefaults];
        
        [userDefs setBool:NO forKey:@"Slot_1_saved"];
        [userDefs setBool:NO forKey:@"Slot_2_saved"];
        [userDefs setBool:NO forKey:@"Slot_3_saved"];
    }
    
    [alertView release];
    
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    //NSLog(@"alert view cancelled");
    [alertView release];
}

@end