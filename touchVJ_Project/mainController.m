//
//  mainController.m
//  touchVJ_Project
//
//  Created by 渡辺 圭介 on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mainController.h"


@implementation mainController

@synthesize dispLink;
@synthesize CurrentMode;

@synthesize TableViewCell_ARRAY;

- (id)init
{
    self = [super init];
    
    int i, j, k, l;
    
// random seed
    srandom(time(NULL));
    srand(time(NULL));

// model & language check
    modelName = [[NSString alloc] initWithString:[UIDevice currentDevice].model];
    NSLog(@"%@", modelName);
    NSProcessInfo* processInfo = [NSProcessInfo processInfo];
    int CPUs = (int)[processInfo processorCount];
    
    if( [modelName isEqualToString:@"iPad"] && CPUs == 2 )
    {
        iPad_model_No = 2;
        NSLog(@"this is iPad 2");
        deviceName = [[NSString alloc] initWithString:@"iPad2"];
    }
    else if( [modelName isEqualToString:@"iPad"] && CPUs == 1 )
    {
        iPad_model_No = 1;
        NSLog(@"this is NOT iPad 2");
        deviceName = [[NSString alloc] initWithString:@"iPad"];
    }
    
    
// UserDefault
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* langArray = [defs objectForKey:@"AppleLanguages"];
    language = [langArray objectAtIndex:0];
    NSLog(@"language : %@", language);

    
    
    
// register screen connect notification
    NSNotificationCenter* DNCenter = [NSNotificationCenter defaultCenter];
    
    [DNCenter addObserver:self 
                 selector:@selector(screenConnected:)
                     name:UIScreenDidConnectNotification
                   object:nil];
    
    [DNCenter addObserver:self
                 selector:@selector(screenDisconnected:)
                     name:UIScreenDidDisconnectNotification
                   object:nil];
    
    [DNCenter addObserver:self
                 selector:@selector(screenModeChanged:)
                     name:UIScreenModeDidChangeNotification
                   object:nil];
    

    
    //  0:640*480 1: 800*600 2:1024*768 3:mirror **************************************

    ScreenMode_ARRAY = nil;
    TableViewCell_ARRAY = [[NSMutableArray alloc] init];
    
    
    Ext_View = nil;
    Ext_Window = nil;
    
    NSArray* screenArray = [UIScreen screens];
    
    
    // check if extMonitor is already connected
    BOOL isDisplayConnected;
    
        if( [screenArray count] > 1 )
        { isDisplayConnected = YES; }
        else
        { isDisplayConnected = NO; }

    [self updateScreenDataSource:isDisplayConnected];
    
    // *******************************************************

// FPS
    if (iPad_model_No == 1)
    {
        isFPS_60 = YES;
    }
    else
    {
        isFPS_60 = YES;
    }
        FPS_30_Switch = NO;

    
// shader
    isFBO_ExtraMonitor = isRBO_ExtraMonitor = -1;
    
    
// Board Vertex & TexCoord
    boardVertex[0][0] = -1.0f;  boardVertex[0][1] = 1.0f;   boardVertex[0][2] = 0.0f;   boardVertex[0][3] = 1.0;
    boardVertex[1][0] = -1.0f;  boardVertex[1][1] = -1.0f;   boardVertex[1][2] = 0.0f;   boardVertex[1][3] = 1.0;
    boardVertex[2][0] = 1.0f;  boardVertex[2][1] = 1.0f;   boardVertex[2][2] = 0.0f;   boardVertex[2][3] = 1.0;
    boardVertex[3][0] = 1.0f;  boardVertex[3][1] = -1.0f;   boardVertex[3][2] = 0.0f;   boardVertex[3][3] = 1.0;
    
    boardTexCoord[0][0] = 0.0f;  boardTexCoord[0][1] = 0.875f;
    boardTexCoord[1][0] = 0.0f;  boardTexCoord[1][1] = 0.125f;
    boardTexCoord[2][0] = 1.0f;  boardTexCoord[2][1] = 0.875f;
    boardTexCoord[3][0] = 1.0f;  boardTexCoord[3][1] = 0.125f;
    
    
// universal status
    CurrentMode = TITLE_MODE;
    BPM = 80;
    BPM_COUNTER = 0.0;
    FADER = 1.0;
    
    double timeFor_16beats = ( 60.0 / (double)BPM ) * 16.0;
    incrementFor_1frame = ( 1.0 / 60.0 ) / timeFor_16beats;
    
    CurrentTempo = 0;
    
    SLOT_INDEX = 0;
    
    
    for( i = 0 ; i < 5 ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {
                CURRENT_LOOP_POINT[i][j] = 0;
        }
    }
    
    // timeline drawing data
    for( i = 0 ; i < 17 ; i++ )
    {
        timeLine[i*2][0] = timeLine[i*2 + 1][0] = (((1.0/16.0)*i)-0.5)*1.8;
        timeLine[i*2][1] = 0.91;
        timeLine[i*2 + 1][1] = 0.89;
    }
    
    for( i = 0 ; i < 34 ; i++ )
    {
        timeLine[i][2] = 0.0;
        timeLine[i][3] = 1.0;
    }
    
    for( i = 0 ; i < 17 ; i++ )
    {
        double temp = 1.0 / 16.0;
        TempoPoint[i] = temp*i;
    }
    
    for( i = 0 ; i < 4 ; i++ )
    {
        timeLineBar[i][2] = 0.0;
        timeLineBar[i][3] = 1.0;
    }
    
    timeLineBarAnimation = 0.005;

    BeatINDEX_64 = 255;
    BeatINDEX_128 = 255;
    BeatINDEX_256 = 255;
    isBeatFirst_64 = YES;
    isBeatFirst_128 = YES;
  
    
    
    
// Gesture Recording
    
    // tap
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {  
            for( k = 0 ; k < 64 ; k++ )
            {
                State_Tap[i][j][k] = NO;
                Value_Tap[i][j][k][0] = Value_Tap[i][j][k][1] = 0.0;
            }
        }
    }
    
    
    // longpress
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {
            for( k = 0 ; k < MAX_LONGPRESS_POINT ; k++)
            {
                for( l = 0 ; l < 64 ; l++ )
                {
                    State_LongPress[i][j][k][l] = NO;
                }
                
            Value_LongPress[i][j][k][0] = Value_LongPress[i][j][k][1] = -20.0f; 
           }
        LongPress_INDEX[i][j] = 0;
        }
    }
    
    isLongPressed = NO;
    
    
    // pan
    
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {
            for( k = 0 ; k < POINTS_OF_PAN ; k++ )
            {
                State_Pan[i][j][k] = NO;
                Value_Pan[i][j][k][0] = 0.0f;
                Value_Pan[i][j][k][1] = 0.0f;
                Value_Pan[i][j][k][2] = 0.0f;
                Value_Pan[i][j][k][3] = 0.0f;
                Value_Pan[i][j][k][4] = 0.0f;
                Value_Pan[i][j][k][5] = 0.0f;
                Value_Pan[i][j][k][6] = 0.0f;
                
                isPanHead[i][j][k] = 0;
            }// k
            
            isPanHead[i][j][0] = 1;
            isPanHead[i][j][POINTS_OF_PAN-1] = 2;
        }// j
    }//i
        
    isPan = NO;
    
    
    // pinch
    isPinch = NO;
    
    for( i = 0 ; i < NUM_OF_SLOT ; i++ )
    {
        for( j = 0 ; j < NUM_OF_MODULES ; j++ )
        {
            for( k = 0 ; k < 128 ; k++ )
            {
                State_Pinch[i][j][k] = NO;
                Value_Pinch_Center[i][j][k][0] = Value_Pinch_Center[i][j][k][1] = 0.0f;
                Value_Pinch_Radius[i][j][k] = 0.0f;
                Value_Pinch_Scale[i][j][k] = 0.0f;
                Value_Pinch_Velocity[i][j][k] = 0.0f; 
            
                isPinchHead[i][j][k] = 0;
            }
            isPinchHead[i][j][0] = 1;
            isPinchHead[i][j][127] = 2;
        }
    }
    
   
    
    
// Gesture Drawing    
    
    // Tap
    for( i = 0 ; i < 19 ; i++ )
    {
        double radian = 20.0 * i * 0.0174532925; // deg to PI
        CircleVertex[i][0] = sin(radian);
        CircleVertex[i][1] = cos(radian)*1.33333;
    }
    
    for( i = 0 ; i < 19 ; i++ )
    {
        TapVertex[i][0] = 0.0f;
        TapVertex[i][1] = 0.0f;
        TapVertex[i][2] = 0.0f;
        TapVertex[i][3] = 1.0f;
    }
    
    TapColor[0] = 1.0f;  TapColor[1] = 1.0f;  TapColor[2] = 1.0f;  TapColor[3] = 0.0f;
    TapAnimation = 0.0f;
    
    
    // LongPress
    for( i = 0 ; i < MAX_LONGPRESS_POINT ; i++ )
    {
        for (j = 0 ; j < 4 ; j++) 
        {
            LongPressVertex[i][j][0] = 0.0f;
            LongPressVertex[i][j][1] = 0.0f;
            LongPressVertex[i][j][2] = 0.0f;
            LongPressVertex[i][j][3] = 1.0f;
        }
    }
    
    LongPressColor[0] = 0.3f;
    LongPressColor[1] = 1.0f;
    LongPressColor[2] = 0.3f;
    LongPressColor[3] = 1.0f;
    LongPressAnimation = 1.0;
    
    LongPressElements[0] = 0;   LongPressElements[1] = 1;
    LongPressElements[2] = 1;   LongPressElements[3] = 2;
    LongPressElements[4] = 2;   LongPressElements[5] = 3;
    LongPressElements[6] = 3;   LongPressElements[7] = 0;
    
    LongPressElements[8] = 4;   LongPressElements[9] = 5;
    LongPressElements[10] = 5;   LongPressElements[11] = 6;
    LongPressElements[12] = 6;   LongPressElements[13] = 7;
    LongPressElements[14] = 7;   LongPressElements[15] = 4;
    LongPressElements[16] = 4;   LongPressElements[17] = 6;
    
    LongPressElements[18] = 8;   LongPressElements[19] = 9;
    LongPressElements[20] = 9;   LongPressElements[21] = 10;
    LongPressElements[22] = 10;   LongPressElements[23] = 11;
    LongPressElements[24] = 11;   LongPressElements[25] = 8;
    LongPressElements[26] = 11;   LongPressElements[27] = 9;
    
    LongPressElements[28] = 12;   LongPressElements[29] = 13;
    LongPressElements[30] = 13;   LongPressElements[31] = 14;
    LongPressElements[32] = 14;   LongPressElements[33] = 15;
    LongPressElements[34] = 15;   LongPressElements[35] = 12;
    LongPressElements[36] = 12;   LongPressElements[37] = 14;
    LongPressElements[38] = 13;   LongPressElements[39] = 15;
    
    
    
    // Pan
        
    for( i = 0 ; i < 7 ; i++ )
    {
        last_Value_Pan[i] = 0.0f;
    }
    
    for( i = 0 ; i < 5 ; i++ )
    {
        for( j = 0 ; j < 2 ; j++ )
        {
            Vertex_Pan[i][j][0] = -20.0f;
            Vertex_Pan[i][j][1] = -20.0f;
            Vertex_Pan[i][j][2] = 0.0f;
            Vertex_Pan[i][j][3] = 1.0f;
            
            Color_Pan[i][j][0] = 0.3f;
            Color_Pan[i][j][1] = 1.0f;
            Color_Pan[i][j][2] = 1.0f;
            Color_Pan[i][j][3] = 0.0f;
        }
    }    

    
    last_Pinch_Center[0] = 0.0f;
    last_Pinch_Center[1] = 0.0f;
    last_Pinch_Radius = 0.0f;
    last_Pinch_Scale = 0.0f;
    last_Pinch_Velocity = 0.0f;
    
    act_Pinch_Scale = 0.0;
    act_Pinch_Center[0] = act_Pinch_Center[1] = 0.0f;
    
    return self;
}


- (void)awakeFromNib
{
    int i;
    NSLog(@"mainController AFN");
    
    // add Subview to window
    [window addSubview:titleView];
    
// set gesture recognizer
    [self setGestureRecognizerToGLESView];

// setup OpenGLES 
    [self setGLESContext];
    [self readBoardShaderSource];
    [self setBuffers];
    
// init and set modules
    CURRENT_MODULE_INDEX = 0;
    NEXT_MODULE_INDEX = 1;
    
    In_Use_Icon = [UIImage imageNamed:@"In_Use_icon.png"];
    
    // module array *************************************************
    module_ARRAY = [[NSMutableArray alloc] init];
    [module_ARRAY addObject:[[M01_Cube alloc] initWithDeviceName:deviceName]];
    [module_ARRAY addObject:[[M02_FontBit alloc] initWithDeviceName:deviceName]];
    [module_ARRAY addObject:[[M03_Rainbow alloc] initWithDeviceName:deviceName]];
    [module_ARRAY addObject:[[M04_Kaleidoscope alloc] initWithDeviceName:deviceName]];
    [module_ARRAY addObject:[[M05_Structure alloc] initWithDeviceName:deviceName]];
    [module_ARRAY addObject:[[M06_Plants alloc] initWithDeviceName:deviceName]];
    // module array *************************************************
    
// create displayLink
    dispLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(draw:)];
    [dispLink setFrameInterval:1];
    [dispLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    dispLink.paused = YES;
    
    [mainViewController setPtrToDisplayLink:dispLink];
    [storeViewController setPtrToDisplayLink:dispLink];
    [titleViewController setPtrToDisplayLink:dispLink];
    
    // init GUI
    [self initGUI];
    [self init_Module_GUI];
    [self initSegmentGUI];
    
    for( i = 0 ; i < [module_ARRAY count] ; i++ )
    {
        [[module_ARRAY objectAtIndex:i] setCurrentSlotIndex:CURRENT_MODULE_INDEX];
    }
    
    [self setGUI_Image];
    
}



@end
