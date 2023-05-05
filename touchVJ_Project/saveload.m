
#import "mainController.h"

@implementation mainController ( SAVE_LOAD )

- (IBAction)button_save:(UIButton*)sender
{
    NSString* alertMessage;
    
    if( [language isEqualToString:@"ja"] )
    {
        alertMessage = [NSString stringWithString:@"現在のパラメータ設定を保存します。よろしいですか？"];
    }
    else
    {
        alertMessage = [NSString stringWithString:@"Current Parameter is saved. OK?"];
    }
    
    ALERT_VIEW = [[UIAlertView alloc] initWithTitle:@"Save"
                                            message:alertMessage
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:nil];
    // check is saved
    BOOL isSaved[3];
    NSUserDefaults* userDefs = [NSUserDefaults standardUserDefaults];
    
    isSaved[0] = [userDefs boolForKey:@"Slot_1_saved"];
    isSaved[1] = [userDefs boolForKey:@"Slot_2_saved"];
    isSaved[2] = [userDefs boolForKey:@"Slot_3_saved"];
    
    
    // add Button and titles
    int i;
    for( i = 0 ; i < 3 ; i++ )
    {
        if( isSaved[i] )
        {
            NSString* dateString = [userDefs objectForKey:[NSString stringWithFormat:@"saveDate_%d", i+1]];
            [ALERT_VIEW addButtonWithTitle:[NSString stringWithFormat:@"Save:%d %@", i+1, dateString]];
        }
        else
        {
            [ALERT_VIEW addButtonWithTitle:[NSString stringWithFormat:@"not saved", i+1]];
        }
    }
    
        
    [ALERT_VIEW show];
}

- (IBAction)button_load:(UIButton*)sender
{
    NSString* alertMessage;
    
    if( [language isEqualToString:@"ja"] )
    {
        alertMessage = [NSString stringWithString:@"パラメータ設定をロードします。よろしいですか？"];
    }
    else
    {
        alertMessage = [NSString stringWithString:@"Parameter is loaded. OK?"];
    }
    
    ALERT_VIEW = [[UIAlertView alloc] initWithTitle:@"Load"
                                            message:alertMessage
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:nil];
    
    // check is saved
    BOOL isSaved[3];
    NSUserDefaults* userDefs = [NSUserDefaults standardUserDefaults];
    
    isSaved[0] = [userDefs boolForKey:@"Slot_1_saved"];
    isSaved[1] = [userDefs boolForKey:@"Slot_2_saved"];
    isSaved[2] = [userDefs boolForKey:@"Slot_3_saved"];
    
    int i;
    for( i = 0 ; i < 3 ; i++ )
    {
        if( isSaved[i] )
        {
            NSString* dateString = [userDefs objectForKey:[NSString stringWithFormat:@"saveDate_%d", i+1]];
            [ALERT_VIEW addButtonWithTitle:[NSString stringWithFormat:@"Load:%d %@", i+1, dateString]];
        }
        else
        {
            [ALERT_VIEW addButtonWithTitle:[NSString stringWithFormat:@"not saved", i+1]];
        }
    }
    
    
    // set button enabled and alpha
    NSArray* tempArray = [ALERT_VIEW subviews];
    UIButton* BUTTON_SLOT_1 = [tempArray objectAtIndex:3];
    UIButton* BUTTON_SLOT_2 = [tempArray objectAtIndex:4];
    UIButton* BUTTON_SLOT_3 = [tempArray objectAtIndex:5];
    
    if( isSaved[0] == NO )
    {
        BUTTON_SLOT_1.enabled = NO;
        BUTTON_SLOT_1.alpha = 0.5;
    }
    
    if( isSaved[1] == NO )
    {
        BUTTON_SLOT_2.enabled = NO;
        BUTTON_SLOT_2.alpha = 0.5;
    }
    
    if( isSaved[2] == NO )
    {
        BUTTON_SLOT_3.enabled = NO;
        BUTTON_SLOT_3.alpha = 0.5;
    }
    
    [ALERT_VIEW show];
}






- (void)save:(Byte)num
{
    [self stopAllUserInteraction:YES];
    
    int i;
    
    NSMutableData* saveData = [NSMutableData dataWithLength:0];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
    
    // BPM
    [archiver encodeInt:(int)BPM forKey:[NSString stringWithFormat:@"touchVJ_BPM_%d", num]];
    // FADER
    [archiver encodeFloat:FADER forKey:[NSString stringWithFormat:@"touchVJ_FADER_%d", num]];
    
    //CURRENT_LOOP_POINT[NUM_OF_SLOT][NUM_OF_MODULES]
    [archiver encodeBytes:(const uint8_t *)&CURRENT_LOOP_POINT[0][0]
                   length:sizeof(CURRENT_LOOP_POINT)
                   forKey:[NSString stringWithFormat:@"CURRENT_LOOP_POINT_%d", num]];

    NSLog(@"save CURRENT_LOOP_POINT : %lu", sizeof(CURRENT_LOOP_POINT));
    
    // State_Tap[NUM_OF_SLOT][NUM_OF_MODULES][64]
    [archiver encodeBytes:(const uint8_t *)&State_Tap[0][0][0]
                   length:(NSUInteger)sizeof(State_Tap) 
                   forKey:[NSString stringWithFormat:@"State_Tap_%d", num]];
    
    NSLog(@"save State_Tap : %lu", sizeof(State_Tap));
    
    
    // Value_Tap[NUM_OF_SLOT][NUM_OF_MODULES][64][2]
    [archiver encodeBytes:(const uint8_t *)&Value_Tap[0][0][0][0]
                   length:(NSUInteger)sizeof(Value_Tap)
                   forKey:[NSString stringWithFormat:@"Value_Tap_%d", num]];

    NSLog(@"save Value_Tap : %lu", sizeof(Value_Tap));
    
    
    //State_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][4][64];
    [archiver encodeBytes:(const uint8_t *)&State_LongPress[0][0][0][0]
                   length:(NSUInteger)sizeof(State_LongPress)
                   forKey:[NSString stringWithFormat:@"State_LongPress_%d", num]];
    
    NSLog(@"save State_LongPress : %lu", sizeof(State_LongPress));
    
    
    //Value_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][4][2];
    [archiver encodeBytes:(const uint8_t *)&Value_LongPress[0][0][0][0]
                   length:(NSUInteger)sizeof(Value_LongPress)
                   forKey:[NSString stringWithFormat:@"Value_LongPress_%d", num]];
     
    NSLog(@"save Value_LongPress : %lu", sizeof(Value_LongPress));
    
    
    //LongPress_INDEX[SLOT_INDEX][NUM_OF_MODULES];
    [archiver encodeBytes:(const uint8_t *)&LongPress_INDEX[0][0]
                   length:(NSUInteger)sizeof(LongPress_INDEX)
                   forKey:[NSString stringWithFormat:@"LongPress_INDEX_%d", num]];
    
    NSLog(@"save LongPress_INDEX : %lu", sizeof(LongPress_INDEX));
    
    
    // State_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN]
    [archiver encodeBytes:(const uint8_t *)&State_Pan[0][0][0]
                   length:(NSUInteger)sizeof(State_Pan)
                   forKey:[NSString stringWithFormat:@"State_Pan_%d", num]];
    
    NSLog(@"save State_Pan : %lu", sizeof(State_Pan));
    
    
    // Value_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN][7]
    [archiver encodeBytes:(const uint8_t *)&Value_Pan[0][0][0][0]
                   length:(NSUInteger)sizeof(Value_Pan)
                   forKey:[NSString stringWithFormat:@"Value_Pan_%d", num]];
    
    NSLog(@"save Value_Pan : %lu", sizeof(Value_Pan));
    
    
    //isPanHead[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN]
    [archiver encodeBytes:(const uint8_t *)&isPanHead[0][0][0]
                   length:(NSUInteger)sizeof(isPanHead)
                   forKey:[NSString stringWithFormat:@"isPanHead_%d", num]];
    
    NSLog(@"save isPanHead : %lu", sizeof(isPanHead));
    
    
    // State_Pinch[5][NUM_OF_MODULES][128];
    [archiver encodeBytes:(const uint8_t *)&State_Pinch[0][0][0]
                   length:(NSUInteger)sizeof(State_Pinch)
                   forKey:[NSString stringWithFormat:@"State_Pinch_%d", num]];
    
    NSLog(@"save State_Pinch : %lu", sizeof(State_Pinch));
    
    
    // Value_Pinch_Center[5][NUM_OF_MODULES][128][2];
    [archiver encodeBytes:(const uint8_t *)&Value_Pinch_Center[0][0][0][0]
                   length:(NSUInteger)sizeof(Value_Pinch_Center)
                   forKey:[NSString stringWithFormat:@"Value_Pinch_Center_%d", num]];
    
    NSLog(@"save Value_Pinch_Center : %lu", sizeof(Value_Pinch_Center));
    
    
    //Value_Pinch_Radius[NUM_OF_SLOT][NUM_OF_MODULES][128];//
    [archiver encodeBytes:(const uint8_t *)&Value_Pinch_Radius[0][0][0]
                   length:(NSUInteger)sizeof(Value_Pinch_Radius)
                   forKey:[NSString stringWithFormat:@"Value_Pinch_Radius_%d", num]];
    
    NSLog(@"save Value_Pinch_Radius : %lu", sizeof(Value_Pinch_Radius));
    
    
    //Value_Pinch_Scale[NUM_OF_SLOT][NUM_OF_MODULES][128];//
    [archiver encodeBytes:(const uint8_t *)&Value_Pinch_Scale[0][0][0]
                   length:(NSUInteger)sizeof(Value_Pinch_Scale)
                   forKey:[NSString stringWithFormat:@"Value_Pinch_Scale_%d", num]];
    
    NSLog(@"Value_Pinch_Scale : %lu", sizeof(Value_Pinch_Scale));
    
    
    //Value_Pinch_Velocity[NUM_OF_SLOT][NUM_OF_MODULES][128];//
    [archiver encodeBytes:(const uint8_t *)&Value_Pinch_Velocity[0][0][0]
                   length:(NSUInteger)sizeof(Value_Pinch_Velocity)
                   forKey:[NSString stringWithFormat:@"Value_Pinch_Velocity_%d", num]];
    
    NSLog(@"Value_Pinch_Velocity : %lu", sizeof(Value_Pinch_Velocity));
    
    
    //Byte isPinchHead[5][NUM_OF_MODULES][128];
    [archiver encodeBytes:(const uint8_t *)&isPinchHead[0][0][0]
                   length:(NSUInteger)sizeof(isPinchHead)
                   forKey:[NSString stringWithFormat:@"isPinchHead_%d", num]];
    
    NSLog(@"isPinchHead : %lu", sizeof(isPinchHead));
    
    
    
    for( i = 0 ; i < [module_ARRAY count] ; i++ )
    {
        [[module_ARRAY objectAtIndex:i] saveModule:archiver saveslot:num];
    }
    
    
    [archiver finishEncoding];
    [archiver release];
    
    NSArray* savePathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                             NSUserDomainMask, 
                                                             YES);
    NSString* savePath = [NSString stringWithFormat:@"%@/saveData_%d.sav", [savePathArray objectAtIndex:0], num];
    
    BOOL result = [saveData writeToFile:savePath atomically:YES];
      
    NSLog(@"%@ : %d", savePath, result);

    
    [self stopAllUserInteraction:NO];
}







- (void)load:(Byte)num
{
    [self stopAllUserInteraction:YES];
    
    int i, iter;
    NSUInteger LENGTH;
    
    NSArray* loadPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                                 NSUserDomainMask, 
                                                                    YES);
    NSString* loadPath;
    NSData* loadData;
    
    
    for( i = 0 ; i < [loadPathArray count] ; i++ )
    {
        loadPath = [NSString stringWithFormat:@"%@/saveData_%d.sav", [loadPathArray objectAtIndex:i], num];
        loadData = [NSData dataWithContentsOfFile:loadPath];
        
        if( loadData != nil )
        {
            NSLog(@"loadData is Not NULL");
            break;
        }
        else
        {
            NSLog(@"loadData is NULL");
        }
    }
    
    if( loadData != nil )
    {
        NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
    
        // BPM
        BPM = (Byte)[unArchiver decodeIntForKey:[NSString stringWithFormat:@"touchVJ_BPM_%d", num]];
        NSLog(@"load BPM : %d", BPM);
        // FADER
        FADER = (GLfloat)[unArchiver decodeFloatForKey:[NSString stringWithFormat:@"touchVJ_FADER_%d", num]];
        NSLog(@"load FADER : %f", FADER);
    
        
        
        
        
        //CURRENT_LOOP_POINT[NUM_OF_SLOT][NUM_OF_MODULES]
        const uint8_t* CURRENT_LOOP_POINT_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"CURRENT_LOOP_POINT_%d", num]
                                                                     returnedLength:&LENGTH];
        
        Byte* CURRENT_LOOP_POINT_Copy = (Byte*)malloc(sizeof(CURRENT_LOOP_POINT));
        Byte* CURRENT_LOOP_POINT_Free = CURRENT_LOOP_POINT_Copy;
        Byte* CURRENT_LOOP_POINT_Assignment = &CURRENT_LOOP_POINT[0][0];
        iter = sizeof(CURRENT_LOOP_POINT) / sizeof(Byte);
        
        NSLog(@"load CURRENT_LOOP_POINT : %d %d", iter, LENGTH);
        
        memcpy(CURRENT_LOOP_POINT_Copy, CURRENT_LOOP_POINT_decodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *CURRENT_LOOP_POINT_Assignment = *CURRENT_LOOP_POINT_Copy;
            CURRENT_LOOP_POINT_Assignment++;
            CURRENT_LOOP_POINT_Copy++;
        }
    
        free(CURRENT_LOOP_POINT_Free);
        
        
        
        
        
        // State Tap[NUM_OF_SLOT][NUM_OF_MODULES][64]
        const uint8_t* State_Tap_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"State_Tap_%d", num] 
                                                            returnedLength:&LENGTH];
        
        BOOL* State_Tap_Copy = (BOOL*)malloc(sizeof(State_Tap));
        BOOL* State_Tap_Free = State_Tap_Copy;
        BOOL* State_Tap_Assignment = &State_Tap[0][0][0];
        iter = sizeof(State_Tap) / sizeof(BOOL);
        
        NSLog(@"load State_Tap : %d %d", iter, LENGTH);

        memcpy(State_Tap_Copy, State_Tap_decodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *State_Tap_Assignment = *State_Tap_Copy;
            State_Tap_Assignment++;
            State_Tap_Copy++;
        }

        free(State_Tap_Free);
        
        
        
        
        
        // Value_Tap[NUM_OF_SLOT][NUM_OF_MODULES][64][2]
        const uint8_t* Value_Tap_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Tap_%d", num] 
                                                            returnedLength:&LENGTH];
        GLfloat* Value_Tap_Copy = (GLfloat*)malloc(sizeof(Value_Tap));
        GLfloat* Value_Tap_Free = Value_Tap_Copy;
        GLfloat* Value_Tap_Assignment = &Value_Tap[0][0][0][0];
        iter = sizeof(Value_Tap) / sizeof(GLfloat);
        
        NSLog(@"load : Value_Tap %d %d", iter, LENGTH );
        
        memcpy(Value_Tap_Copy, Value_Tap_decodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Tap_Assignment = *Value_Tap_Copy;
            Value_Tap_Assignment++;
            Value_Tap_Copy++;
        }
                
        free(Value_Tap_Free);
        
    
        // State_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][4][64]
        const uint8_t* State_LongPress_decodePtr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"State_LongPress_%d", num]
                                                                  returnedLength:&LENGTH];
        
        BOOL* State_LongPress_Copy = (BOOL*)malloc(sizeof(State_LongPress));
        BOOL* State_LongPress_Free = State_LongPress_Copy;
        BOOL* State_LongPress_Assignment = &State_LongPress[0][0][0][0];
        iter = sizeof(State_LongPress) / sizeof(BOOL);
        
        NSLog(@"load State_LongPress : %d %d", iter, LENGTH);

        memcpy(State_LongPress_Copy, State_LongPress_decodePtr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *State_LongPress_Assignment = *State_LongPress_Copy;
            State_LongPress_Assignment++;
            State_LongPress_Copy++;
        }
        
        free(State_LongPress_Free);
        
        
        
        
        
        
        //Value_LongPress[NUM_OF_SLOT][NUM_OF_MODULES][4][2]
        const uint8_t* Value_LongPress_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_LongPress_%d", num]
                                                                  returnedLength:&LENGTH];
        
        GLfloat* Value_LongPress_Copy = (GLfloat*)malloc(sizeof(Value_LongPress));
        GLfloat* Value_LongPress_Free = Value_LongPress_Copy;
        GLfloat* Value_LongPress_Assignment = &Value_LongPress[0][0][0][0];
        iter = sizeof(Value_LongPress) / sizeof(GLfloat);
        
        NSLog(@"load Value_LongPress : %d %d", iter, LENGTH);

        memcpy(Value_LongPress_Copy, Value_LongPress_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_LongPress_Assignment = *Value_LongPress_Copy;
            Value_LongPress_Assignment++;
            Value_LongPress_Copy++;
        }
        
        free(Value_LongPress_Free);
        
        
    
        //LongPress_INDEX[SLOT_INDEX][NUM_OF_MODULES];
        const uint8_t* LongPress_INDEX_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"LongPress_INDEX_%d", num]
                                                                  returnedLength:&LENGTH];
        
        Byte* LongPress_INDEX_Copy = (Byte*)malloc(sizeof(LongPress_INDEX));
        Byte* LongPress_INDEX_Free = LongPress_INDEX_Copy;
        Byte* LongPress_INDEX_Assignment = &LongPress_INDEX[0][0];
        iter = sizeof(LongPress_INDEX) / sizeof(Byte);
        
        NSLog(@"load LongPress_INDEX : %d %d", iter, LENGTH);
        
        memcpy(LongPress_INDEX_Copy, LongPress_INDEX_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *LongPress_INDEX_Assignment = *LongPress_INDEX_Copy;
            LongPress_INDEX_Assignment++;
            LongPress_INDEX_Copy++;
        }
        
        free( LongPress_INDEX_Free );
        
        
        
        
        
        // State_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN]
        const uint8_t* State_Pan_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"State_Pan_%d", num]
                                                            returnedLength:&LENGTH];
        
        BOOL* State_Pan_Copy = (BOOL*)malloc( sizeof(State_Pan) );
        BOOL* State_Pan_Free = State_Pan_Copy;
        BOOL* State_Pan_Assignment = &State_Pan[0][0][0];
        iter = sizeof(State_Pan) / sizeof(BOOL);
        
        NSLog(@"load State_Pan : %d %d", iter, LENGTH);
        
        memcpy(State_Pan_Copy, State_Pan_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *State_Pan_Assignment = *State_Pan_Copy;
            State_Pan_Assignment++;
            State_Pan_Copy++;
        }
        
        free(State_Pan_Free);
        
        // Value_Pan[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN][7]
        const uint8_t* Value_Pan_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Pan_%d", num]
                                                            returnedLength:&LENGTH];
        
        GLfloat* Value_Pan_Copy = (GLfloat*)malloc( sizeof(Value_Pan));
        GLfloat* Value_Pan_Free = Value_Pan_Copy;
        GLfloat* Value_Pan_Assignment = &Value_Pan[0][0][0][0];
        iter = sizeof(Value_Pan) / sizeof(GLfloat);
        
        NSLog(@"load Value_Pan : %d %d", iter, LENGTH);
        
        memcpy(Value_Pan_Copy, Value_Pan_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Pan_Assignment = *Value_Pan_Copy;
            Value_Pan_Assignment++;
            Value_Pan_Copy++;
        }
        
        free(Value_Pan_Free);
        
        
        //isPanHead[NUM_OF_SLOT][NUM_OF_MODULES][POINTS_OF_PAN
        const uint8_t* isPanHead_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"isPanHead_%d", num]
                                                            returnedLength:&LENGTH];
        
        Byte* isPanHead_Copy = (Byte*)malloc( sizeof(isPanHead) );
        Byte* isPanHead_Free = isPanHead_Copy;
        Byte* isPanHead_Assignment = &isPanHead[0][0][0];
        iter = sizeof(isPanHead) / sizeof(Byte);
        
        NSLog(@"load isPanHead : %d %d", iter, LENGTH);
        
        memcpy(isPanHead_Copy, isPanHead_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *isPanHead_Assignment = *isPanHead_Copy;
            isPanHead_Assignment++;
            isPanHead_Copy++;
        }
        
        free(isPanHead_Free);
        
        
        
        
        // State_Pinch[5][NUM_OF_MODULES][128];
        const uint8_t* State_Pinch_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"State_Pinch_%d", num]
                                                              returnedLength:&LENGTH];
        
        BOOL* State_Pinch_Copy = (BOOL*)malloc( sizeof(State_Pinch) );
        BOOL* State_Pinch_Free = State_Pinch_Copy;
        BOOL* State_Pinch_Assignment = &State_Pinch[0][0][0];
        iter = sizeof(State_Pinch) / sizeof(BOOL);
        
        NSLog(@"load State_Pinch : %d %d", iter, LENGTH);
        
        memcpy(State_Pinch_Copy, State_Pinch_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *State_Pinch_Assignment = *State_Pinch_Copy;
            State_Pinch_Assignment++;
            State_Pinch_Copy++;
        }
        
        free(State_Pinch_Free);
        
        
        
        
        // Value_Pinch_Center[5][NUM_OF_MODULES][128][2];
        const uint8_t* Value_Pinch_Center_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Pinch_Center_%d", num]
                                                                     returnedLength:&LENGTH];
        
        GLfloat* Value_Pinch_Center_Copy = (GLfloat*)malloc(sizeof(Value_Pinch_Center));
        GLfloat* Value_Pinch_Center_Free = Value_Pinch_Center_Copy;
        GLfloat* Value_Pinch_Center_Assignment = &Value_Pinch_Center[0][0][0][0];
        iter = sizeof(Value_Pinch_Center) / sizeof(GLfloat);
        
        NSLog(@"load Value_Pinch_Center : %d %d", iter, LENGTH);
        
        memcpy(Value_Pinch_Center_Copy, Value_Pinch_Center_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Pinch_Center_Assignment = *Value_Pinch_Center_Copy;
            Value_Pinch_Center_Assignment++;
            Value_Pinch_Center_Copy++;
        }
        
        free(Value_Pinch_Center_Free);
        
        
        
        
        //Value_Pinch_Radius[NUM_OF_SLOT][NUM_OF_MODULES][128];//
        const uint8_t* Value_Pinch_Radius_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Pinch_Radius_%d", num]
                                                                     returnedLength:&LENGTH];
        
        GLfloat* Value_Pinch_Radius_Copy = (GLfloat*)malloc(sizeof(Value_Pinch_Radius));
        GLfloat* Value_Pinch_Radius_Free = Value_Pinch_Radius_Copy;
        GLfloat* Value_Pinch_Radius_Assignment = &Value_Pinch_Radius[0][0][0];
        iter = sizeof(Value_Pinch_Radius) / sizeof(GLfloat);
        
        NSLog(@"load Value_Pinch_Radius : %d %d", iter, LENGTH);
        
        memcpy(Value_Pinch_Radius_Copy, Value_Pinch_Radius_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Pinch_Radius_Assignment = *Value_Pinch_Radius_Copy;
            Value_Pinch_Radius_Assignment++;
            Value_Pinch_Radius_Copy++;
        }
        
        free(Value_Pinch_Radius_Free);
        
        
        //Value_Pinch_Scale[NUM_OF_SLOT][NUM_OF_MODULES][128];//
        const uint8_t* Value_Pinch_Scale_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Pinch_Scale_%d", num]
                                                                    returnedLength:&LENGTH];
        
        GLfloat* Value_Pinch_Scale_Copy = (GLfloat*)malloc(sizeof(Value_Pinch_Scale));
        GLfloat* Value_Pinch_Scale_Free = Value_Pinch_Scale_Copy;
        GLfloat* Value_Pinch_Scale_Assignment = &Value_Pinch_Scale[0][0][0];
        iter = sizeof(Value_Pinch_Scale) / sizeof(GLfloat);
        
        NSLog(@"load Value_Pinch_Scale : %d %d", iter, LENGTH);
        
        memcpy(Value_Pinch_Scale_Copy, Value_Pinch_Scale_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Pinch_Scale_Assignment = *Value_Pinch_Scale_Copy;
            Value_Pinch_Scale_Assignment++;
            Value_Pinch_Scale_Copy++;
        }
        
        free(Value_Pinch_Scale_Free);
        
        
        //Value_Pinch_Velocity[NUM_OF_SLOT][NUM_OF_MODULES][128];//
        const uint8_t* Value_Pinch_Velocity_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"Value_Pinch_Velocity_%d", num]
                                                                       returnedLength:&LENGTH];
        
        GLfloat* Value_Pinch_Velocity_Copy = (GLfloat*)malloc(sizeof(Value_Pinch_Velocity));
        GLfloat* Value_Pinch_Velocity_Free = Value_Pinch_Velocity_Copy;
        GLfloat* Value_Pinch_Velocity_Assignment = &Value_Pinch_Velocity[0][0][0];
        iter = sizeof(Value_Pinch_Velocity) / sizeof(GLfloat);
        
        NSLog(@"load Value_Pinch_Velocity : %d %d", iter, LENGTH);
        
        memcpy(Value_Pinch_Velocity_Copy, Value_Pinch_Velocity_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *Value_Pinch_Velocity_Assignment = *Value_Pinch_Velocity_Copy;
            Value_Pinch_Velocity_Assignment++;
            Value_Pinch_Velocity_Copy++;
        }
        
        free(Value_Pinch_Velocity_Free);
        
        
        //Byte isPinchHead[5][NUM_OF_MODULES][128];
        const uint8_t* isPinchHead_decodeptr = [unArchiver decodeBytesForKey:[NSString stringWithFormat:@"isPinchHead_%d", num]
                                                              returnedLength:&LENGTH];
        
        Byte* isPinchHead_Copy = (Byte*)malloc(sizeof(isPinchHead));
        Byte* isPinchHead_Free = isPinchHead_Copy;
        Byte* isPinchHead_Assignment = &isPinchHead[0][0][0];
        iter = sizeof(isPinchHead) / sizeof(Byte);
        
        NSLog(@"load isPinchHead : %d %d", iter, LENGTH);
        
        memcpy(isPinchHead_Copy, isPinchHead_decodeptr, LENGTH);
        
        for( i = 0 ; i < iter ; i++ )
        {
            *isPinchHead_Assignment = *isPinchHead_Copy;
            isPinchHead_Assignment++;
            isPinchHead_Copy++;
        }
        
        free(isPinchHead_Free);
        
        
        
        
        
        
        
        for( i = 0 ; i < [module_ARRAY count] ; i++ )
        {
            [[module_ARRAY objectAtIndex:i] loadModule:unArchiver loadslot:num];
        }
    
        [unArchiver finishDecoding];
        [unArchiver release];
    
    }// if data is not nil
        
    [self stopAllUserInteraction:NO];
    
    [self initGUI];
    [self initSegmentGUI];
    [self init_Module_GUI];
}



- (IBAction)button_DeleteSaveData:(UIButton*)sender
{
    NSString* alertMessage;
    
    if( [language isEqualToString:@"ja"] )
    {
        alertMessage = [NSString stringWithString:@"セーブデータを消去します。よろしいですか？"];
    }
    else
    {
        alertMessage = [NSString stringWithString:@"All Saved data are Deleted. OK?"];
    }
    
    ALERT_VIEW = [[UIAlertView alloc] initWithTitle:@"Delete Saved Data"
                                            message:alertMessage
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"OK", nil];
    
    [ALERT_VIEW show];
}

@end