#import "mainController.h"

@implementation mainController ( SCREEN )

- (void)screenConnected:(NSNotification*)notification
{
    //*****************************//
    [self stopAllUserInteraction:YES];
    //*****************************//

        NSLog(@"ScreenConnected");
            
        [self updateScreenDataSource:YES];
    
    // select mirror cell
    int count = [TableViewCell_ARRAY count]-1;
    UITableViewCell* lastCell = [TableViewCell_ARRAY lastObject];
    
    lastCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [TABLEVIEW_MONITOR_RESOLUTION selectRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0]
                                              animated:NO
                                        scrollPosition:UITableViewScrollPositionNone];
    
    //*****************************//   
    [self stopAllUserInteraction:NO];
    //*****************************//
}

- (void)screenDisconnected:(NSNotification*)notification
{
    //*****************************//
    [self stopAllUserInteraction:YES];
    //*****************************//
    
    
    NSLog(@"ScreenDisConnected");
    
    [self updateScreenDataSource:NO];
    [self deleteExtWindow];
    
    
    //*****************************//   
    [self stopAllUserInteraction:NO];
    //*****************************//    
}

- (void)screenModeChanged:(NSNotification*)notification
{
    //*****************************//
    [self stopAllUserInteraction:YES];
    //*****************************//
    
        NSLog(@"ScreenModeChanged");

    //*****************************//   
    [self stopAllUserInteraction:NO];
    //*****************************//
}




- (void)makeExtWindow:(NSIndexPath*)indexPath
{
    [self setGestureEnabled:NO];
    TABLEVIEW_MONITOR_RESOLUTION.userInteractionEnabled = NO;
    
    NSArray* ScreenArray = [UIScreen screens];
    UIScreen* Ext_Screen;
    UIScreen* main_Screen = [UIScreen mainScreen];
    UIScreenMode* Ext_ScreenMode;
    
    [self deleteExtWindow];
    
    if( [[ScreenArray objectAtIndex:0] isEqual:main_Screen] )
    {
        Ext_Screen = [ScreenArray objectAtIndex:1];
    }
    else
    {
        Ext_Screen = [ScreenArray objectAtIndex:0];
    }
    
    ScreenMode_ARRAY = Ext_Screen.availableModes;
    Ext_ScreenMode = [ScreenMode_ARRAY objectAtIndex:[indexPath indexAtPosition:1]];
    
    Ext_Screen.currentMode = Ext_ScreenMode;
    
    // make window
    Ext_Window = [[UIWindow alloc] init];
    Ext_Window.screen = Ext_Screen;
    
    Ext_View = [[glesView alloc] initWithFrame:CGRectMake(0.0f,
                                                          0.0f, 
                                                          Ext_ScreenMode.size.width,
                                                          Ext_ScreenMode.size.height
                                                          )];
    
    [Ext_Window addSubview:Ext_View];
    [Ext_Window makeKeyAndVisible];
    
        // create framebuffer
        
        CAEAGLLayer* eaglLayer = (CAEAGLLayer*)Ext_View.layer;
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
                                        kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
                                        nil];
        
        glGenFramebuffers(1, &FBO_ExtraMonitor);
        glGenRenderbuffers(1, &RBO_ExtraMonitor);
        
        isFBO_ExtraMonitor = FBO_ExtraMonitor;
        isRBO_ExtraMonitor = RBO_ExtraMonitor;
    
        glBindFramebuffer(GL_FRAMEBUFFER, FBO_ExtraMonitor);
        glBindRenderbuffer(GL_RENDERBUFFER, RBO_ExtraMonitor);
    
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, RBO_ExtraMonitor);
        [eaglContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)Ext_View.layer];
        
        int status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        NSLog(@"Ext FBO status %x (8cd5)", status);
        
        glBindFramebuffer(GL_FRAMEBUFFER, 0);

    TABLEVIEW_MONITOR_RESOLUTION.userInteractionEnabled = YES;
    [self setGestureEnabled:YES];
    
    isExtDraw = YES;
    
}

- (void)deleteExtWindow
{
    
    if( isRBO_ExtraMonitor != -1 )
    {
        glDeleteRenderbuffers(1, &RBO_ExtraMonitor);
        isRBO_ExtraMonitor = -1;
    }
    if( isFBO_ExtraMonitor != -1 )
    {
        glDeleteFramebuffers(1, &FBO_ExtraMonitor);
        isFBO_ExtraMonitor = -1;
    }
   
    if( Ext_View != nil )
    {
        [Ext_View removeFromSuperview];
        [Ext_View release];
    }
    
    if( Ext_Window != nil )
    {
        [Ext_Window release];
    }
    
    Ext_Window = nil;
    Ext_View = nil;
    
    isExtDraw = NO;
}



- (void)updateScreenDataSource:(BOOL)yn
{
    int i;
    
    NSArray* screenArray = [UIScreen screens];
    UIScreen* mainScreen = [UIScreen mainScreen];
    UIScreen* Ext_Screen;
    
    // set nil to ScreenMode_ARRAY
    ScreenMode_ARRAY = nil;
    
    [TableViewCell_ARRAY removeAllObjects];
    
    if (yn) // is DisplayConnected YES
    {
        if( [[screenArray objectAtIndex:0] isEqual:mainScreen] )
        { Ext_Screen = [screenArray objectAtIndex:1]; }
        else
        { Ext_Screen = [screenArray objectAtIndex:0]; }
     
        
        ScreenMode_ARRAY = Ext_Screen.availableModes;
        
        // create tableview cell
        for( i = 0 ; i < [ScreenMode_ARRAY count] ; i++ )
        {
            UITableViewCell* tempCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            
            UIScreenMode* tempScreenMode = [ScreenMode_ARRAY objectAtIndex:i];
            CGFloat width = tempScreenMode.size.width;
            CGFloat height = tempScreenMode.size.height;
            
            tempCell.textLabel.text = [NSString stringWithFormat:@"%d x %d", (int)width, (int)height ];
            tempCell.textLabel.textColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
            tempCell.textLabel.font = [UIFont systemFontOfSize:14.0f];
            tempCell.selectionStyle = UITableViewCellSelectionStyleGray;
            tempCell.accessoryType = UITableViewCellAccessoryNone;
            
            [TableViewCell_ARRAY addObject:tempCell];
            [tempCell release];
        }
        
        // Add mirror( noVideoOut ) Cell
        UITableViewCell* mirrorCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        mirrorCell.textLabel.textColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
        mirrorCell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        mirrorCell.selectionStyle = UITableViewCellSelectionStyleGray;
        mirrorCell.accessoryType = UITableViewCellAccessoryNone;
        
        if( iPad_model_No == 2 )
        { mirrorCell.textLabel.text = @"mirroring"; }
        else if( iPad_model_No == 1 )
        { mirrorCell.textLabel.text = @"Video Out off"; }
        
        
        [TableViewCell_ARRAY addObject:mirrorCell];
        [mirrorCell release];
        
        TABLEVIEW_MONITOR_RESOLUTION.allowsSelection = YES;
        if( [TableViewCell_ARRAY count] > 10 )
        {
            TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = YES;
        }
        else
        {
            TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = NO;
        }
        
    }// yn YES
    else
    {
        UITableViewCell* tempCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        tempCell.textLabel.text = @"no monitor is connected.";
        tempCell.textLabel.textColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
        tempCell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        
        [TableViewCell_ARRAY addObject:tempCell];
        [tempCell release];
        
        TABLEVIEW_MONITOR_RESOLUTION.allowsSelection = NO;
        TABLEVIEW_MONITOR_RESOLUTION.scrollEnabled = NO;
    }// yn NO
    
    NSLog(@"update table view source %@", TableViewCell_ARRAY);
    
    // update message to tableViewController1
    [TABLEVIEW_MONITOR_RESOLUTION reloadData];
}



@end