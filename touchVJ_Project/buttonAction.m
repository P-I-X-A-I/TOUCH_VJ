
#import "mainController.h"

@implementation mainController ( BUTTON_ACTION )

- (IBAction)button_start:(id)sender
{
    startButton.enabled = NO;
    storeButton.enabled = NO;
    
    [UIView beginAnimations:@"title_FadeOutToMain" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadeInMainView:)];
    
    titleView.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (IBAction)button_store:(id)sender
{
    startButton.enabled = NO;
    storeButton.enabled = NO;
    
    [UIView beginAnimations:@"title_FadeOut" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadeInStoreView:)];
    
    titleView.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (IBAction)button_returnFromStore:(id)sender
{
    returnFromStoreButton.enabled = NO;

    [UIView beginAnimations:@"store_FadeOut" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadeInTitleView:)];
    
    storeView.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (IBAction)button_returnFromMain:(id)sender
{
    [self pan_Cancel];
    [self pinch_Cancel];
    [self longPress_Cancel];
    
    
    returnFromMainButton.enabled = NO;
    dispLink.paused = YES;
    
    [self deleteExtWindow];
    
    [UIView beginAnimations:@"main_FadeOut" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(backFromMainView:)];
    
    mainViewController.view.alpha = 0.0;
    
    [UIView commitAnimations];
}





// Change to Store
- (void)fadeInStoreView:(NSString*)animationID
{
    storeView.alpha = 0.0;
    returnFromStoreButton.enabled = NO;
    [titleView removeFromSuperview];
    [window addSubview:storeView];
    
    CurrentMode = STORE_MODE;
    
    [UIView beginAnimations:@"store_FadeIn" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(storeViewFadeInFinished:)];
    
    storeView.alpha = 1.0;
    
    [UIView commitAnimations];
}

- (void)storeViewFadeInFinished:(NSString*)animationID
{
    returnFromStoreButton.enabled = YES;
    
    BOOL isStoreOK = [SKPaymentQueue canMakePayments];
    
    if (isStoreOK) {
        
    }
    else
    {
        NSString* tempString;
        if( [language isEqualToString:@"ja"] )
        {
            tempString = [NSString stringWithFormat:@"設定によりApp内での購入が無効にされています。設定パネル内の機能制限の項目からApp内での購入を有効にして下さい。"];
        }
        else
        {
            tempString = [NSString stringWithFormat:@"In-App Purchases is not allowed. Please check your Settings Panel and turn the In-App Purchases switch ON."];
        }
        
        ALERT_VIEW = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                message:tempString 
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
        
        [ALERT_VIEW show];
    }
}
// Change to Store







// Return From Store
- (void)fadeInTitleView:(NSString *)animationID
{
    titleView.alpha = 0.0;
    startButton.enabled = NO;
    storeButton.enabled = NO;
    
    [storeView removeFromSuperview];
    [window addSubview:titleView];
    
    CurrentMode = TITLE_MODE;
    
    [UIView beginAnimations:@"title_FadeIn" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(titleViewFadeInFinished:)];
    
    titleView.alpha = 1.0;
    
    [UIView commitAnimations];
}

- (void)titleViewFadeInFinished:(NSString*)animationID
{
    startButton.enabled = YES;
    storeButton.enabled = YES;
}
// Return From Store



// Change to main
- (void)fadeInMainView:(NSString*)animationID
{
    mainViewController.view.alpha = 0.0;
    CurrentMode = DRAW_MODE;
    
    [titleView removeFromSuperview];
    [window addSubview:mainViewController.view];
    [mainViewController.view setFrame:CGRectMake(0.0f,
                                                 0.0f,
                                                 mainViewController.view.frame.size.width,
                                                 mainViewController.view.frame.size.height
                                                 )];
    
    
    // send to module "becomeCurrent"
    [[module_ARRAY objectAtIndex:CURRENT_MODULE_INDEX] becomeCurrent];
    
    BOOL isDisplayConnected;
    Byte ScreenNum = [[UIScreen screens] count];
    
    if( ScreenNum > 1 )
    { isDisplayConnected = YES; }
    else
    { isDisplayConnected = NO; }
    
    
    if( isDisplayConnected )
    {
        // check screenmode
        [self updateScreenDataSource:YES];
        
        // Deselect cell
        NSIndexPath* tempPath = [TABLEVIEW_MONITOR_RESOLUTION indexPathForSelectedRow];
        if( tempPath != nil )
        {
            [TABLEVIEW_MONITOR_RESOLUTION deselectRowAtIndexPath:tempPath animated:NO];
        }
        
        int COUNT = [TableViewCell_ARRAY count]-1;
        UITableViewCell* lastCell = [TableViewCell_ARRAY lastObject];
        lastCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [TABLEVIEW_MONITOR_RESOLUTION selectRowAtIndexPath:[NSIndexPath indexPathForRow:COUNT inSection:0]
                                                  animated:NO
                                            scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        [self updateScreenDataSource:NO];
    }
    
    
        [UIView beginAnimations:@"mainViewFadeIn" context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(mainViewFadeInFinished:)];
    
        mainViewController.view.alpha = 1.0;
    
        [UIView commitAnimations];
}

- (void)mainViewFadeInFinished:(NSString*)animationID
{
    
    dispLink.paused = NO;
    returnFromMainButton.enabled = YES;
    
     
    
    NSLog(@"mainViewFadeIn Finished");
}
// Change to main


// Return from main
- (void)backFromMainView:(NSString*)animationID
{
    // clear ext monitor
    glBindFramebuffer(GL_FRAMEBUFFER, FBO_ExtraMonitor);
    glBindRenderbuffer(GL_RENDERBUFFER, RBO_ExtraMonitor);
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [eaglContext presentRenderbuffer:GL_RENDERBUFFER];
    
    // delete Ext window
   // [self deleteExtWindow];
    
    // Check selected IndexPath or not selected
    NSIndexPath* tempPath = [TABLEVIEW_MONITOR_RESOLUTION indexPathForSelectedRow];
    
    // delete checkmark
    int i;
    for( i = 0 ; i < [TableViewCell_ARRAY count] ; i++ )
    {
        UITableViewCell* tempCell = [TableViewCell_ARRAY objectAtIndex:i];
        tempCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // deselect cell and select last mirror cell
    if( tempPath != nil )
    {
        
        // deselect
        [TABLEVIEW_MONITOR_RESOLUTION deselectRowAtIndexPath:tempPath animated:NO];
        
        // select last cell
        int COUNT = [TableViewCell_ARRAY count]-1;
        UITableViewCell* lastCell = [TableViewCell_ARRAY lastObject];
        lastCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [TABLEVIEW_MONITOR_RESOLUTION selectRowAtIndexPath:[NSIndexPath indexPathForRow:COUNT inSection:0]
                                                  animated:NO
                                            scrollPosition:UITableViewScrollPositionNone]; 
    }
    
    titleView.alpha = 0.0;
    [mainViewController.view removeFromSuperview];
    [window addSubview:titleView];
    
    CurrentMode = TITLE_MODE;
    
    [UIView beginAnimations:@"fadeInTitleFromMain" context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(returnFromMainViewFinished:)];
    
    titleView.alpha = 1.0;
    
    [UIView commitAnimations];
}

- (void)returnFromMainViewFinished:(NSString*)animationID
{
    storeButton.enabled = YES;
    startButton.enabled = YES;
}




- (IBAction)button_exit:(id)sender
{
    int i;
    
    [dispLink release];
    
    // Modules dealloc
    
    for( i = 0 ; i < [module_ARRAY count] ; i++ )
    {
        [[module_ARRAY objectAtIndex:i] release];
    }
    
    // created object dealloc
    [modelName release];
    
    glDeleteProgram(BOARD_POBJ);
    glDeleteProgram(GESTURE_POBJ);
    glDeleteProgram(GESTURE_2_POBJ);
    
    glDeleteFramebuffers(1, &FBO_Moniter);
    glDeleteFramebuffers(1, &FBO_ExtraMonitor);
    glDeleteFramebuffers(1, &FBO_Rendering);
    
    glDeleteTextures(1, &TEX_Rendering);
    glDeleteTextures(1, &TEX_Depth);
    glDeleteRenderbuffers(1, &RBO_Monitor);
    glDeleteRenderbuffers(1, &RBO_ExtraMonitor);
    
    
    [appDelegate dealloc];
    exit(0);
}


@end